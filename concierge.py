#!/usr/bin/env python3
"""EventAssist concierge — stdlib-only graph logic mirroring queries.cypher.

This is the stage-safe fallback: it runs the same multi-hop logic over
graph_data.json, so the demo works even if FalkorDB Docker is not running.
For a real FalkorDB instance, use queries.cypher, not this file.
"""
import json
from pathlib import Path

DATA = json.loads((Path(__file__).parent / "graph_data.json").read_text())


def concierge(topic="Agents", after="14:00"):
    out = []
    speakers = {s["id"]: s["name"] for s in DATA["speakers"]}
    for talk in DATA["talks"]:
        if topic in talk["topics"] and talk["starts"] >= after:
            out.append((talk["title"], speakers[talk["speaker"]], talk["starts"], talk["venue"]))
    return out


def networking(attendee_id="ava"):
    me = next(a for a in DATA["attendees"] if a["id"] == attendee_id)
    out = []
    for other in DATA["attendees"]:
        if other["id"] == attendee_id or other["id"] in me["met"]:
            continue
        shared = sorted(set(me["interests"]) & set(other["interests"]))
        if shared:
            out.append((other["name"], shared))
    return out


if __name__ == "__main__":
    print("Concierge — Agents after lunch:")
    for row in concierge():
        print(" ", row)
    print("Networking — for Ava:")
    for row in networking():
        print(" ", row)
