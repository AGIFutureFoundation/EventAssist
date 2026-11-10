# EventAssist Enterprise — Electron desktop app

## Run (on your laptop, not the Muse VM)
```
cd electron && npm install && npm start
```

## What is in v1.1.0
- product_v6 as the app UI: demo concierge / networking / schedule agents (7/7 tests PASS), plus a private Contacts Insights panel (aggregates only: 3,476 unique contacts, industries, companies, places).
- Enterprise defaults: nodeIntegration OFF, contextIsolation ON, sandbox ON, no preload, no telemetry, no network calls from the demo UI.
- Data handling: demo attendees are fictional and separate from real contacts. The full contacts file is local only — it is never pushed to GitHub, emailed, or sent to a server by this app. The contacts panel shows aggregates only.
- FalkorDB: live Cloud graph load remains unverified; instance-si114dlr3 was stopped 2026-10-26 00:03 PDT and must be restarted from the Cloud Dashboard before ~2026-11-02 or it is deleted. This desktop demo runs offline without Cloud.

## Enterprise notes / limits
- This is a demo-grade enterprise wrapper, not a certified enterprise deployment: no SSO, audit log, or managed update channel is included yet.
- Do not use the contacts panel on stage or in a shared screenshot — aggregates only, and the underlying contacts are real people.
