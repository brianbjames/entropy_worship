app.get("/api/events", async (req, res) => {
  const area = req.query.area;
  const start = req.query.start;
  const end = req.query.end;

  if (!area || !start || !end) {
    return res.status(400).json({ error: "Missing params" });
  }

  if (!isIsoDate(start) || !isIsoDate(end)) {
    return res.status(400).json({ error: "Bad dates" });
  }

  try {
    const events = await fetchEventbriteEvents({ area, start, end });

    return res.json({
      ok: true,
      sources: { eventbrite: events.length },
      events,
    });
  } catch (err) {
    console.error(err);

    return res.json({
      ok: true,
      sources: { eventbrite: 0 },
      events: [],
    });
  }
});
