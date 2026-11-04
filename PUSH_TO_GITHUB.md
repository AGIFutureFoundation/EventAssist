# Push this to EventAssist (from your laptop)

The Muse GitHub App is not installed on AGIFutureFoundation/EventAssist yet,
so Muse cannot push directly — it gets 403 "Resource not accessible by integration" (retried 2026-10-24 ~16:35 PDT, same 403).

Fix it once, then push, OR push from your own machine right now (no app needed):

```bash
git clone https://github.com/AGIFutureFoundation/EventAssist.git
cd EventAssist
cp -r /path/to/eventassist-github-bundle/* .
cp -r /path/to/eventassist-github-bundle/pictures pictures/ 2>/dev/null || true
git checkout -b eventassist-v1
git add -A
git commit -m "EventAssist: conference concierge graph demo (FalkorDB track) + wiki, pictures, Qodo config"
git push -u origin eventassist-v1
```

Then open a pull request from eventassist-v1 to main on GitHub — Qodo (connected to GitHub) should then auto-review it, or comment `/review` on the PR.

## What is in this bundle (29 files/dirs)
- Wiki: WIKI.md (detailed, 12 sections) — this is the wiki page content. For a GitHub Wiki tab, also copy WIKI.md into the EventAssist.wiki repo as Home.md, or link to it from the repo README.
- Pictures: pictures/graph_diagram.png + pictures/slide1.png … slide8.png
- Videos: pitch video is NOT yet in this bundle — it was still encoding at 16:35 PDT and unverified. Add pitch_video/pitch_video_fast.mp4 (or the verified final MP4) after ffprobe shows ~174s and it plays, then upload it to YouTube/Loom/Drive for the submission Demo video field.
- Code/demo/deck: README, agents, concierge, demo/app/product/product_v2 HTML, presentation, workshops + workshops_deep, patterns, load/query Cypher (original + complete), graph_data.json, contacts_summary/patterns/loader/template, optimized-resources, Qodo config + setup, deep_review, submission_draft.

## Do NOT push
- contacts_graph.json — private, not in this bundle. Do not add it.
- Full contact Cypher, individual emails/phones/street addresses, tokens/passwords.

Demo first: open product_v2.html in a browser — it works with no server, no token.
Real graph: FalkorDB Cloud instance-si114dlr3, Browser, graph eventassist, run load_graph_complete.cypher, then queries_complete.cypher. Expected 19 nodes / 26 edges.
