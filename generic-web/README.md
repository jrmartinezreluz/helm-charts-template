# generic-web

Reference implementation of `arkhadia-common` for a single HTTP Deployment.

Dormant in GitOps until a values file exists under `clusters/*/apps/`. Default `values.yaml` uses a public nginx image so `helm template` works; real apps must override `image`.

Optional controls (`podDisruptionBudget`, `autoscaling`, `networkPolicy`, `topologySpread`) default to **off**. ServiceAccount is created and used (not `default`).
