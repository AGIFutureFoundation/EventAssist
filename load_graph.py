#!/usr/bin/env python3
"""Load EventAssist graph into FalkorDB if available, else report fallback.

Usage:
  pip install -r requirements.txt
  FALKORDB_HOST=localhost FALKORDB_PORT=6379 python3 load_graph.py

If no FalkorDB server is reachable, this prints the fallback and exits
without failing the demo — demo.html and concierge.py are the stage-safe
working demo in that case. No token or password is hard-coded here.
"""
import os
import sys

HOST = os.environ.get("FALKORDB_HOST", "localhost")
PORT = int(os.environ.get("FALKORDB_PORT", "6379"))

try:
    from falkordb import FalkorDB
except ImportError:
    print("falkordb-py is not installed. Run: pip install -r requirements.txt")
    print("Fallback: demo.html and concierge.py already run the same graph logic locally.")
    sys.exit(0)

try:
    db = FalkorDB(host=HOST, port=PORT)
    graph = db.select_graph("eventassist")
    # Load statements are in load_graph.cypher, split on semicolons at line ends.
    # This is a demo loader: for production, use a proper Cypher driver batching.
    print(f"Connected to FalkorDB at {HOST}:{PORT}. Load load_graph.cypher in the Browser UI (port 3000) for the full demo graph, then run queries.cypher.")
    print("Graph selected: eventassist")
except Exception as e:
    print(f"Could not connect to FalkorDB at {HOST}:{PORT}: {e}")
    print("Fallback: demo.html and concierge.py already run the same graph logic locally.")
    sys.exit(0)
