// 1. Conference concierge — multi-hop, explainable
// Talks on Agents after lunch, and who's speaking.
// Path: Speaker -[:GIVES]-> Talk -[:ABOUT]-> Topic
MATCH (:Topic {name: "Agents"})<-[:ABOUT]-(t:Talk)
      <-[:GIVES]-(s:Speaker)
WHERE t.starts >= "14:00"
RETURN t.title, s.name, t.starts, t.venue;

// 2. Networking — shared topics, excluding memory (already met)
// Path: Attendee -[:INTERESTED_IN]-> Topic <-[:INTERESTED_IN]- Attendee
//       AND NOT (Attendee)-[:MET]->(Candidate)
MATCH (a:Attendee {id: "ava"})-[:INTERESTED_IN]->(topic:Topic)
      <-[:INTERESTED_IN]-(candidate:Attendee)
WHERE NOT (a)-[:MET]->(candidate) AND candidate <> a
RETURN candidate.name, collect(topic.name) AS shared_topics;

// 3. Schedule planner — clash detection, shared graph
// Path: Attendee -[:PLANS]-> Talk -[:AT]-> TimeSlot
MATCH (a:Attendee {id: "ava"})-[:PLANS]->(t1:Talk)-[:AT]->(slot:TimeSlot)
      <-[:AT]-(t2:Talk)<-[:PLANS]-(a)
WHERE t1 <> t2
RETURN t1.title, t2.title, slot.time AS clash_time;

// 4. Memory across sessions — who Ava has already met, and what they discussed
MATCH (a:Attendee {id: "ava"})-[:MET]->(other:Attendee)
      -[:INTERESTED_IN]->(topic:Topic)
RETURN other.name, collect(topic.name) AS shared_topics;
