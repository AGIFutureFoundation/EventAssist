#!/usr/bin/env python3
"""EventAssist email + marketing agents — drafts only, never sends.

These agents read the SAME shared graph as agents.py, so every draft is
grounded in a graph path, not invented. Nothing here sends email, posts,
or contacts anyone. Every draft is marked DRAFT — FOR APPROVAL, and the
user must approve it before any send step is ever added.

Run: python3 agents_email_marketing.py
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from agents import Graph, NetworkingAgent, ConciergeAgent
import json

DATA = json.loads((Path(__file__).parent / "graph_data.json").read_text())


class EmailAgent:
    """Personalised follow-up / introduction emails, grounded in shared topics."""

    def __init__(self, graph):
        self.graph = graph
        self.networking = NetworkingAgent(graph)

    def introduction_email(self, attendee_id):
        me = self.graph.attendees[attendee_id]
        sugg = self.networking.suggest(attendee_id)
        if not sugg:
            return None
        target = sugg[0]
        return {
            "to": target["name"],
            "subject": f"Intro at Patch the Conference — shared {', '.join(target['shared_topics'])}",
            "body": (
                f"Hi {target['name'].split()[0]},\n\n"
                f"EventAssist suggested we meet because we both care about "
                f"{', '.join(target['shared_topics'])}.\n\n"
                f"Graph path: {target['path']}\n\n"
                f"Would you like to meet after the next talk? — {me['name']}\n"
            ),
            "status": "DRAFT — FOR APPROVAL — NOT SENT",
            "grounding": target["path"],
        }

    def workshop_reminder(self, attendee_id, talk_title, starts, venue):
        me = self.graph.attendees[attendee_id]
        return {
            "to": me["name"],
            "subject": f"Reminder: {talk_title} at {starts}, {venue}",
            "body": (
                f"Hi {me['name'].split()[0]},\n\n"
                f"Your planned talk '{talk_title}' starts at {starts} in {venue}.\n"
                f"Check your schedule in EventAssist first — there is a known "
                f"14:30 clash in the demo plan, so keep one talk and move the other.\n"
            ),
            "status": "DRAFT — FOR APPROVAL — NOT SENT",
        }


class MarketingAgent:
    """Event and workshop marketing copy, grounded in the graph, not hype."""

    def __init__(self, graph):
        self.graph = graph
        self.concierge = ConciergeAgent(graph)

    def workshop_blurb(self, topic):
        talks = self.concierge.talks_on_topic_after(topic)
        if not talks:
            return None
        titles = ", ".join(t["title"] for t in talks)
        return {
            "topic": topic,
            "headline": f"Why {topic} is the thread through this conference",
            "copy": (
                f"Every {topic} talk in the graph is linked, speaker to talk to topic, "
                f"so you can follow the thread instead of guessing. Talks: {titles}. "
                f"Ask EventAssist 'which talks on {topic} after lunch?' and it shows "
                f"its path, not just a list."
            ),
            "status": "DRAFT — FOR APPROVAL — NOT SENT",
            "talks": [t["title"] for t in talks],
        }

    def event_blurb(self):
        return {
            "headline": "Patch the Conference: fix the conference, don't just attend it",
            "copy": (
                "The broken parts are simple: you miss the right talk, you never meet "
                "the right person, and your plan clashes. EventAssist fixes all three "
                "with one shared graph — concierge, networking, and schedule — and "
                "remembers who you have already met, so it never suggests them again."
            ),
            "status": "DRAFT — FOR APPROVAL — NOT SENT",
        }


def demo():
    g = Graph(DATA)
    email = EmailAgent(g)
    marketing = MarketingAgent(g)
    print("Email draft — Ava -> Priya:")
    print(email.introduction_email("ava"))
    print("\nMarketing draft — Agents:")
    print(marketing.workshop_blurb("Agents"))
    print("\nMarketing draft — event:")
    print(marketing.event_blurb())


if __name__ == "__main__":
    demo()
