# EventAssist Electron app

Offline desktop wrapper for the EventAssist deep-graph product (product v4).

## Launch on your computer
```bash
cd electron
npm install
npm start
```
That opens EventAssist in its own desktop window — no server, no token, no browser tab needed.

## What it loads
`index.html` is product_v4.html: clickable deep graph (19 nodes, 26 edges), Agents live, Patterns P1–P6, FalkorDB tools, Qodo panel, Pitch panel.

## Live FalkorDB (optional, separate)
The desktop app itself is offline. To verify live, open FalkorDB Cloud instance-si114dlr3, Browser, graph `eventassist`, run `load_graph_complete.cypher`, then `queries_complete.cypher`.
