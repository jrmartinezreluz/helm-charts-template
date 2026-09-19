# Legacy compatibility

| Item | State |
|------|--------|
| `frontend.slots.blue/green` | retained in GitOps (unused when `rollout.enabled`) — REMOVE AFTER live Rollout cutover |
| `blueGreen.activeSlot` | retained; no longer owns traffic when Rollouts is enabled |
| Slot Deployments / `hotel-frontend-blue\|green` Services | rendered only if `rollout.enabled=false` — REMOVE AFTER ROLLOUT MIGRATION |
| `traffic-promote.yml` | LEGACY; updater refuses slot copy when rollout is enabled |
| `legacy-traffic-promote.yml` | LEGACY direct GitOps push |
| Hotel frontend summer/green bake in CI | retained as **demo artifact**, not a Rollout identity |
| Backend Deployment | retained |
| GitHub App / `GITOPS_PAT` | inherited Phase 06; PAT still BLOCKING |
| Manual hotel Argo sync | retained (especially production) |
| Rollouts controller | not installed |
