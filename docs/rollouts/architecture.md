# Architecture

```text
Argo CD Sync  → Rollout spec + digest + Services + Ingress
Argo Rollouts → ReplicaSet progression, preview, promote, abort, undo
```

Hotel:

| Object | Kind |
|--------|------|
| `hotel-backend` | Deployment |
| `hotel-frontend` | Rollout (`strategy.blueGreen`) |
| `hotel-frontend-active` | Service (`activeService`) |
| `hotel-frontend-preview` | Service (`previewService`) |

Ingress hosts are unchanged (`hotel*.example.internal` / `hotel-preview*.example.internal`). DNS is not migrated.

## Backend options (not implemented)

| Option | Meaning |
|--------|---------|
| **A (this phase)** | Frontend-only Rollout. Backend is shared; preview does not validate a new backend alone. |
| B | Independent backend Rollout |
| C | Full release stack preview |

## Theme

CI still bakes a **summer** frontend image. That is demo content, not a Rollout color. Active vs preview is ReplicaSet identity.

## GitHub App / PAT / OIDC

Inherited from Phase 06. PAT fallback remains BLOCKING. No kubeconfig in GitHub secrets. OIDC environment claims still not applied.
