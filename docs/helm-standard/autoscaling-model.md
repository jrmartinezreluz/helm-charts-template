# Autoscaling model

HPA helpers target **Deployments** only. Default `autoscaling.enabled: false`.

When enabled, the Deployment omits `spec.replicas` so HPA owns the count.

## hotel

| Workload | HPA |
|----------|-----|
| backend | Optional `backend.autoscaling`. If enabled, Helm does not set backend replicas. |
| frontend slots | **No HPA template.** `frontend.replicaCount` stays Helm-owned until Phase 07 Argo Rollouts. Argo ApplicationSet already ignores Deployment replica diffs. |

Do not enable backend HPA and a GitOps replicaCount override at the same time.

## erpnext

Upstream chart already has `hpa-gunicorn`, `hpa-nginx`, `hpa-socketio`, `hpa-worker-*`. Defaults are off in upstream values. Wrapper does not add a second HPA for those pods. Override `erpnext.*.autoscaling` in GitOps if needed later.

## n8n

HPA template exists but default **disabled**. Recreate + PVC + in-cluster Postgres is not horizontally scalable. Prerequisites for a later HA n8n: external RDS, queue mode, Redis, workers.

## generic-web

Optional HPA; default off. Stateless candidate once replicaCount ≥ 2.
