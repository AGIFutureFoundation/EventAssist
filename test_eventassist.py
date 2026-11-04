#!/usr/bin/env python3
"""Tests for the EventAssist demo graph — stdlib only, no server needed.

Run: python3 test_eventassist.py
These verify the demo's claims, so a stage demo does not rely on hand-waving:
concierge multi-hop, networking with memory, schedule clash, and memory update.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from agents import Graph, ConciergeAgent, NetworkingAgent, ScheduleAgent
import json

DATA = json.loads((Path(__file__).parent / "graph_data.json").read_text())


def check(name, cond):
    print(("PASS" if cond else "FAIL"), name)
    if not cond:
        raise SystemExit(1)


def main():
    g = Graph(DATA)
    c, n, s = ConciergeAgent(g), NetworkingAgent(g), ScheduleAgent(g)

    talks = c.talks_on_topic_after("Agents")
    check("concierge returns 2 Agents talks after lunch", len(talks) == 2)
    check("concierge first talk is Sara Kim at 14:30", talks[0]["speaker"] == "Sara Kim" and talks[0]["starts"] == "14:30")
    check("concierge answers carry a graph path", all(" -GIVES-> " in t["path"] for t in talks))

    sugg = n.suggest("ava")
    names = [x["name"] for x in sugg]
    check("networking suggests Priya, not Marcus (already met)", "Priya Nair" in names and "Marcus Lee" not in names)
    check("networking shares Agents+GraphRAG with Priya", any(x["name"] == "Priya Nair" and x["shared_topics"] == ["Agents", "GraphRAG"] for x in sugg))

    plan = s.plan("ava")
    check("schedule detects the 14:30 clash", len(plan["clashes"]) == 1 and plan["clashes"][0]["time"] == "14:30")

    g.meet("ava", "priya")
    names_after = [x["name"] for x in n.suggest("ava")]
    check("memory update removes Priya from later suggestions", "Priya Nair" not in names_after)

    print("All EventAssist demo tests passed.")


if __name__ == "__main__":
    main()
