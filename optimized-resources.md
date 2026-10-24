# Optimised Resources — EventAssist, Patch the Conference Hackathon
## Source: wemakedevs.org/hackathons/ptc/resources — optimised for a 2-hour, FalkorDB-track win
## Rule used: one primary track, one working demo. Everything else is stretch or skip.

## The stack to actually use (core, in order)

### 1. FalkorDB — MUST USE (primary track, $1,500 / phone-or-cash)
- **Docker + Browser UI (port 3000)** — Use for the real graph. Load
  `load_graph.cypher`, run `queries.cypher` in the Browser so judges see
  the graph, not just a web page. Time: 10 min to start, 5 min to load.
- **Python client library** — Use for `load_graph.py` / any live query.
  One language only (Python, already in the demo). Do not also add Node,
  Java, Rust, Go, PHP, or C# clients in the same demo.
- **Cypher reference** — Use for exactly 4 queries, already written:
  concierge (multi-hop), networking (shared topics + NOT MET), schedule
  clash (shared TimeSlot), memory (MET history). No other Cypher needed.
- **MCP server** — Stretch, 15 min max: let an assistant query the graph
  through MCP, as a second proof that the graph is the agent's memory.
  Do not build the whole demo on MCP — the HTML demo is the stage-safe fallback.

### 2. Agentic memory — USE THE PATTERN, NOT ALL THREE LIBRARIES
- Resources list Graphiti, Cognee, and Mem0 for long-term graph memory.
- Optimised choice: **do not install all three**. EventAssist already
  demonstrates memory with MET edges: meeting someone changes future
  networking suggestions, and that change is testable in `test_eventassist.py`.
- If a judge asks "which memory library?", answer: "MET-edge memory in
  FalkorDB, same pattern as Graphiti/Mem0, without a second dependency
  in a 2-hour demo." That is honest and stronger than a half-wired library.

### 3. GraphRAG SDK / LangChain — SKIP FOR THE DEMO
- Both are on the resources page, but they add document ingestion,
  embeddings, and LLM variance. The demo graph is already hand-built and
  explainable, which is what FalkorDB judging rewards.
- Use only if you have 30+ spare minutes and want a "docs → graph" slide:
  ingest one conference page into a graph, then ask the same concierge
  question. Do not replace the hand-built graph with it.

## Stretch only — do not let these break the main demo

### Bright Data — STRETCH, 20 min max, second track only
- Best single use for EventAssist: one SERP search for live conference
  talks / speakers, to show fresh data, not a static list.
- APIs in priority order: SERP → MCP → Web Scraper. Skip Web Unlocker
  and Browser API unless a specific site blocks you — you do not need them
  for a demo with hand-built talks.
- Risk: API key setup, $50 credits, and site changes on stage. Keep the
  hand-built graph as the fallback, always.

### TrueForge + OpenAI — SKIP FOR THE MAIN DEMO
- TrueForge harness + OpenAI models are a separate $1,000 track.
  The agents in `agents.py` already run the agent loop deterministically.
  Adding a harness + LLM call risks hallucinated answers, which directly
  hurts the FalkorDB "explainable answers" criterion.
- Use only as a second, separate attempt after the FalkorDB demo works:
  point TrueForge at OpenAI, give it the same graph tools, and show one
  natural-language question parsed to Cypher, with the graph path as proof.

### Qodo — USE AT PUSH TIME ONLY
- Install Qodo on EventAssist before you open the PR, run a review,
  and fix 2 examples. That is cheap, improves code quality, and is the
  whole Qodo track ($500) if you want to claim it.
- Do not configure custom review rules or the full Agentic Toolbox
  during the build — that is time away from the demo.

## What to ignore, on purpose
- All client libraries except Python
- All Bright Data APIs except SERP (stretch)
- GraphRAG, LangChain, Graphiti, Cognee, Mem0 as full integrations
- TrueForge example agents (10 agents) — copy one pattern at most, if at all
- Qodo custom configuration

## 60-minute optimised plan (from now to demo-ready)
1. 0–10 min: Start FalkorDB, load graph, run 4 Cypher queries in Browser
2. 10–30 min: Run demo.html + agents.py + tests, fix any demo break
3. 30–45 min: Rehearse the 60-second demo script (concierge → networking → clash → memory update)
4. 45–60 min: Push bundle to GitHub (once app access is fixed), install Qodo, open PR
5. Stretch only after that: one Bright Data SERP enrichment, or one TrueForge/OpenAI natural-language query

## Demo checklist (judging-aligned)
- [ ] Graph shown, not just a list
- [ ] Every answer shows its path
- [ ] Multi-hop query demonstrated
- [ ] Memory demonstrated (MET update changes suggestions)
- [ ] Shared state demonstrated (same graph for concierge, networking, schedule)
- [ ] Demo runs with no token, no network, in a browser
- [ ] Real FalkorDB queries available in Browser for judges who ask
