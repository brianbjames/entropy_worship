const API_BASE = "https://entropy-worship.onrender.com";

const AREA_CONFIG = {
  sanfrancisco: {
    center: [37.7749, -122.4194],
    zoom: 11,
    label: "San Francisco / Oakland",
    // Bounding box: SW corner → NE corner [minLat, minLng, maxLat, maxLng]
    bounds: [36.8, -123.5, 38.5, -121.0],
  },
  //   losangeles: {
  //     center: [34.0522, -118.2437],
  //     zoom: 10,
  //     label: "Los Angeles",
  //   },
  //   newyork: {
  //     center: [40.7128, -74.006],
  //     zoom: 11,
  //     label: "New York",
  //   },
  //   london: {
  //     center: [51.5072, -0.1276],
  //     zoom: 11,
  //     label: "London",
  //   },
  //   berlin: {
  //     center: [52.52, 13.405],
  //     zoom: 11,
  //     label: "Berlin",
  //   },
  //   chicago: {
  //     center: [41.8781, -87.6298],
  //     zoom: 11,
  //     label: "Chicago",
  //   },
  //   miami: {
  //     center: [25.7617, -80.1918],
  //     zoom: 11,
  //     label: "Miami",
  //   },
  //   austin: {
  //     center: [30.2672, -97.7431],
  //     zoom: 11,
  //     label: "Austin",
  //   },
  //   seattle: {
  //     center: [47.6062, -122.3321],
  //     zoom: 11,
  //     label: "Seattle",
  //   },
  //   amsterdam: {
  //     center: [52.3676, 4.9041],
  //     zoom: 11,
  //     label: "Amsterdam",
  //   },
};

const map = L.map("map", {
  attributionControl: false,
  zoomControl: false,
}).setView(AREA_CONFIG.sanfrancisco.center, AREA_CONFIG.sanfrancisco.zoom);

L.control.attribution({ position: "bottomright" }).addTo(map);
L.control.zoom({ position: "topright" }).addTo(map);

L.tileLayer("https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png", {
  attribution:
    '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/">CARTO</a>',
  subdomains: "abcd",
  maxZoom: 19,
}).addTo(map);

const markersLayer = L.layerGroup().addTo(map);

const statusEl = document.getElementById("status");
const startInput = document.getElementById("startDate");
const endInput = document.getElementById("endDate");
const areaInput = document.getElementById("area");
const loadBtn = document.getElementById("loadBtn");

function escapeHtml(str) {
  return String(str == null ? "" : str)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

function formatDate(dateStr) {
  if (!dateStr) return "Unknown";

  const d = new Date(dateStr);
  if (isNaN(d.getTime())) {
    return dateStr;
  }

  return d.toLocaleString("en-US", {
    year: "numeric",
    month: "short",
    day: "numeric",
    hour: "numeric",
    minute: "2-digit",
  });
}

function setDefaultDates() {
  const today = new Date();
  const nextWeek = new Date();
  nextWeek.setDate(today.getDate() + 7);

  startInput.value = today.toISOString().slice(0, 10);
  endInput.value = nextWeek.toISOString().slice(0, 10);
}

function updateMapForArea(areaKey) {
  const area = AREA_CONFIG[areaKey];
  if (!area) return;
  map.setView(area.center, area.zoom);
}

function clearMarkers() {
  markersLayer.clearLayers();
}

function buildPopupContent(event) {
  const title = escapeHtml(event.title || "Untitled event");
  const date = escapeHtml(formatDate(event.start || event.date));
  const venue = escapeHtml(event.venueName || event.venue || "Unknown venue");

  let artists = "Unknown";
  if (Array.isArray(event.artists)) {
    artists = event.artists.length ? event.artists.join(", ") : "Unknown";
  } else if (event.artists) {
    artists = String(event.artists);
  }

  const safeArtists = escapeHtml(artists);

  return `
    <div style="min-width: 220px">
      <div style="font-size: 1rem; font-weight: bold; color: #7df9ff; margin-bottom: 6px;">
        ${title}
      </div>
      <div><b>Date:</b> ${date}</div>
      <div><b>Venue:</b> ${venue}</div>
      <div><b>Artists:</b> ${safeArtists}</div>
      ${
        event.source
          ? `<div><b>Source:</b> ${escapeHtml(event.source)}</div>`
          : ""
      }
      ${
        event.url
          ? `<div style="margin-top: 8px;"><a href="${escapeHtml(event.url)}" target="_blank" rel="noopener noreferrer">View event</a></div>`
          : ""
      }
    </div>
  `;
}

function isWithinAreaBounds(lat, lng, areaKey) {
  const areaBounds = AREA_CONFIG[areaKey]?.bounds;
  if (!areaBounds) return true; // no bounds defined, allow all
  const [minLat, minLng, maxLat, maxLng] = areaBounds;
  return lat >= minLat && lat <= maxLat && lng >= minLng && lng <= maxLng;
}

function addEventMarkers(events, areaKey) {
  let plotted = 0;
  const bounds = [];

  events.forEach((event) => {
    const lat = Number(event.latitude);
    const lng = Number(event.longitude);

    if (!Number.isFinite(lat) || !Number.isFinite(lng)) return;

    if (!isWithinAreaBounds(lat, lng, areaKey)) {
      console.warn(
        `Skipping "${event.title}" — coordinates [${lat}, ${lng}] are outside the ${areaKey} area bounds.`
      );
      return;
    }

    const marker = L.circleMarker([lat, lng], {
      radius: 7,
      color: "#00ffff",
      weight: 2,
      fillColor: "#ff00cc",
      fillOpacity: 0.35,
    }).addTo(markersLayer);

    marker.bindPopup(buildPopupContent(event));
    bounds.push([lat, lng]);
    plotted++;
  });

  if (bounds.length) {
    map.fitBounds(bounds, { padding: [40, 40] });
  } else {
    updateMapForArea(areaKey);
  }

  return plotted;
}

async function loadEvents() {
  const area = areaInput.value;
  const start = startInput.value;
  const end = endInput.value;

  if (!start || !end) {
    statusEl.textContent = "Please choose both a start and end date.";
    return;
  }

  if (start > end) {
    statusEl.textContent = "Start date must be before end date.";
    return;
  }

  clearMarkers();
  statusEl.textContent = "Loading events...";

  const url = `${API_BASE}/api/events?area=${encodeURIComponent(area)}&start=${encodeURIComponent(start)}&end=${encodeURIComponent(end)}`;

  try {
    console.log("Fetching:", url);

    const res = await fetch(url);

    if (!res.ok) {
      throw new Error(`Server returned ${res.status}`);
    }

    const payload = await res.json();
    console.log("Payload:", payload);

    const events = Array.isArray(payload) ? payload : payload.events;

    if (!Array.isArray(events)) {
      throw new Error("API did not return an events array");
    }

    const plotted = addEventMarkers(events, area);

    statusEl.innerHTML = `Loaded <span class="event-count">${events.length}</span> events, plotted <span class="event-count">${plotted}</span> with coordinates.`;
  } catch (err) {
    console.error(err);
    statusEl.textContent = `Error loading events: ${err.message}`;
  }
}

// const legend = L.control({ position: "topright" });
// legend.onAdd = function () {
//   const div = L.DomUtil.create("div", "legend-box");
//   div.innerHTML = `
//     <h5 style="margin: 0; color: white;">Rave Event Map</h5>
//     <div style="font-size: 0.9rem; margin-top: 4px;">
//       User-selected date range
//     </div>
//   `;
//   return div;
// };
// legend.addTo(map);

if (areaInput) {
  areaInput.addEventListener("change", function () {
    updateMapForArea(areaInput.value);
  });
}

if (loadBtn) {
  loadBtn.addEventListener("click", loadEvents);
}

setDefaultDates();
updateMapForArea(areaInput ? areaInput.value : "sanfrancisco");
loadEvents();
