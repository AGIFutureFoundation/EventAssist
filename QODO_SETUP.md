# Qodo setup for EventAssist — what Muse prepared, and what only you can click

## What is ready (local, in the GitHub bundle)
- `.pr_agent.toml` at the repo root — auto-review on PRs (`/review`, `/describe`, `/improve`), with EventAssist-specific instructions: graph/Cypher correctness, no invented contacts/speakers/talks, no individual email/phone/address, no pushing contacts_graph.json to GitHub, and test_eventassist.py must keep passing.
- After Qodo is installed, use it on a PR with comments: `/review`, `/describe`, `/improve`, `/ask <question>`, `/test`.

## What only an org admin can do (Muse cannot install a third-party GitHub App for you)
1. Go to the Qodo portal → Integrations → GitHub → Add installation, and start the wizard. Docs: https://docs.qodo.ai/qodo-documentation/code-review/qodo-merge/getting-started/setup-and-installation/github
2. Click Connect your organization, authorize on GitHub, and select repositories — select **AGIFutureFoundation/EventAssist** (or All repositories, then enable EventAssist in the Qodo portal).
3. Click Install, return to the Qodo wizard, and Finish installation. Qodo then syncs/indexes the repo and PRs in the background.
4. Verify: open a PR in EventAssist. Qodo should auto-review it, or comment `/review` on the PR to trigger it manually.

## Status update — 2026-10-24 ~16:33 PDT
- Qodo.ai is now connected to GitHub (confirmed by Mike). The portal install step above is done.
- Verified at that time: EventAssist still has 0 open PRs, so Qodo has nothing to review yet.

## Blockers that apply right now
- EventAssist on GitHub is still LICENSE-only, and Muse's GitHub App still gets 403 on it. Qodo cannot review code that isn't in a PR yet — first push the bundle (manually, via PUSH_TO_GITHUB.md, or after fixing app access), open a PR from eventassist-v1, then Qodo will have something to review.
- Qodo is a separate $500 track (Best use of Qodo). The primary submission remains FalkorDB ($1,500). One prize per track — do not present Qodo as replacing the FalkorDB story on stage; present it as code-review tooling on the EventAssist repo.
- No Qodo API key, secret, or account was created or stored by Muse. Do not put a Qodo key in the repo; if you use the GitHub Actions self-hosted route instead of the managed app, put it in GitHub Secrets only.
