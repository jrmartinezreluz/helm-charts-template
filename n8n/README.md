# n8n Helm chart

Workflow automation: Traefik, cert-manager, External Secrets, optional in-cluster PostgreSQL.

**This chart is not HA.** Deployment strategy is `Recreate`, default replica is 1, and PostgreSQL runs in-cluster with a PVC. PDB and HPA default to **disabled**. Safe horizontal scaling would need external RDS, queue mode, Redis, and multiple workers — not implemented here.

Exceptions: `volume-permissions` init runs as root to chown the data volume; in-cluster Postgres uses the image default user (not the n8n `securityContext`).

```bash
helm dependency update n8n/
helm template n8n ./n8n -f ../gitops-platform-template/clusters/nonprod/dev/n8n.yaml
```

| Value area | Purpose |
|------------|---------|
| `image.*` | `repository` / `tag` / `digest` / `pullPolicy` |
| `postgresql.enabled` | In-cluster Postgres; set false + `externalDatabase` for RDS |
| `persistence.storageClass` | Default `local-path`; override per cluster (e.g. `gp2` on EKS) |
| `platform.ingress.host` | e.g. `n8n-dev.example.internal` |
| `platform.externalSecrets.*` | AWS SM keys for env + DB credentials |

Chart version (`0.2.0`) is not `appVersion` (`1.108.2`).
