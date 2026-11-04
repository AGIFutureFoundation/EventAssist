// EventAssist — 4 demo queries, verified against the complete graph.
// Run these AFTER load_graph_complete.cypher, in graph "eventassist".
// Expected results are in the comments, so you can check the load worked.

// 1. Concierge — multi-hop, explainable
// Expected: Agents That Remember (Sara Kim, 14:30, Main Hall)
//           Multi-Hop Reasoning (Diego Ramos, 15:15, Room B)
MATCH (:Topic {name: "Agents"})<-[:ABOUT]-(t:Talk)
      <-[:GIVES]-(s:Speaker)
WHERE t.starts >= "14:00"
RETURN t.title, s.name, t.starts, t.venue;

// 2. Networking — shared topics, excluding memory (already met)
// Expected: Priya Nair — [Agents, GraphRAG]
//           Tom Rivera — [GraphRAG]
//           NOT Marcus Lee — Ava already MET him
MATCH (a:Attendee {id: "ava"})-[:INTERESTED_IN]->(topic:Topic)
      <-[:INTERESTED_IN]-(candidate:Attendee)
WHERE NOT (a)-[:MET]->(candidate) AND candidate <> a
RETURN candidate.name, collect(topic.name) AS shared_topics;

// 3. Schedule planner — clash detection, shared graph
// NOTE: This query only works with load_graph_complete.cypher, NOT with
// the original load_graph.cypher — the original has no PLANS or AT edges,
// so this would return nothing. With the complete load:
// Expected: 1 row — Agents That Remember vs Robotics on the Factory Floor, 14:30
// The t1.id < t2.id condition de-duplicates the clash (otherwise you get
// the same clash twice, swapped).
MATCH (a:Attendee {id: "ava"})-[:PLANS]->(t1:Talk)-[:AT]->(slot:TimeSlot)
      <-[:AT]-(t2:Talk)<-[:PLANS]-(a)
WHERE t1 <> t2 AND t1.id < t2.id
RETURN t1.title, t2.title, slot.time AS clash_time;

// 4. Memory across sessions — who Ava has already met
// Expected: Marcus Lee — [Agents]
MATCH (a:Attendee {id: "ava"})-[:MET]->(other:Attendee)
      -[:INTERESTED_IN]->(topic:Topic)
RETURN other.name, collect(topic.name) AS shared_topics;
