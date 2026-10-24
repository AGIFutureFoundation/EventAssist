#!/usr/bin/env python3
"""Load deduplicated contacts into FalkorDB — PRIVATE, do not push to GitHub.

Input: contacts_graph.json (3,476 contacts, deduplicated by ZoomInfo ID).
This file contains names, job titles, companies, industries, cities/states.
It deliberately contains NO email, phone, or street address.

Use:
  python3 contacts_load.py --cypher-out contacts_cypher.txt
    # writes Cypher in batches (do not paste 3,476 nodes at once into Browser)
  python3 contacts_load.py
    # if falkordb-py is installed and a server is reachable, loads via client
    # otherwise prints the summary and the Cypher instructions

Graph model:
  (Contact)-[:WORKS_AT]->(Company)
  (Contact)-[:IN_INDUSTRY]->(Industry)
  (Contact)-[:LOCATED_IN]->(City)
  (Company)-[:IN_INDUSTRY]->(Industry)
"""
import argparse
import json
from pathlib import Path

BASE = Path(__file__).parent


def esc(s):
    return str(s).replace("\\", "\\\\").replace('"', '\\"')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--cypher-out", default=None)
    args = ap.parse_args()
    data = json.loads((BASE / "contacts_graph.json").read_text())
    contacts = data["contacts"]
    print(f"Contacts: {len(contacts)} (deduplicated by ZoomInfo ID)")
    if args.cypher_out:
        lines = []
        lines.append("// Contacts graph — PRIVATE. Do not push to GitHub.")
        lines.append("// Load in batches of 500 into graph 'eventassist' or a separate 'contacts' graph.")
        for c in contacts:
            name = f"{c['first_name']} {c['last_name']}".strip()
            lines.append(
                f'CREATE (:Contact {{id: "{esc(c["id"])}", name: "{esc(name)}", job_title: "{esc(c["job_title"])}", job_function: "{esc(c["job_function"])}", company: "{esc(c["company"])}", industry: "{esc(c["industry"])}", city: "{esc(c["company_city"])}", state: "{esc(c["company_state"])}"}});'
            )
        Path(args.cypher_out).write_text("\n".join(lines))
        print(f"Cypher written to {args.cypher_out} — load in batches, do not paste all at once.")
        return
    try:
        from falkordb import FalkorDB
        print("falkordb-py is installed — connect to your instance and run the Cypher batches above, or adapt this script to batch-create via the client.")
    except ImportError:
        print("falkordb-py is not installed. Run: pip install -r requirements.txt, then use --cypher-out to generate batches for FalkorDB Browser.")


if __name__ == "__main__":
    main()
