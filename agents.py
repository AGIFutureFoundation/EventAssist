#!/usr/bin/env python3
"""EventAssist agents — three agents, one shared graph.

ConciergeAgent: multi-hop talk answers with a path.
NetworkingAgent: shared-topic suggestions, excluding memory (already met).
ScheduleAgent: plan a day, detect clashes, suggest an alternative.

All three read and write the same in-memory graph state, mirroring the
FalkorDB graph in load_graph.cypher. Memory is explicit: meeting someone
adds a MET edge, so the next networking run no longer suggests them.
No external dependencies, no network, no secrets.
"""
import json
from pathlib import Path

DATA = json.loads((Path(__file__).parent / "graph_data.json").read_text())


class Graph:
    def __init__(self, data):
        self.data = data
        self.speakers = {s["id"]: s["name"] for s in data["speakers"]}
        self.talks = {t["id"]: t for t in data["talks"]}
        self.attendees = {a["id"]: a for a in data["attendees"]}
        # Shared state: plans and met edges, starting from the demo data.
        self.plans = {
            "ava": ["t1", "t3"],  # deliberate clash at 14:30, for the demo
            "priya": ["t1"],
            "marcus": ["t2"],
            "tom": ["t4"],
        }
        self.met = {a["id"]: set(a["met"]) for a in data["attendees"]}

    def meet(self, attendee_id, other_id):
        self.met[attendee_id].add(other_id)
        self.met[other_id].add(attendee_id)
        return f"{attendee_id} MET {other_id} — memory updated, future networking will exclude this pair."


class ConciergeAgent:
    def __init__(self, graph):
        self.graph = graph

    def talks_on_topic_after(self, topic, after="14:00"):
        out = []
        for talk in self.graph.data["talks"]:
            if topic in talk["topics"] and talk["starts"] >= after:
                out.append({
                    "title": talk["title"],
                    "speaker": self.graph.speakers[talk["speaker"]],
                    "starts": talk["starts"],
                    "venue": talk["venue"],
                    "path": f"Speaker({self.graph.speakers[talk['speaker']]}) -GIVES-> Talk({talk['title']}) -ABOUT-> Topic({topic})",
                })
        return out


class NetworkingAgent:
    def __init__(self, graph):
        self.graph = graph

    def suggest(self, attendee_id):
        me = self.graph.attendees[attendee_id]
        out = []
        for other in self.graph.data["attendees"]:
            if other["id"] == attendee_id or other["id"] in self.graph.met[attendee_id]:
                continue
            shared = sorted(set(me["interests"]) & set(other["interests"]))
            if shared:
                out.append({
                    "name": other["name"],
                    "shared_topics": shared,
                    "path": f"{me['name']} -INTERESTED_IN-> Topic{shared} <-INTERESTED_IN- {other['name']}, AND NOT {me['name']} -MET-> {other['name']}",
                })
        return out


class ScheduleAgent:
    def __init__(self, graph):
        self.graph = graph

    def plan(self, attendee_id):
        planned = [self.graph.talks[tid] for tid in self.graph.plans.get(attendee_id, [])]
        by_time = {}
        clashes = []
        for talk in planned:
            if talk["starts"] in by_time:
                clashes.append({
                    "time": talk["starts"],
                    "talks": [by_time[talk["starts"]]["title"], talk["title"]],
                    "path": f"Attendee -PLANS-> Talk -AT-> TimeSlot({talk['starts']}) <-AT- Talk <-PLANS- Attendee",
                    "suggestion": "Keep one, move the other, or pick a later talk on the same topic.",
                })
            else:
                by_time[talk["starts"]] = talk
        return {"planned": [t["title"] for t in planned], "clashes": clashes}


def demo():
    g = Graph(DATA)
    concierge = ConciergeAgent(g)
    networking = NetworkingAgent(g)
    schedule = ScheduleAgent(g)
    print("Concierge:")
    for r in concierge.talks_on_topic_after("Agents"):
        print(" ", r)
    print("Networking for Ava (before meeting Priya):")
    for r in networking.suggest("ava"):
        print(" ", r)
    print("Schedule for Ava:")
    print(" ", schedule.plan("ava"))
    print(g.meet("ava", "priya"))
    print("Networking for Ava (after meeting Priya):")
    for r in networking.suggest("ava"):
        print(" ", r)


if __name__ == "__main__":
    demo()
