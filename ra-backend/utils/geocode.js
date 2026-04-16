const geocodeCache = new Map();

export async function geocodeVenue(query, geoHint = "") {
  if (!query) {
    return { latitude: null, longitude: null };
  }

  const lowered = query.toLowerCase();
  if (lowered.includes("tba") || lowered.includes("secret location")) {
    return { latitude: null, longitude: null };
  }

  const cacheKey = `${query}|${geoHint}`;
  if (geocodeCache.has(cacheKey)) {
    return geocodeCache.get(cacheKey);
  }

  try {
    const fullQuery = geoHint ? `${query}, ${geoHint}` : query;
    const url =
      "https://nominatim.openstreetmap.org/search?format=jsonv2&limit=1&q=" +
      encodeURIComponent(fullQuery);

    const res = await fetch(url, {
      headers: {
        "User-Agent": "entropy-worship-events/1.0",
      },
    });

    if (!res.ok) {
      const empty = { latitude: null, longitude: null };
      geocodeCache.set(cacheKey, empty);
      return empty;
    }

    const data = await res.json();
    const result =
      Array.isArray(data) && data[0]
        ? {
            latitude: Number(data[0].lat),
            longitude: Number(data[0].lon),
          }
        : { latitude: null, longitude: null };

    geocodeCache.set(cacheKey, result);
    return result;
  } catch {
    const empty = { latitude: null, longitude: null };
    geocodeCache.set(cacheKey, empty);
    return empty;
  }
}
