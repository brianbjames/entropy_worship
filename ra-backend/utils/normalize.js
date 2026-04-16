export function isIsoDate(value) {
  return /^\d{4}-\d{2}-\d{2}$/.test(value);
}

export function dedupeEvents(events) {
  const seen = new Set();

  return events.filter((event) => {
    const key =
      event.id ||
      `${event.source}|${event.title}|${event.start}|${event.venueName}`;

    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
}

export function inDateRange(startValue, fromDate, toDate) {
  if (!startValue) return false;
  const day = String(startValue).slice(0, 10);
  return day >= fromDate && day <= toDate;
}
