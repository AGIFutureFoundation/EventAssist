// Load the EventAssist demo graph into FalkorDB.
// Run in FalkorDB Browser (port 3000) or via the Python client.
// Graph name: eventassist

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
