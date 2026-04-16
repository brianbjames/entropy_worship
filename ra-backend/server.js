import express from "express";
import cors from "cors";

const app = express();
app.use(cors());

const PORT = process.env.PORT || 3000;

app.get("/", (_req, res) => {
  res.send("Entropy Worship events backend is running.");
});

app.get("/api/events", (req, res) => {
  const start = String(req.query.start || "2026-04-16");
  const end = String(req.query.end || "2026-04-23");

  res.json({
    ok: true,
    sources: { test: 1 },
    events: [
      {
        id: "test-1",
        source: "Test",
        title: "Test Event",
        start: `${start}T22:00:00`,
        end: `${end}T01:00:00`,
        venueName: "Public Works",
        address: "161 Erie St, San Francisco, CA",
        latitude: 37.7669,
        longitude: -122.422,
        url: "https://eventbrite.com/",
        artists: ["Test Artist"],
        tags: ["test"],
      },
    ],
  });
});

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
