# Deep project review — EventAssist — 2026-10-24 ~16:34 PDT

## Verdict
Core demo is sound and verified. Submission is NOT yet submittable as a complete package: it is blocked on exactly one required field (demo video) plus two credibility gaps (GitHub repo still empty, Cloud graph load still unconfirmed). Do not claim those three as done.

## Verified in this review (re-run, not carried over)
- test_eventassist.py: 7/7 PASS — concierge 2 Agents talks, first Sara Kim 14:30, paths present, networking Priya not Marcus, Priya shares Agents+GraphRAG, 14:30 clash, memory update removes Priya.
- agents.py: runs OK.
- agents_email_marketing.py: runs OK, drafts only, never sent.
- contacts_load.py: 3,477 Cypher lines = header + 3,476 contacts, deduplicated by ZoomInfo ID. Summary confirms 3,476 unique.
- product_v2.html and presentation.html: HTML parses OK. product_v2 JS was syntax-checked earlier.
- Privacy: contacts_graph.json is NOT in the GitHub bundle (checked: file absent). Bundle contains only aggregates (contacts_summary.json, contacts_patterns.md) + demo graph + loader. References to contacts_graph.json in docs/loader are instructions, not the data itself.
- Qodo: Qodo.ai connected to GitHub (Mike, ~16:33 PDT). .pr_agent.toml + QODO_SETUP.md in bundle. Verified 0 open PRs in EventAssist, so Qodo has nothing to review yet.
- Submission form (WeMakeDevs, signed in): filled, not submitted. 7/11 answered, Project Details 6/7, Track Details 1/4. Filled: title EventAssist, repo URL, live demo product_v2 link, FalkorDB Track only, problem, what built/how, how FalkorDB used, deck link in the build description. Left blank: Demo video (required), other-track fields (correctly blank, FalkorDB only), feedback (optional, blank).

## Graph — deep check
- Model: Speaker-GIVES-Talk-ABOUT-Topic, Attendee-INTERESTED_IN-Topic, Attendee-MET-Attendee, Attendee-PLANS-Talk, Talk-AT-TimeSlot.
- Complete load file: load_graph_complete.cypher, expected 19 nodes / 26 edges (verified by count at build time; file unchanged since 16:09 PDT).
- Patterns: P1 topic hub, P2 shared-topic clique Ava↔Priya (2 topics), P3 speaker hub Sara Kim (2 talks), P4 memory, P5 clash 14:30 only, P6 unmet high-fit introductions.
- Workshops deep: 4 workshops, each with attendees, networking, clash, email/marketing drafts, graph proof. No invented speaker bios; talk durations are not in the graph, so learning flows are thematic, not timed.

## Stack — deep check
- FalkorDB Cloud instance-si114dlr3, graph eventassist, Cypher via Browser.
- Python 3.12 stdlib agents, no server required for the offline product.
- Offline HTML product_v2.html: attendee+topic selectors, live concierge/networking/schedule, memory mark-as-met, workshops deep, judges checklist.
- Deck: presentation.html Slides 9–10 = tech stack + judges criteria scorecard (all 4 FalkorDB criteria mapped to evidence).
- Honest limits: Docker unavailable in this VM, falkordb-py not installed, live proof via Browser Cypher, requirements falkordb>=1.0. Deliberately no Bright Data / TrueForge / Qodo on stage for the primary track.

## Remaining blockers, in order
1. Demo video (REQUIRED for submission): narration 2:54 total, 8 slides, fast 5fps encode still running at 16:34 PDT, file partial (moov not found). When it verifies, upload it, enter the link in Demo video, and submit the already-filled form.
2. GitHub: repo still LICENSE-only. Muse GitHub App 403 on branch eventassist-v1 (3 attempts). Qodo connected does not fix Muse app access. Manual push via PUSH_TO_GITHUB.md, then open a PR so Qodo can review.
3. FalkorDB Cloud graph load: still unconfirmed in Mike's open app. Expected 19 nodes / 26 edges in eventassist, plus contacts in batches if loaded separately (3,476).
4. Submission form remainder: after video, confirm the 4 unanswered items (1 Project Details + 3 Track Details in the browser's count) are either video-related or correctly blank, before clicking Submit.

## What was NOT done in this review
- No email sent. No graph created/changed/deleted in FalkorDB Cloud by Muse. No GitHub branch/file/PR/push succeeded. No WeMakeDevs submission submitted. No Qodo key/secret created or stored.
