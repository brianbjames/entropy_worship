import express from "express";
import cors from "cors";
import { chromium } from "playwright";

const app = express();
app.use(cors());

const PORT = process.env.PORT || 3000;

const AREA_CONFIG = {
  sanfrancisco: {
    path: "us/sanfrancisco",
    geoHint: "San Francisco Bay Area, California, USA",
  },
  losangeles: {
    path: "us/losangeles",
    geoHint: "Los Angeles, California, USA",
  },
  newyork: {
    path: "us/newyork",
    geoHint: "New York, New York, USA",
  },
  london: {
    path: "uk/london",
    geoHint: "London, UK",
  },
  berlin: {
    path: "de/berlin",
    geoHint: "Berlin, Germany",
  },
};

const geocodeCache = new Map();
const eventCache = new Map();

function isIsoDate(value) {
  return /^\d{4}-\d{2}-\d{2}$/.test(value);
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function dedupeEvents(events) {
  const seen = new Set();

  return events.filter((event) => {
    const key = event.id || `${event.title}|${event.date}|${event.venueName}`;
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
}

function parseRaDate(text, fallbackYear) {
  const match = text.match(
    /\b(Mon|Tue|Wed|Thu|Fri|Sat|Sun),\s+(\d{1,2})\s+(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\b/i,
  );

  if (!match) return null;

  const monthMap = {
    jan: "01",
    feb: "02",
    mar: "03",
    apr: "04",
    may: "05",
    jun: "06",
    jul: "07",
    aug: "08",
    sep: "09",
    oct: "10",
    nov: "11",
    dec: "12",
  };

  const day = String(match[2]).padStart(2, "0");
  const month = monthMap[match[3].toLowerCase()];

  if (!month) return null;
  return `${fallbackYear}-${month}-${day}`;
}

function extractLocationFromLines(lines) {
  const idx = lines.findIndex((line) => /^Location$/i.test(line));
  if (idx >= 0 && lines[idx + 1]) {
    return lines[idx + 1].trim();
  }
  return "";
}

async function geocodeVenue(query, areaKey) {
  if (!query) {
    return { latitude: null, longitude: null };
  }

  const lower = query.toLowerCase();
  if (lower.includes("tba") || lower.includes("secret location")) {
    return { latitude: null, longitude: null };
  }

  const cacheKey = `${areaKey}|${query}`;
  if (geocodeCache.has(cacheKey)) {
    return geocodeCache.get(cacheKey);
  }

  const geoHint = AREA_CONFIG[areaKey]?.geoHint || "";
  const fullQuery = `${query}, ${geoHint}`;

  try {
    const url =
      "https://nominatim.openstreetmap.org/search?format=jsonv2&limit=1&q=" +
      encodeURIComponent(fullQuery);

    const res = await fetch(url, {
      headers: {
        "User-Agent": "rave-map-backend/1.0",
      },
    });

    if (!res.ok) {
      const out = { latitude: null, longitude: null };
      geocodeCache.set(cacheKey, out);
      return out;
    }

    const data = await res.json();

    const out =
      Array.isArray(data) && data[0]
        ? {
            latitude: Number(data[0].lat),
            longitude: Number(data[0].lon),
          }
        : { latitude: null, longitude: null };

    geocodeCache.set(cacheKey, out);
    return out;
  } catch (err) {
    console.error("Geocode failed:", query, err.message);
    const out = { latitude: null, longitude: null };
    geocodeCache.set(cacheKey, out);
    return out;
  }
}

async function scrapeResidentAdvisor({ area, start, end }) {
  const cfg = AREA_CONFIG[area];
  if (!cfg) {
    throw new Error("Unsupported area");
  }

  const cacheKey = `${area}|${start}|${end}`;
  const cached = eventCache.get(cacheKey);
  if (cached && Date.now() - cached.timestamp < 15 * 60 * 1000) {
    console.log("Returning cached events for", cacheKey);
    return cached.data;
  }

  const listingUrl = `https://ra.co/events/${cfg.path}?startDate=${encodeURIComponent(start)}`;
  console.log("RA listing URL:", listingUrl);

  const browser = await chromium.launch({
    headless: true,
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
  });

  try {
    const page = await browser.newPage({
      viewport: { width: 1440, height: 1200 },
      userAgent:
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36",
    });

    await page.goto(listingUrl, {
      waitUntil: "domcontentloaded",
      timeout: 60000,
    });

    await sleep(5000);

    const title = await page.title().catch(() => "");
    const bodyText = await page
      .locator("body")
      .innerText()
      .catch(() => "");
    const currentUrl = page.url();

    console.log("Page title:", title);
    console.log("Current URL:", currentUrl);
    console.log("Body text sample:", bodyText.slice(0, 1000));

    const hasCaptchaText =
      /enable JS and disable any ad blocker/i.test(bodyText) ||
      /captcha/i.test(bodyText) ||
      /access denied/i.test(bodyText) ||
      /verify you are human/i.test(bodyText);

    console.log("Has captcha text:", hasCaptchaText);

    const eventLinks = await page
      .locator('a[href^="/events/"]')
      .evaluateAll((anchors) =>
        anchors
          .map((a) => ({
            href: a.getAttribute("href") || "",
            text: (a.textContent || "").trim(),
          }))
          .filter((x) => x.href && x.text),
      )
      .catch((err) => {
        console.error("Failed reading event links:", err.message);
        return [];
      });

    console.log("Found raw event links:", eventLinks.length);
    console.log("First few raw links:", eventLinks.slice(0, 10));

    await page.close();

    if (hasCaptchaText) {
      console.log(
        "RA appears to be serving a challenge page. Returning empty result.",
      );
      return [];
    }

    const rawEvents = eventLinks
      .map((item) => {
        const match = item.href.match(/^\/events\/(\d+)/);
        if (!match) return null;

        const eventTitle = item.text.trim();
        if (!eventTitle || eventTitle.length < 4) return null;

        return {
          id: match[1],
          title: eventTitle,
          date: start,
          venueName: "",
          latitude: null,
          longitude: null,
          url: `https://ra.co/events/${match[1]}`,
          artists: [],
          source: "Resident Advisor",
        };
      })
      .filter(Boolean);

    const listingEvents = dedupeEvents(rawEvents).slice(0, 20);
    console.log("Deduped listing events:", listingEvents.length);

    for (const event of listingEvents) {
      try {
        console.log("Visiting event page:", event.url);

        const eventPage = await browser.newPage({
          viewport: { width: 1280, height: 1000 },
          userAgent:
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36",
        });

        await eventPage.goto(event.url, {
          waitUntil: "domcontentloaded",
          timeout: 45000,
        });

        await sleep(2500);

        const text = await eventPage
          .locator("body")
          .innerText()
          .catch(() => "");
        const lines = text
          .split("\n")
          .map((s) => s.trim())
          .filter(Boolean);

        const venueName = extractLocationFromLines(lines);
        if (venueName) {
          event.venueName = venueName;
        }

        const parsedDate = parseRaDate(text, start.slice(0, 4));
        if (parsedDate && parsedDate >= start && parsedDate <= end) {
          event.date = parsedDate;
        }

        await eventPage.close();

        if (event.venueName) {
          const geo = await geocodeVenue(event.venueName, area);
          event.latitude = geo.latitude;
          event.longitude = geo.longitude;
        }

        console.log("Event scraped:", {
          id: event.id,
          title: event.title,
          date: event.date,
          venueName: event.venueName,
          latitude: event.latitude,
          longitude: event.longitude,
        });

        await sleep(1100);
      } catch (err) {
        console.error("Event page scrape failed for:", event.url, err.message);
      }
    }

    const filtered = listingEvents.filter(
      (event) => event.date >= start && event.date <= end,
    );

    console.log("Filtered final events:", filtered.length);

    eventCache.set(cacheKey, {
      timestamp: Date.now(),
      data: filtered,
    });

    return filtered;
  } finally {
    await browser.close();
  }
}

function buildFallbackEvents(area, start, end) {
  if (area === "sanfrancisco") {
    return [
      {
        id: "fallback-1",
        title: "Fallback Test Rave",
        date: `${start}T22:00:00`,
        venueName: "Public Works",
        latitude: 37.7669,
        longitude: -122.422,
        url: "https://ra.co/",
        artists: ["DJ Example"],
        source: "Fallback",
      },
      {
        id: "fallback-2",
        title: "Fallback Warehouse Night",
        date: `${end}T23:30:00`,
        venueName: "The Great Northern",
        latitude: 37.7818,
        longitude: -122.4101,
        url: "https://ra.co/",
        artists: ["Artist A", "Artist B"],
        source: "Fallback",
      },
    ];
  }

  return [
    {
      id: "fallback-generic-1",
      title: "Fallback Event",
      date: `${start}T22:00:00`,
      venueName: "City Center",
      latitude: null,
      longitude: null,
      url: "https://ra.co/",
      artists: ["Test Artist"],
      source: "Fallback",
    },
  ];
}

app.get("/", (_req, res) => {
  res.send("Rave map backend is running.");
});

app.get("/api/ra-events", async (req, res) => {
  const area = String(req.query.area || "");
  const start = String(req.query.start || "");
  const end = String(req.query.end || "");

  if (!area || !start || !end) {
    return res.status(400).json({
      error: "Missing required query params: area, start, end",
    });
  }

  if (!isIsoDate(start) || !isIsoDate(end)) {
    return res.status(400).json({
      error: "Dates must be YYYY-MM-DD",
    });
  }

  if (!AREA_CONFIG[area]) {
    return res.status(400).json({
      error: "Unsupported area",
    });
  }

  try {
    const events = await scrapeResidentAdvisor({ area, start, end });

    if (!events.length) {
      console.log("No scraped events found. Returning fallback events.");
      return res.json(buildFallbackEvents(area, start, end));
    }

    return res.json(events);
  } catch (error) {
    console.error("API error:", error);

    return res.json(buildFallbackEvents(area, start, end));
  }
});

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
