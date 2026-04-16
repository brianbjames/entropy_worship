import { chromium } from "playwright";
import { geocodeVenue } from "../utils/geocode.js";
import { dedupeEvents, inDateRange } from "../utils/normalize.js";

const AREA_CONFIG = {
  sanfrancisco: {
    discoverPath: "ca--san-francisco/events",
    geoHint: "San Francisco, California, USA",
  },
  losangeles: {
    discoverPath: "ca--los-angeles/events",
    geoHint: "Los Angeles, California, USA",
  },
  newyork: {
    discoverPath: "ny--new-york/events",
    geoHint: "New York, New York, USA",
  },
};

function toArray(value) {
  if (Array.isArray(value)) return value;
  return value ? [value] : [];
}

function pickAddress(locationObj) {
  if (!locationObj || typeof locationObj !== "object") return "";
  const parts = [
    locationObj.name,
    locationObj.streetAddress,
    locationObj.addressLocality,
    locationObj.addressRegion,
    locationObj.postalCode,
    locationObj.addressCountry,
  ].filter(Boolean);
  return parts.join(", ");
}

function normalizeJsonLdEvent(item) {
  const location = item.location || {};
  const place = Array.isArray(location) ? location[0] : location;

  return {
    id: item.url || item.identifier || item.name,
    source: "Eventbrite",
    title: item.name || "Untitled Event",
    start: item.startDate || "",
    end: item.endDate || "",
    venueName: place?.name || "",
    address: pickAddress(place?.address || place),
    latitude: null,
    longitude: null,
    url: item.url || "",
    artists: [],
    tags: [],
  };
}

export async function fetchEventbriteEvents({
  area,
  start,
  end,
  debug = false,
}) {
  const cfg = AREA_CONFIG[area];
  if (!cfg) {
    throw new Error(`Unsupported Eventbrite area: ${area}`);
  }

  const discoverUrl = `https://www.eventbrite.com/d/${cfg.discoverPath}/`;
  const browser = await chromium.launch({
    headless: true,
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
  });

  let title = "";
  let currentUrl = "";
  let bodyText = "";
  let html = "";
  let jsonLdBlocks = [];
  let navigationError = null;

  try {
    const page = await browser.newPage({
      viewport: { width: 1440, height: 1400 },
      userAgent:
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36",
    });

    try {
      await page.goto(discoverUrl, {
        waitUntil: "domcontentloaded",
        timeout: 45000,
      });
    } catch (err) {
      navigationError = err instanceof Error ? err.message : String(err);
    }

    await page.waitForTimeout(5000);

    title = await page.title().catch(() => "");
    currentUrl = page.url();
    bodyText = await page
      .locator("body")
      .innerText()
      .catch(() => "");
    html = await page.content().catch(() => "");

    jsonLdBlocks = await page
      .locator('script[type="application/ld+json"]')
      .evaluateAll((nodes) => nodes.map((n) => n.textContent || ""))
      .catch(() => []);

    await page.close();

    const rawItems = [];

    for (const block of jsonLdBlocks) {
      try {
        const parsed = JSON.parse(block);

        for (const candidate of toArray(parsed)) {
          if (
            candidate?.["@type"] === "ItemList" &&
            Array.isArray(candidate.itemListElement)
          ) {
            for (const entry of candidate.itemListElement) {
              const item = entry?.item || entry;
              if (item?.["@type"] === "Event") {
                rawItems.push(item);
              }
            }
          } else if (candidate?.["@type"] === "Event") {
            rawItems.push(candidate);
          }
        }
      } catch {
        // ignore malformed JSON-LD
      }
    }

    let events = dedupeEvents(rawItems.map(normalizeJsonLdEvent)).filter(
      (event) => inDateRange(event.start, start, end),
    );

    for (const event of events) {
      const query = event.address || event.venueName;
      const geo = await geocodeVenue(query, cfg.geoHint);
      event.latitude = geo.latitude;
      event.longitude = geo.longitude;
    }

    if (debug) {
      return {
        ok: events.length > 0,
        events,
        debug: {
          discoverUrl,
          pageTitle: title,
          currentUrl,
          navigationError,
          bodyTextLength: bodyText.length,
          htmlLength: html.length,
          jsonLdBlockCount: jsonLdBlocks.length,
          rawJsonLdEventCount: rawItems.length,
          bodyTextSample: bodyText.slice(0, 1000),
          htmlSample: html.slice(0, 2000),
        },
      };
    }

    return events;
  } finally {
    await browser.close();
  }
}
