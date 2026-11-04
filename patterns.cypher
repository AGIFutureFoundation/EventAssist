// EventAssist — Graph patterns, not just queries.
// Run after load_graph_complete.cypher, in graph "eventassist".
// Each pattern is a judging point: shared state, multi-hop, memory, hubs.

// P1. Topic hub — which topic connects the most talks and attendees?
// Expected hub: Agents (2 talks, 3 attendees), then GraphRAG (2 talks, 3 attendees)
MATCH (topic:Topic)<-[:ABOUT]-(t:Talk)
RETURN topic.name, count(DISTINCT t) AS talks
ORDER BY talks DESC;

// P2. Shared-topic clique — attendees who share 2+ topics (strongest introductions)
// Expected: Ava <-> Priya (Agents, GraphRAG)
MATCH (a:Attendee)-[:INTERESTED_IN]->(topic:Topic)<-[:INTERESTED_IN]-(b:Attendee)
WHERE a.id < b.id
WITH a, b, collect(topic.name) AS shared
WHERE size(shared) >= 2
RETURN a.name, b.name, shared;

// P3. Speaker hub — who gives the most talks?
// Expected: Sara Kim (2 talks)
MATCH (s:Speaker)-[:GIVES]->(t:Talk)
RETURN s.name, count(t) AS talks
ORDER BY talks DESC;

// P4. Memory pattern — who has met whom, and what do they share?
// Expected: Ava <-> Marcus, shared: Agents
MATCH (a:Attendee)-[:MET]->(b:Attendee)-[:INTERESTED_IN]->(topic:Topic)
      <-[:INTERESTED_IN]-(a)
RETURN a.name, b.name, collect(topic.name) AS shared;

// P5. Clash pattern — the whole schedule, grouped by timeslot
// Expected: 14:30 is the only clash slot (2 talks), 15:15 and 16:00 are single
MATCH (t:Talk)-[:AT]->(slot:TimeSlot)
RETURN slot.time, collect(t.title) AS talks, count(t) AS n
ORDER BY slot.time;

// P6. Unmet, high-fit introductions — shared topics, never met, not self
// This is the networking engine in one query.
MATCH (a:Attendee)-[:INTERESTED_IN]->(topic:Topic)<-[:INTERESTED_IN]-(b:Attendee)
WHERE a.id < b.id AND NOT (a)-[:MET]->(b)
WITH a, b, collect(topic.name) AS shared
RETURN a.name, b.name, shared
ORDER BY size(shared) DESC;
