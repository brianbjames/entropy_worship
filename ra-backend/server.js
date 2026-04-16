import express from "express";
import cors from "cors";
import { isIsoDate } from "./utils/normalize.js";
import { fetchEventbriteEvents } from "./adapters/eventbrite.js";

const app = express();
app.use(cors());

const PORT = process.env.PORT || 3000;

app.get("/", (_req, res) => {
  res.send("Entropy Worship events backend is running.");
});

app.get("/api/eventbrite-events", async (req, res) => {
  const area = String(req.query.area || "");
  const start = String(req.query.start || "");
  const end = String(req.query.end || "");
  const debug = String(req.query.debug || "") === "1";

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

  try {
    const result = await fetchEventbriteEvents({ area, start, end, debug });
    return res.json(result);
  } catch (error) {
    console.error("Eventbrite adapter error:", error);
    return res.status(500).json({
      error: "Failed to load Eventbrite events",
      detail: error instanceof Error ? error.message : String(error),
    });
  }
});

app.get("/api/events", async (req, res) => {
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

  try {
    const eventbrite = await fetchEventbriteEvents({
      area,
      start,
      end,
      debug: false,
    });

    return res.json({
      ok: true,
      sources: {
        eventbrite: eventbrite.length,
      },
      events: eventbrite,
    });
  } catch (error) {
    console.error("Aggregate events error:", error);
    return res.status(500).json({
      error: "Failed to load events",
      detail: error instanceof Error ? error.message : String(error),
    });
  }
});

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
