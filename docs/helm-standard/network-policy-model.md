# NetworkPolicy model

All charts: `networkPolicy.enabled: false` by default.

When enabled, the library emits default-deny-shaped policy types Ingress+Egress, plus:

- DNS to `kube-system` :53 if `networkPolicy.dns: true`
- empty egress rule (`{}`) if `allowAllEgress: true` (default in app values)
- `networkPolicy.ingress` from values (any namespace → app port)

Tight Traefik-only selectors are **not** assumed (controller namespace/labels differ on RKE2 vs EKS).

## Per application (intended traffic)

### hotel

Browser → Traefik Ingress → frontend (active/preview) and backend (`/api`). Frontend does not need pod-to-pod calls to backend for the current Ingress split. Egress: DNS; backend may need external APIs later — `allowAllEgress: true` until proven otherwise.

### erpnext

Ingress → wrapper Service → Frappe. Frappe → RDS, Redis, internal components. ESO runs in the controller, not in app pods. Wrapper does **not** emit a release-wide NetworkPolicy (would catch upstream pods). Leave disabled; do not invent Frappe NP in the wrapper.

### n8n

Ingress → n8n. n8n → PostgreSQL. Workflows call **arbitrary Internet APIs**. Enabling NP with `allowAllEgress: false` would break workflows. Default `allowAllEgress: true` and `enabled: false`.

### generic-web

Ingress → app port. DNS. Optional extra ingress/egress in values. `allowAllEgress: true` until an app proves it can deny.
