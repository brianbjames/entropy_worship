import { chromium } from "playwright";
import { geocodeVenue } from "../utils/geocode.js";
import { dedupeEvents, inDateRange } from "../utils/normalize.js";

const AREA_CONFIG = {
  sanfrancisco: {
    path: "ca--san-francisco/events",
    geoHint: "San Francisco, California, USA",
  },
};

function toArray(v) {
  return Array.isArray(v) ? v : v ? [v] : [];
}

function normalizeEvent(item) {
  const place = item.location || {};

  return {
    id: item.url,
    source: "Eventbrite",
    title: item.name || "Untitled",
    start: item.startDate || "",
    end: item.endDate || "",
    venueName: place?.name || "",
    address: place?.address?.streetAddress || "",
    latitude: null,
    longitude: null,
    url: item.url,
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
  if (!cfg) throw new Error("Unsupported area");

  const url = `https://www.eventbrite.com/d/${cfg.path}/`;

  const browser = await chromium.launch({
    headless: true,
    args: ["--no-sandbox"],
  });

  try {
    const page = await browser.newPage();

    await page.goto(url, {
      waitUntil: "domcontentloaded",
      timeout: 45000,
    });

    await page.waitForTimeout(5000);

    const jsonLd = await page
      .locator('script[type="application/ld+json"]')
      .evaluateAll((nodes) => nodes.map((n) => n.textContent));

    const raw = [];

    for (const block of jsonLd) {
      try {
        const parsed = JSON.parse(block);

        for (const item of toArray(parsed)) {
          if (item["@type"] === "ItemList") {
            for (const e of item.itemListElement || []) {
              if (e.item?.["@type"] === "Event") {
                raw.push(e.item);
              }
            }
          }
        }
      } catch {}
    }

    let events = dedupeEvents(raw.map(normalizeEvent)).filter((e) =>
      inDateRange(e.start, start, end),
    );

    for (const e of events) {
      const geo = await geocodeVenue(e.address || e.venueName, cfg.geoHint);
      e.latitude = geo.latitude;
      e.longitude = geo.longitude;
    }

    if (debug) {
      return {
        ok: events.length > 0,
        count: events.length,
        sample: events.slice(0, 3),
      };
    }

    return events;
  } finally {
    await browser.close();
  }
}
