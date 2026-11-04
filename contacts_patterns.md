# EventAssist — Contacts Update: Patterns + Segments
## Source: 12 uploaded ZoomInfo PERSON.csv files, 2023–2024 exports
## Aggregates only in this file. No individual email, phone, or street address.

## Counts (verified)
- **Total rows uploaded:** 3,678 across 12 files
- **Unique contacts by ZoomInfo Contact ID:** 3,476
- **Unique email addresses in uploads:** 2,873 (fewer than contacts — some contacts share / lack an email in the export)
- **Duplicates removed by ID:** 202 rows
- **Files:** 229 to 406 rows each, see contacts_summary.json for per-file counts

## What the contacts actually are (pattern, not a list)
This is not a conference attendee list. It is a B2B prospect / supplier contact set, heavily manufacturing and finance/procurement:
- **Top industry:** Manufacturing — 2,094 of 3,678 rows (57%). Next: Business Services 381, Finance 312, Energy/Utilities/Waste 223, Transportation 157, Retail 138, Construction 134.
- **Top job functions:** Finance Executive 990, Executive 618, Finance 375, Sourcing/Procurement 327, Operations Executive 136, Purchasing roles ~280 combined. This is a buying-committee set, not a developer set.
- **Top companies by contact count:** Sanmina 174, Applied Materials 91, Sun Pharma 71, SuperMicro 70, Petronas 60, BD 44, Tesla 43, Charles River 27, Boeing 24, L3Harris 23.
- **Geography:** California dominates — 1,730 rows. Top cities: San Jose 274, San Diego 157, San Francisco 140, Santa Clara 118, Mumbai 78, Palo Alto 67, Kuala Lumpur 60, Austin 58. This overlaps the hackathon location (San Francisco) — a real local segment exists.
- **Distinct values:** 1,705 distinct company names, 20 industries, 647 cities. So the graph is wide, not deep per company, except for the top 10 above.

## Graph model for contacts (separate from the demo concierge graph, same principles)
- `Contact -[:WORKS_AT]-> Company`
- `Contact -[:IN_INDUSTRY]-> Industry`
- `Contact -[:LOCATED_IN]-> City`
- `Company -[:IN_INDUSTRY]-> Industry`
- Demo contacts (Ava, Marcus, Priya, Tom) stay as the stage demo. Real contacts are a second graph layer — do not mix them into the 19-node stage demo, or the demo becomes unreadable.

## Email / marketing segments (drafts only, by segment, not by individual)
Use these segments for EventAssist email/marketing agents, with approval before any send:
1. **Manufacturing Finance Executives in California** — largest segment, finance + procurement buying committee. Angle: cost, supply, and factory-floor integration (links to the Robotics workshop).
2. **Sanmina / Applied Materials / SuperMicro contacts in San Jose / Santa Clara** — dense local manufacturing cluster. Angle: local meetup / workshop invite, not a cold blast.
3. **Sourcing / Procurement contacts** — 327 + purchasing roles. Angle: supplier / operations workshops, not generic conference marketing.
4. **San Francisco / Bay Area contacts (San Jose + San Diego + San Francisco + Santa Clara + Palo Alto = 756 rows)** — local event segment. Angle: "in your city" event marketing, with a real venue and time.
5. **Energy / Finance / Transportation contacts** — secondary segments, for targeted workshop invites only.

## What NOT to do with these files
- **Do NOT push contacts_graph.json, contacts_cypher.txt, or any full contact list to GitHub.** It contains real people's names, job titles, and companies. The GitHub bundle should contain only aggregates (this file + contacts_summary.json) and the demo graph.
- **Do NOT send email to these contacts from EventAssist without explicit approval per segment, per draft, and a check of ZoomInfo / email compliance.** The agents in this project draft only.
- **Do NOT present individual contacts on stage.** Present aggregates, patterns, and segments — as in this file and the updated app contacts tab.
- **Do NOT use email, phone, or street address from the uploads in any graph file.** Those fields were stripped when building contacts_graph.json.

## How to load (private, in your FalkorDB instance only)
1. Keep contacts_graph.json private.
2. Run `python3 contacts_load.py --cypher-out contacts_cypher.txt`
3. Load the Cypher in batches of ~500 into a separate graph (e.g. `contacts`) or into `eventassist` after the demo graph is loaded — do not paste all 3,476 at once into Browser.
4. Verify with: `MATCH (c:Contact) RETURN count(c)` — expected 3,476.
