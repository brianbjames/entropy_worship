import { chromium } from "playwright";
import { geocodeVenue } from "../utils/geocode.js";
import { dedupeEvents, inDateRange } from "../utils/normalize.js";

const AREA_CONFIG = {
  sanfrancisco: {
    path: "ca--san-francisco/events",
    geoHint: "San Francisco, California, USA",
  },
  //   losangeles: {
  //     path: "ca--los-angeles/events",
  //     geoHint: "Los Angeles, California, USA",
  //   },
  //   newyork: {
  //     path: "ny--new-york/events",
  //     geoHint: "New York, New York, USA",
  //   },
  //   london: {
  //     path: "greater-london--london/events",
  //     geoHint: "London, UK",
  //   },
  //   berlin: {
  //     path: "berlin--germany/events",
  //     geoHint: "Berlin, Germany",
  //   },
  //   chicago: {
  //     path: "il--chicago/events",
  //     geoHint: "Chicago, Illinois, USA",
  //   },
  //   miami: {
  //     path: "fl--miami/events",
  //     geoHint: "Miami, Florida, USA",
  //   },
  //   austin: {
  //     path: "tx--austin/events",
  //     geoHint: "Austin, Texas, USA",
  //   },
  //   seattle: {
  //     path: "wa--seattle/events",
  //     geoHint: "Seattle, Washington, USA",
  //   },
  //   amsterdam: {
  //     path: "amsterdam--netherlands/events",
  //     geoHint: "Amsterdam, Netherlands",
  //   },
};

const adapterCache = new Map();

function toArray(v) {
  return Array.isArray(v) ? v : v ? [v] : [];
}

function normalizeEvent(item) {
  const place = item.location || {};
  const addressObj = place?.address || {};

  const address = [
    addressObj.streetAddress,
    addressObj.addressLocality,
    addressObj.addressRegion,
    addressObj.postalCode,
    addressObj.addressCountry,
  ]
    .filter(Boolean)
    .join(", ");

  return {
    id: item.url,
    source: "Eventbrite",
    title: item.name || "Untitled",
    start: item.startDate || "",
    end: item.endDate || "",
    venueName: place?.name || "",
    address,
    latitude: null,
    longitude: null,
    url: item.url,
    artists: [],
    tags: [],
  };
}

async function geocodeEventsFast(events, geoHint) {
  const limited = events.slice(0, 12);

  for (const e of limited) {
    try {
      const geo = await geocodeVenue(e.address || e.venueName, geoHint);
      e.latitude = geo.latitude;
      e.longitude = geo.longitude;
    } catch {
      e.latitude = null;
      e.longitude = null;
    }
  }

  return events;
}

export async function fetchEventbriteEvents({
  area,
  start,
  end,
  debug = false,
}) {
  const cfg = AREA_CONFIG[area];
  if (!cfg) throw new Error("Unsupported area");

  const cacheKey = `${area}|${start}|${end}`;
  const cached = adapterCache.get(cacheKey);

  if (cached && Date.now() - cached.timestamp < 10 * 60 * 1000) {
    return debug
      ? {
          ok: cached.events.length > 0,
          count: cached.events.length,
          sample: cached.events.slice(0, 3),
          cached: true,
        }
      : cached.events;
  }

  const url = `https://www.eventbrite.com/d/${cfg.path}/`;

  const browser = await chromium.launch({
    headless: true,
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
  });

  let title = "";
  let currentUrl = "";
  let jsonLdCount = 0;

  try {
    const page = await browser.newPage({
      viewport: { width: 1280, height: 1200 },
      userAgent:
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36",
    });

    try {
      await page.goto(url, {
        waitUntil: "domcontentloaded",
        timeout: 20000,
      });
    } catch {
      // continue and try to read whatever loaded
    }

    await page.waitForTimeout(2500);

    title = await page.title().catch(() => "");
    currentUrl = page.url();

    const jsonLd = await page
      .locator('script[type="application/ld+json"]')
      .evaluateAll((nodes) => nodes.map((n) => n.textContent || ""))
      .catch(() => []);

    jsonLdCount = jsonLd.length;

    await page.close();

    const raw = [];

    for (const block of jsonLd) {
      try {
        const parsed = JSON.parse(block);

        for (const item of toArray(parsed)) {
          if (item?.["@type"] === "ItemList") {
            for (const e of item.itemListElement || []) {
              if (e.item?.["@type"] === "Event") {
                raw.push(e.item);
              }
            }
          } else if (item?.["@type"] === "Event") {
            raw.push(item);
          } else if (Array.isArray(item?.["@graph"])) {
            for (const node of item["@graph"]) {
              if (node?.["@type"] === "Event") {
                raw.push(node);
              }
            }
          }
        }
      } catch {
        // ignore malformed blocks
      }
    }

    let events = dedupeEvents(raw.map(normalizeEvent)).filter((e) =>
      inDateRange(e.start, start, end),
    );

    events = await geocodeEventsFast(events, cfg.geoHint);

    adapterCache.set(cacheKey, {
      timestamp: Date.now(),
      events,
    });

    if (debug) {
      return {
        ok: events.length > 0,
        count: events.length,
        sample: events.slice(0, 5),
        debug: {
          url,
          pageTitle: title,
          currentUrl,
          jsonLdCount,
          rawCount: raw.length,
          cached: false,
        },
      };
    }

    return events;
  } finally {
    await browser.close();
  }
}
