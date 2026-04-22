# WTFDIPISF

Interactive parking tool for San Francisco that tells you whether it's currently safe to park on any given street, how long you have, and how risky the spot is — based on official street cleaning schedules, citation history, and neighborhood safety data

---

1. **The Map** — streets are rendered and color-coded for the current day and time
2. **Adjust Sliders** — set the current viewing hour and when you plan to leave ("park until")
3. **Click a Street** — pin the location to get a full verdict: is it safe, when does the restriction start/end, and what's the tow risk?
4. **"Where's the safest spot?"** — Nearby streets ranked by safety
5. **What route should I take?"** — Driving route is suggested for optimal parking

Street colors update live as you scrub through time, so you can plan ahead

---

## Data Sources

All data comes from **[DataSF](https://data.sfgov.org)**, San Francisco's open data portal. No API key required — all endpoints are public

| Dataset                        | DataSF ID                             | What It Provides                                                      |
| ------------------------------ | ------------------------------------- | --------------------------------------------------------------------- |
| Street Cleaning Schedule       | `yhqp-riqs`                           | Official blockface-level cleaning windows (day, hours, week-of-month) |
| Parking Citations              | `ab4h-6ztd`, `pvgt-pd5y`, `wwf5-khdm` | Historical tickets used to infer undocumented cleaning schedules      |
| Parking Meters                 | `nwbb-fxhp`, `28et-5khy`, `rqzj-sfat` | Meter locations and active/free hours by day                          |
| 311 Street Cleaning Requests   | `vw6y-z8j6`                           | Resident complaints used as secondary cleaning schedule signal        |
| Police Incidents               | `wg3w-h783`                           | Vehicle break-ins and theft patterns near a pinned location           |
| Traffic Crashes                | `ubvf-ztfx`                           | Collision data for area risk scoring                                  |
| Abandoned Vehicles / Tows      | `wr8u-xric`, `i98e-djp9`, `ktji-gn4e` | Density of abandoned cars in the area                                 |
| Residential Permit Zones (RPP) | `hi6h-neyh`                           | Permit-only hours and zone numbers                                    |
| Construction Permits           | `sftu-nd43`                           | Active street work that may restrict parking                          |
| Special Events                 | `8x25-yybr`                           | Events that affect nearby parking availability                        |
| Parking Garages                | `mizu-nf6z`                           | Nearby garages with hours and access info                             |

The **Street Cleaning Schedule** is the primary source. All other datasets are used for risk scoring, inference, and supplementary layers.

---

## Inference Logic

### 1. Is It Safe to Park Here?

The app looks at when street cleaning is scheduled and compares it to when you plan to park. If the cleaning happens before you arrive or after you leave, you're fine. If there's any overlap — even partial — the street is flagged as unsafe. Streets with no schedule data on record are treated as safe

### 2. Street Status Colors

Every blockface gets one of four statuses at the current viewing hour:

| Color         | Status        | Condition                                    |
| ------------- | ------------- | -------------------------------------------- |
| Red           | **ACTIVE**    | Cleaning is happening right now              |
| Orange/Yellow | **UPCOMING**  | Restriction starts within the viewing window |
| Green         | **PASSED**    | Restriction already ended today              |
| Blue          | **PARK SAFE** | No overlap with your full parking window     |

Upcoming streets get urgency shading based on how soon the restriction starts:

| Time Until | Color          |
| ---------- | -------------- |
| < 30 min   | Red — critical |
| < 1 hour   | Orange-red     |
| < 2 hours  | Orange         |
| > 2 hours  | Yellow         |

On **weekends**, all streets display as blue — most SF street cleaning is Monday–Friday

### 3. Week-of-Month Detection

Not every street gets cleaned every week. Some are only cleaned on the 1st and 3rd Monday of the month, for example. The app figures out which week of the month it currently is and only shows restrictions for streets that are actually scheduled to be cleaned that week.

### 4. Citation-Based Schedule Inference

Many streets are not in the official cleaning schedule dataset. For these, the app infers a likely schedule from **parking citation history**:

1. Pull recent citations for the area with date, time, and street name
2. Normalize street name suffixes (ST, AVE, BLVD, etc.) for consistent matching
3. Group citations by street name and day of the week, then count how many citations fall in each hour of that day
4. **Inference rule:** If a street has ≥3 citations on the same day, the app treats the peak citation hour as the likely cleaning window (peak hour to peak hour + 2)
5. **311 supplement:** If 311 cleaning complaints exist for the same street/day (threshold: ≥8 complaints), those fill gaps and default to an 8AM–10AM window

This means a street with no official schedule but a clear pattern of Monday morning tickets will still show a warning

### 5. Tow Risk Scoring

After determining legality, the app calculates a composite **tow risk score** for a pinned location:

| Factor                                   | Points |
| ---------------------------------------- | ------ |
| Cleaning is actively happening           | +4     |
| Cleaning starts in < 1 hour              | +3     |
| Cleaning starts in < 2 hours             | +2     |
| Active RPP (Residential Permit) zone     | +2     |
| ≥10 nearby citations in the last 90 days | +1     |
| ≥6 nearby vehicle break-ins              | +1     |

**Risk levels:**

| Score | Level    |
| ----- | -------- |
| ≥7    | CRITICAL |
| ≥4    | HIGH     |
| ≥2    | MEDIUM   |
| <2    | LOW      |

### 6. Neighborhood Risk

For a pinned location, the app scans a **200-meter radius** and evaluates nearby incident density:

| Category           | HIGH | MEDIUM | LOW |
| ------------------ | ---- | ------ | --- |
| Vehicle break-ins  | ≥6   | ≥3     | <3  |
| Parking citations  | ≥10  | ≥4     | <4  |
| Abandoned vehicles | ≥4   | ≥2     | <2  |
| Police incidents   | ≥8   | ≥3     | <3  |

This is displayed separately from legality — a street can be technically legal to park on but still be flagged HIGH risk based on neighborhood patterns.

---

## Map Layers

Toggle these on/off from the sidebar:

- **Street Cleaning** — primary blockface restriction layer (always on)
- **Parking Meters** — green (free) or blue (active cost) by time of day
- **Parking Citations** — heatmap of historical ticket density
- **Police Incidents** — vehicle-related crime locations
- **Traffic Crashes** — collision hotspots
- **Abandoned Vehicles (311)** — reported abandoned car density
- **Construction** — active permit areas
- **Events** — scheduled events affecting parking
- **RPP Zones** — residential permit districts with hours
- **Parking Garages** — nearby garages with open/close times

---

## Technical Stack

- **[Leaflet.js](https://leafletjs.com)** v1.9.4 — map rendering
- **[Leaflet.heat](https://github.com/Leaflet/Leaflet.heat)** — citation heatmap
- **CartoDB Dark Matter** — basemap tiles
- **DataSF Socrata API** — all data (GeoJSON + JSON endpoints)
- **OSRM / Valhalla** — routing for "find nearest safe spot" recommendations
- Single-file HTML/CSS/JS

---
