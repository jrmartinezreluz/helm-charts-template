# Availability baseline

## PodDisruptionBudget

Defaults **enabled: false**.

| Chart | Why |
|-------|-----|
| generic-web | Single-replica default; enabling PDB would block drain |
| hotel backend | Optional `backend.podDisruptionBudget` |
| hotel frontend | Optional; selects both slots. Do not enable at replica=1 per slot |
| n8n | Recreate + 1 replica — PDB would be dishonest HA |
| erpnext | Upstream Redis/MariaDB have PDBs; wrapper does not add gunicorn/worker PDBs |

`minAvailable` / `maxUnavailable` are mutually exclusive in the helper (minAvailable wins if both set).

## Topology

`topologySpread` (zone) and `podAntiAffinity` (hostname) default **off**. Keys used: `topology.kubernetes.io/zone`, `kubernetes.io/hostname`. No AWS-specific keys.

## StorageClass

Exposed where PVCs exist (`n8n.persistence.storageClass`, `n8n.postgresql.persistence.storageClass`, upstream `erpnext.persistence.worker.storageClass`). Chart default `local-path`; GitOps production n8n already overrides `gp2`. No EBS/EFS hardcoding in charts.

## IngressClass

`platform.ingress.className` stays configurable (default `traefik`). Do not assume a future class named `web`.
