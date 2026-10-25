# EventAssist — Deep Workshop Overviews
## All workshops are the demo talks, expanded. Attendees are the demo contacts in the graph. No real attendee is invented.

## 1. Agents That Remember: Graph Memory in Production
- **Speaker:** Sara Kim — **Time:** 14:30 — **Venue:** Main Hall
- **Topics:** Agents, GraphRAG
- **What it is about, in depth:** How an agent that remembers beats an agent that re-asks. Memory is not a chat log; it is a graph: who you met, what you care about, what you planned, and what clashed. Production means that memory survives sessions, is shared across agents, and can be explained — you can show the path that led to an answer, instead of trusting a black box.
- **Why it matters at this conference:** This is the thesis of EventAssist itself. Every other workshop in this list becomes useful only if the system remembers.
- **Attendees in the graph who care:** Ava Chen (Agents, GraphRAG), Marcus Lee (Agents), Priya Nair (Agents, GraphRAG, Robotics)
- **Networking pattern:** Ava ↔ Priya is the strongest unmet pair here (2 shared topics). Marcus is already met by Ava, so he is excluded from new introductions, but he is the memory example.
- **Schedule risk:** Clashes at 14:30 with Robotics on the Factory Floor (Room C). If you choose this, move Robotics.
- **Marketing angle:** "Don't re-introduce yourself to your own conference."
- **Email draft angle:** Intro Ava → Priya, grounded in Agents + GraphRAG.

## 2. Multi-Hop Reasoning Without Hallucinating
- **Speaker:** Diego Ramos — **Time:** 15:15 — **Venue:** Room B
- **Topics:** Agents
- **What it is about, in depth:** Answering a question that needs two or three hops — speaker → talk → topic → attendee — without inventing a hop. The graph constrains the answer: if there is no edge, there is no claim. That is the difference between a confident answer and a correct one.
- **Why it matters:** This is the explainability criterion for the FalkorDB track. Judges do not just want an answer; they want the path.
- **Attendees in the graph who care:** Ava Chen, Marcus Lee, Priya Nair (all Agents)
- **Networking pattern:** Marcus Lee is the Agents-only attendee — good for a focused Agents conversation, less good for a GraphRAG crossover.
- **Schedule risk:** None in the demo plan. It follows the 14:30 clash, so it is a clean next step after choosing one 14:30 talk.
- **Marketing angle:** "Show your work, or don't claim it."
- **Email draft angle:** Follow-up after this talk: "We both asked about multi-hop — want to compare paths?"

## 3. Robotics on the Factory Floor
- **Speaker:** Lena Park — **Time:** 14:30 — **Venue:** Room C
- **Topics:** Robotics
- **What it is about, in depth:** Robots in real factories, not demos: integration, safety, training, and the human-robot loop. It is the outlier topic in this graph — only one talk, only one attendee with that interest — which makes it a test of whether a concierge can handle a niche, not just the popular thread.
- **Why it matters:** A good conference tool does not just push the popular topic; it surfaces the niche for the one person who needs it.
- **Attendees in the graph who care:** Priya Nair (Robotics, plus Agents and GraphRAG — she is the bridge between Robotics and the main thread)
- **Networking pattern:** Priya is the bridge node: Robotics ↔ Agents ↔ GraphRAG. Introduce a Robotics newcomer to Priya first.
- **Schedule risk:** Direct clash at 14:30 with Agents That Remember (Main Hall). This is the demo's central clash, and the reason the schedule agent exists.
- **Marketing angle:** "The niche talk is not a side track — it is someone's main track."
- **Email draft angle:** Priya-focused: "You are the only bridge to Robotics in this graph."

## 4. GraphRAG From Docs to Answers
- **Speaker:** Sara Kim — **Time:** 16:00 — **Venue:** Main Hall
- **Topics:** GraphRAG
- **What it is about, in depth:** Turning documents into a knowledge graph, then answering from that graph instead of from raw text. Docs become nodes, relations become edges, and answers become paths you can audit. Sara Kim gives two talks in this graph, which makes her a speaker hub.
- **Why it matters:** This is the fallback and the alternative in the schedule: if you miss the 14:30 Agents talk, this 16:00 GraphRAG talk keeps you on the same thread.
- **Attendees in the graph who care:** Ava Chen, Priya Nair, Tom Rivera (all GraphRAG)
- **Networking pattern:** Tom Rivera is the GraphRAG-only attendee in the demo — a clean, focused introduction for Ava after Priya.
- **Schedule risk:** None. It is the recommended alternative in the clash resolution.
- **Marketing angle:** "From docs to answers you can trace."
- **Email draft angle:** Intro Ava → Tom, grounded in GraphRAG only.

## Cross-workshop patterns (the whole graph, at a glance)
- **Speaker hub:** Sara Kim — 2 talks, Main Hall, Agents + GraphRAG thread.
- **Bridge attendee:** Priya Nair — 3 interests, connects all three main topics.
- **Strongest unmet pair:** Ava ↔ Priya — 2 shared topics, never met in the starting graph.
- **Memory pair:** Ava ↔ Marcus — already met, excluded from new suggestions, used as the memory proof.
- **Clash slot:** 14:30 — the only slot with 2 talks, and the reason schedule planning needs a graph, not a list.
- **Niche signal:** Robotics has 1 talk and 1 interested attendee — a concierge that only pushes popular topics would miss it.

## Contacts in the graph — and how to add all of yours
- **Contacts already in the graph (demo contacts, not invented real people):** Ava Chen, Marcus Lee, Priya Nair, Tom Rivera, plus speakers Sara Kim, Diego Ramos, Lena Park.
- **To add all of your real contacts:** use `contacts_import_template.csv` (name, interests, met, plans) — fill it in, do not invent contacts here, and load it as Attendee nodes with INTERESTED_IN, MET, and PLANS edges. The agents above will then work on your real contacts with no code change.
