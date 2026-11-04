# EventAssist Wiki — Patch the Conference, FalkorDB Track

> **Status, honestly stated (2026-10-24 ~16:35 PDT):** This wiki, the code, the pictures, and the deck are ready in the local bundle. The GitHub repo AGIFutureFoundation/EventAssist is still LICENSE-only on GitHub because Muse's GitHub App gets 403 on it — push this bundle manually (see PUSH_TO_GITHUB.md) or after fixing app access, then open a PR so Qodo (now connected to GitHub) can review it. The pitch video MP4 is still encoding at 16:35 PDT and is not yet verified — do not link it as ready until it verifies. The FalkorDB Cloud graph load is still unconfirmed in the owner's open app.

## 1. What EventAssist is
EventAssist fixes conferences in three ways at once: you miss the right talk, you never meet the right person, and your plan clashes. Lists don't fix that. A graph does.

One shared FalkorDB graph powers three agents — Concierge, Networking, and Schedule — plus email and marketing draft agents. Every answer shows its graph path, so a judge can ask "how did you get that?" and get a path, not a claim.

**Primary track:** Best use of FalkorDB ($1,500, or phone/cash instead, one prize per track). Demos/judging 5:30–7:00pm PT, Bright Data, 625 2nd St, San Francisco, Sat 2026-10-24.

## 2. Pictures
- **Graph diagram:** `pictures/graph_diagram.png` — nodes, edges, clash, bridge, and speaker hub at a glance.
- **Pitch slides:** `pictures/slide1.png` … `pictures/slide8.png` — the 8 pitch slides, 1280×720, matching the 3-minute pitch script (pitch_script.md, 435 words, narration total 173.9 seconds / 2:54).
- **Working product:** open `product_v2.html` in a browser — no server, no token, no install. Pick an attendee + topic, run all agents, and use "Mark first networking match as met" to watch memory change networking live.
- **Deck:** `presentation.html` — Slides 1–8 are the pitch, Slide 9 is the tech stack, Slide 10 is the judges criteria scorecard.

## 3. Videos
- **Pitch video (pending verification):** `pitch_video/pitch_video_fast.mp4` — 8 slides + narration, target ~174 seconds. At 16:35 PDT the file was still encoding (partial, moov atom not found) and must be verified with ffprobe (duration ~174s, playable) before it is linked in a submission.
- **Demo video for submission:** the WeMakeDevs form marks Demo video as REQUIRED, under 3 minutes, hosted publicly or unlisted on YouTube, Loom, GDrive, etc. Do not submit a video link until a verified MP4 exists and is uploaded to one of those hosts (or a public link that the form accepts).
- **No other video is claimed.** Slides + narration MP3s are in `pitch_video/slide1.mp3` … `slide8.mp3`.

## 4. The graph — deep
**Graph:** `eventassist`, FalkorDB Cloud instance-si114dlr3. **19 nodes, 26 edges.**

| Node type | Count | Examples |
|---|---|---|
| Speaker | 3 | Sara Kim, Diego Ramos, Lena Park |
| Talk | 4 | Agents That Remember (14:30, Main Hall), Multi-Hop Reasoning (15:15, Room B), Robotics on the Factory Floor (14:30, Room C), GraphRAG From Docs to Answers (16:00, Main Hall) |
| Topic | 5 | Agents, GraphRAG, Robotics, Security, Data |
| Attendee | 4 | Ava Chen, Priya Nair, Marcus Lee, Tom Rivera |
| TimeSlot | 3 | 14:30, 15:15, 16:00 |

**Edges (26):** GIVES 4, ABOUT 5, INTERESTED_IN 6, MET 2 (symmetric Ava↔Marcus), AT 4, PLANS 5 (Ava→t1+t3, Priya→t1, Marcus→t2, Tom→t4).

**Load it first:** run `load_graph_complete.cypher` in FalkorDB Browser on graph `eventassist`. Do NOT run the original `load_graph.cypher` alone for the clash query — it lacks TimeSlot/AT/PLANS, so Query 3 would return nothing. Do not run the load twice without clearing (`MATCH (n) DETACH DELETE n`) or you will duplicate nodes.

**Query it:** `queries_complete.cypher` (4 queries, expected results included), `patterns.cypher` (P1 topic hub, P2 shared-topic clique Ava↔Priya 2 topics, P3 speaker hub Sara Kim 2 talks, P4 memory, P5 clash by timeslot 14:30 only, P6 unmet high-fit introductions).

## 5. Live answers — the demo script
1. **Concierge:** Which talks on Agents after lunch? Agents That Remember — Sara Kim, 14:30, Main Hall — and Multi-Hop Reasoning — Diego Ramos, 15:15, Room B. Path: Speaker —GIVES→ Talk —ABOUT→ Topic.
2. **Networking:** Who should Ava meet? Priya Nair (Agents, GraphRAG) and Tom Rivera (GraphRAG). NOT Marcus Lee — Ava already met him. Path: Attendee —INTERESTED_IN→ Topic ←INTERESTED_IN— Candidate, AND NOT Attendee —MET→ Candidate.
3. **Memory:** Meet Priya, and the next run drops Priya. That is shared state, not a static list. In `product_v2.html`, "Mark first networking match as met" does this live.
4. **Schedule:** Ava's plan clashes at 14:30 (Agents vs Robotics). Alternative: GraphRAG at 16:00, Main Hall. Path: Attendee —PLANS→ Talk —AT→ TimeSlot ←AT— Talk ←PLANS— Attendee.
5. **Workshops deep:** `workshops_deep.md` — all 4 workshops with at-a-glance, deep overview, learning flow, attendees, real-contact segment (aggregates only), networking matches, schedule/clash, email draft, marketing draft, and graph proof. No invented speaker biographies; talk durations are not in the graph, so learning flows are thematic, not timed.

## 6. Agents — deep
- `concierge.py` / `agents.py` — ConciergeAgent, NetworkingAgent, ScheduleAgent on one shared graph. Graph plans: Ava [t1,t3], Priya [t1], Marcus [t2], Tom [t4]. MET is symmetric in Python; `meet()` adds MET both ways.
- `agents_email_marketing.py` — EmailAgent / WorkshopReminder + MarketingAgent. **Drafts only, never sent.** A human must approve before any send step is added.
- `test_eventassist.py` — 7 tests, all passing at last deep review (2026-10-24 ~16:34 PDT): concierge 2 talks, first Sara Kim 14:30, paths present, networking Priya not Marcus, Priya shares Agents+GraphRAG, 14:30 clash, memory update removes Priya.

## 7. Contacts — deep, and privacy
- **Uploads:** 12 ZoomInfo PERSON files, 3,678 rows.
- **Deduplicated:** 3,476 unique contacts by ZoomInfo ID, 2,873 unique emails, 202 duplicate rows removed.
- **Aggregates (safe to show):** Manufacturing 2,094 (57%), Finance Executive 990, California 1,730; Sanmina 174, Applied Materials 91, San Jose 274, San Francisco 140, etc. Full aggregates in `contacts_summary.json` and `contacts_patterns.md`.
- **Segments:** Manufacturing Finance Executives in California; Sanmina/Applied Materials/SuperMicro in San Jose/Santa Clara; Sourcing/Procurement; Bay Area contacts.
- **Privacy — hard rule:** `contacts_graph.json` (names/titles/companies, no email/phone/street address) is PRIVATE and is NOT in this GitHub bundle. Do not push it, do not present individual real contacts on stage, do not use individual emails/phones/addresses in demos. `contacts_load.py` batches Contact → WORKS_AT → Company / IN_INDUSTRY → Industry / LOCATED_IN → City (3,477 lines: header + 3,476 contacts).
- **Adding contacts:** use `contacts_import_template.csv` — do not invent people.

## 8. Tech stack
- **Graph:** FalkorDB Cloud instance-si114dlr3, graph `eventassist`, Cypher, FalkorDB Browser.
- **Agents:** Python 3.12, stdlib only. `requirements.txt` lists `falkordb>=1.0` for a server deployment.
- **Product:** HTML/CSS/JavaScript, offline (`product_v2.html`, also `app.html`, `demo.html`, `product.html`). No server, no token, no framework dependency for the judge demo.
- **Pictures/video:** PIL slides (1280×720), TTS narration (8 MP3s, 173.9s total), ffmpeg assembly (see Videos — pending verification).
- **Code review:** Qodo — Qodo.ai connected to GitHub (2026-10-24 ~16:33 PDT). `.pr_agent.toml` auto-runs `/review`, `/describe`, `/improve` on PRs, with EventAssist rules (graph correctness, no invented data, no private contact data, tests must pass). See `QODO_SETUP.md`. Qodo reviews PRs — it has 0 PRs to review until a PR is opened.
- **Honest limits:** Docker was not available in the Muse VM, `falkordb-py`/`redis` were not installed, so the working demo runs locally/offline and is verified in FalkorDB Browser with Cypher.
- **Deliberately not on stage for the primary track:** Bright Data, TrueForge/OpenAI, and Qodo as a track. Qodo is tooling on the repo and a separate $500 track; it does not replace the FalkorDB story.

## 9. Judges criteria — scorecard
| Criterion | What judges look for | EventAssist evidence |
|---|---|---|
| Graph at the core | Multi-hop, memory, shared state — not rows | One graph, three agents; mark-as-met changes networking; patterns P2/P4 |
| Explainable answers | Show the graph path | Every answer in product_v2.html shows its path; Cypher returns Speaker→Talk→Topic |
| Real conference problem | A problem attendees actually have | Missed talks, missed people, clashing plans; niche Robotics case (1 talk, 1 interested attendee) |
| Working demo, live | It runs in front of judges | product_v2.html offline, plus live FalkorDB load (19/26) + queries; tests 7/7 |

**Pushback answers:** "Show me it's not a list" → mark a match as met and re-run. "Show me the path" → read the path under any answer. "Show me scale" → contacts aggregates + loader, private data kept private.

## 10. How to run it
1. **Offline demo (fastest for judges):** open `product_v2.html`. Choose Ava + Agents, run all agents.
2. **Live FalkorDB:** open instance-si114dlr3 → Browser → graph `eventassist` → run `load_graph_complete.cypher` → run `queries_complete.cypher` → run `patterns.cypher`. Verify 19 nodes / 26 edges.
3. **Python:** `python3 test_eventassist.py` (7 tests), `python3 agents.py`, `python3 agents_email_marketing.py` (drafts only).
4. **Contacts (private, batches of ~500):** `python3 contacts_load.py --cypher-out contacts_cypher.txt`, then load into a separate `contacts` graph or into `eventassist` after the demo graph. Verify `MATCH (c:Contact) RETURN count(c)` = 3,476.

## 11. Files in this bundle (safe files only)
README, agents, concierge, demo/app/product/product_v2 HTML, presentation, workshops + workshops_deep, patterns, load/query Cypher (original + complete), graph_data.json, contacts_summary/patterns/loader/template, optimized-resources, Qodo config + setup, deep_review, submission_draft, pictures (graph diagram + 8 slides), PUSH_TO_GITHUB instructions. **Not in bundle:** contacts_graph.json, full contact Cypher, any email/phone/street address, any token/password.

## 12. Submission status (2026-10-24)
- WeMakeDevs form: filled, NOT submitted. 7/11 answered. Missing required field: Demo video (see Videos).
- Repo: https://github.com/AGIFutureFoundation/EventAssist — still LICENSE-only on GitHub at last check; push this bundle, then open a PR.
- Live demo link (Muse storage, expires 2026-10-26T23:21:37Z): product_v2.html link in submission_draft.md.
- Deck link (expires 2026-10-26T23:22:33Z): presentation.html link in submission_draft.md.
