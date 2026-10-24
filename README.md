# EventAssist — Conference Concierge, built to win the FalkorDB track
## Patch the Conference Hackathon, 2026-10-24

## The pitch (30 seconds on stage)
Conferences are broken in one specific way: you know what you care about,
but you cannot see who to meet, which talk is worth your time, or whether
two talks clash — and you cannot prove why an answer is right.
EventAssist fixes that with a graph, not a list.

Ask it a real question, and it answers with the path:
Talk → Topic → Speaker, Attendee → Topic → Attendee, Talk → Time → Clash.

## Why this fits the FalkorDB judging, exactly
- **Graph at the core:** multi-hop Cypher, memory across sessions
  (who you have already met), and shared state between concierge,
  networking, and schedule agents — all on one graph, not rows in a table
- **Explainable answers:** every answer shows its graph path, not just a title
- **Solves a real conference problem:** which talk, who to meet, what clashes
- **Working demo, live on stage:** `demo.html` runs in a browser with no
  server, no token, and no network — and the same queries are provided in
  Cypher for a real FalkorDB instance

## Track choice — do not dilute in 2 hours
Primary track: **Best use of FalkorDB — $1,500 / phone-or-cash prize**
on the hackathon page. Secondary tracks (Bright Data, TrueForge, Qodo)
are not built into this demo, on purpose: a clean, working FalkorDB demo
beats a half-built multi-track demo on stage.

## Graph model
- `Speaker -[:GIVES]-> Talk -[:ABOUT]-> Topic`
- `Talk -[:AT]-> TimeSlot`, `Talk -[:IN]-> Venue`
- `Attendee -[:INTERESTED_IN]-> Topic`
- `Attendee -[:MET]-> Attendee` (memory: already spoken to)
- `Attendee -[:PLANS]-> Talk`

## Demo script (60 seconds)
1. Concierge: "Which talks on Agents are on after lunch, and who's speaking?"
   → Answer + path: Speaker → Talk → Topic, filtered to after 14:00
2. Networking: "Who should Ava meet?" → People who share her Topics,
   excluding people she has already MET
3. Schedule: "Does Ava's plan clash?" → Two talks in the same TimeSlot,
   shown as a clash path, with one alternative

## Files
- `graph_data.json` — demo conference graph: talks, speakers, topics, attendees
- `queries.cypher` — the exact multi-hop queries for a real FalkorDB instance
- `demo.html` — live demo UI, no server needed
- `concierge.py` — stdlib-only graph logic that mirrors the Cypher, so the
  demo works even if FalkorDB Docker is not running on stage
- This README — pitch, judging map, and demo script

## Run the real graph (optional, if Docker is available)
The hackathon resources list FalkorDB locally with the Browser UI on
port 3000. Load `graph_data.json` into FalkorDB, then run `queries.cypher`.
The demo HTML does not depend on that step — it is the stage-safe fallback.

## What this is NOT
- Not a generic chatbot, not a schedule list, not a database-users admin
  tool. The Database Users manager built earlier is a separate credential
  layer and is not part of this winning demo, to keep the judging story clean.
