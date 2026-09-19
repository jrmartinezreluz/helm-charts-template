# Hotel — Argo Rollouts frontend (chart 0.3.0)

Frontend traffic is an Argo Rollouts **blue/green** `Rollout`. Backend stays a `Deployment`.

Argo CD Sync applies the Rollout spec (digest, replicas, config). It does **not** cut over production traffic when `rollout.autoPromotionEnabled` is false.

## Values

| Key | Purpose |
|-----|---------|
| `rollout.enabled` | `true` (default): frontend is a Rollout |
| `rollout.autoPromotionEnabled` | `false` in UAT/production; `true` in DEV (and staging) |
| `frontend.image` | Single frontend artifact (`repository` / `tag` / `digest`) |
| `backend.image` | Shared API (active and preview frontends) |
| `blueGreen.activeSlot` / `frontend.slots` | **LEGACY** — only when `rollout.enabled=false` |

## Services

| Service | Role |
|---------|------|
| `hotel-frontend-active` | `activeService` — production host |
| `hotel-frontend-preview` | `previewService` — preview host |

Selectors are stable `app.kubernetes.io/*` labels. Argo Rollouts owns the ReplicaSet hash on the Service; do not set `hotel/slot` when Rollouts is enabled.

## Traffic vs artifact

- Artifact promotion: GitOps digest PR (`ci.yml` / `promote.yml`).
- Traffic promotion: `kubectl argo rollouts promote` (manual). `traffic-promote.yml` is LEGACY.

## Theme / summer image

CI still bakes a **summer** frontend image for the demo. That is application content, not a Rollout slot identity. Do not rebuild to change traffic state.

Chart version is independent of `appVersion`. Consumes `arkhadia-common` 0.1.0.

Do not enable `frontend.autoscaling` (no frontend HPA). PDB/NetworkPolicy/HPA default **disabled**.
