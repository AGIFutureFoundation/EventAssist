// EventAssist — COMPLETE graph load for FalkorDB Cloud.
// Graph name: eventassist
// This is the original load_graph.cypher, PLUS the two pieces the
// original was missing for the 4 demo queries to work in a real FalkorDB:
//  - TimeSlot nodes + Talk -[:AT]-> TimeSlot
//  - Attendee -[:PLANS]-> Talk (Ava plans t1 + t3 = the 14:30 clash)
// Load this file instead of the original if you want all 4 queries to return.
// If you already loaded the original, just run the "ADDITIONS" section at the end.
//
// In FalkorDB Cloud: open instance-si114dlr3, open Browser, select / create
// graph "eventassist", paste, run. If Browser runs one statement at a time,
// run it in blocks. Do NOT run twice without clearing first, or you will
// get duplicate nodes. To clear: MATCH (n) DETACH DELETE n

CREATE (sara:Speaker {id: "sara", name: "Sara Kim"});
CREATE (diego:Speaker {id: "diego", name: "Diego Ramos"});
CREATE (lena:Speaker {id: "lena", name: "Lena Park"});

CREATE (t1:Talk {id: "t1", title: "Agents That Remember: Graph Memory in Production", starts: "14:30", venue: "Main Hall"});
CREATE (t2:Talk {id: "t2", title: "Multi-Hop Reasoning Without Hallucinating", starts: "15:15", venue: "Room B"});
CREATE (t3:Talk {id: "t3", title: "Robotics on the Factory Floor", starts: "14:30", venue: "Room C"});
CREATE (t4:Talk {id: "t4", title: "GraphRAG From Docs to Answers", starts: "16:00", venue: "Main Hall"});

CREATE (agents:Topic {name: "Agents"});
CREATE (graphrag:Topic {name: "GraphRAG"});
CREATE (robotics:Topic {name: "Robotics"});
CREATE (security:Topic {name: "Security"});
CREATE (data:Topic {name: "Data"});

MATCH (s:Speaker {id: "sara"}), (t:Talk {id: "t1"}) CREATE (s)-[:GIVES]->(t);
MATCH (s:Speaker {id: "diego"}), (t:Talk {id: "t2"}) CREATE (s)-[:GIVES]->(t);
MATCH (s:Speaker {id: "lena"}), (t:Talk {id: "t3"}) CREATE (s)-[:GIVES]->(t);
MATCH (s:Speaker {id: "sara"}), (t:Talk {id: "t4"}) CREATE (s)-[:GIVES]->(t);

MATCH (t:Talk {id: "t1"}), (topic:Topic {name: "Agents"}) CREATE (t)-[:ABOUT]->(topic);
MATCH (t:Talk {id: "t1"}), (topic:Topic {name: "GraphRAG"}) CREATE (t)-[:ABOUT]->(topic);
MATCH (t:Talk {id: "t2"}), (topic:Topic {name: "Agents"}) CREATE (t)-[:ABOUT]->(topic);
MATCH (t:Talk {id: "t3"}), (topic:Topic {name: "Robotics"}) CREATE (t)-[:ABOUT]->(topic);
MATCH (t:Talk {id: "t4"}), (topic:Topic {name: "GraphRAG"}) CREATE (t)-[:ABOUT]->(topic);

CREATE (ava:Attendee {id: "ava", name: "Ava Chen"});
CREATE (marcus:Attendee {id: "marcus", name: "Marcus Lee"});
CREATE (priya:Attendee {id: "priya", name: "Priya Nair"});
CREATE (tom:Attendee {id: "tom", name: "Tom Rivera"});

MATCH (a:Attendee {id: "ava"}), (topic:Topic {name: "Agents"}) CREATE (a)-[:INTERESTED_IN]->(topic);
MATCH (a:Attendee {id: "ava"}), (topic:Topic {name: "GraphRAG"}) CREATE (a)-[:INTERESTED_IN]->(topic);
MATCH (a:Attendee {id: "marcus"}), (topic:Topic {name: "Agents"}) CREATE (a)-[:INTERESTED_IN]->(topic);
MATCH (a:Attendee {id: "priya"}), (topic:Topic {name: "Agents"}) CREATE (a)-[:INTERESTED_IN]->(topic);
MATCH (a:Attendee {id: "priya"}), (topic:Topic {name: "GraphRAG"}) CREATE (a)-[:INTERESTED_IN]->(topic);
MATCH (a:Attendee {id: "tom"}), (topic:Topic {name: "GraphRAG"}) CREATE (a)-[:INTERESTED_IN]->(topic);

MATCH (a:Attendee {id: "ava"}), (b:Attendee {id: "marcus"}) CREATE (a)-[:MET]->(b);
MATCH (a:Attendee {id: "marcus"}), (b:Attendee {id: "ava"}) CREATE (a)-[:MET]->(b);

// --- ADDITIONS: TimeSlots, AT, PLANS (missing from the original) ---
CREATE (slot1430:TimeSlot {id: "slot-1430", time: "14:30"});
CREATE (slot1515:TimeSlot {id: "slot-1515", time: "15:15"});
CREATE (slot1600:TimeSlot {id: "slot-1600", time: "16:00"});

MATCH (t:Talk {id: "t1"}), (s:TimeSlot {id: "slot-1430"}) CREATE (t)-[:AT]->(s);
MATCH (t:Talk {id: "t2"}), (s:TimeSlot {id: "slot-1515"}) CREATE (t)-[:AT]->(s);
MATCH (t:Talk {id: "t3"}), (s:TimeSlot {id: "slot-1430"}) CREATE (t)-[:AT]->(s);
MATCH (t:Talk {id: "t4"}), (s:TimeSlot {id: "slot-1600"}) CREATE (t)-[:AT]->(s);

MATCH (a:Attendee {id: "ava"}), (t:Talk {id: "t1"}) CREATE (a)-[:PLANS]->(t);
MATCH (a:Attendee {id: "ava"}), (t:Talk {id: "t3"}) CREATE (a)-[:PLANS]->(t);
MATCH (a:Attendee {id: "priya"}), (t:Talk {id: "t1"}) CREATE (a)-[:PLANS]->(t);
MATCH (a:Attendee {id: "marcus"}), (t:Talk {id: "t2"}) CREATE (a)-[:PLANS]->(t);
MATCH (a:Attendee {id: "tom"}), (t:Talk {id: "t4"}) CREATE (a)-[:PLANS]->(t);

// --- VERIFY (run after load) ---
// MATCH (n) RETURN count(n) AS nodes;
// MATCH ()-[r]->() RETURN count(r) AS edges;
// Expected: 19 nodes (3 speakers + 4 talks + 5 topics + 4 attendees + 3 timeslots)
//           26 edges (4 GIVES + 5 ABOUT + 6 INTERESTED_IN + 2 MET + 4 AT + 5 PLANS)
