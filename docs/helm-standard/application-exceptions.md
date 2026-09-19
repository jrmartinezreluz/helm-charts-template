# Application exceptions

No silent gaps: if the common baseline is not applied, it is listed here.

## generic-web

Full baseline **reference**. PDB/HPA/NP off by default because `replicaCount: 1`. Default image is public nginx so `helm template` works; real apps must override `image`. `readOnlyRootFilesystem: false` (nginx cache).

## hotel

- Blue/green slots, active/preview Services, and Ingress paths are **unchanged**.
- Frontend replicas are Helm-owned (no slot HPA) until Argo Rollouts.
- TLS Certificate **not** created by default (`certificate.create: false`); uses platform wildcard secret.
- No ExternalSecrets (chart never had application secrets).
- PDB/HPA/NP default off.
- `backend.image.repository` still required at render time for a real deploy (GitOps supplies it).

## n8n

- Strategy **Recreate** retained.
- PDB disabled; HPA disabled.
- `volume-permissions` init runs as **root** (`runAsUser: 0`) to chown the data PVC.
- In-cluster PostgreSQL does **not** use the n8n container `securityContext` (image default user).
- Egress must remain allow-all if NetworkPolicy is ever enabled (workflow HTTP).
- Future HA (RDS + queue + Redis + workers) is **not** implemented.

## erpnext

- Thin wrapper; do not fork upstream templates.
- **Upstream owns:** Frappe Deployments/StatefulSets, ServiceAccount `{{ .Release.Name }}`, HPA templates, Redis/MariaDB PDBs, probes/resources on Frappe containers.
- Wrapper owns: Ingress, Certificate, ExternalSecrets, create-site Job, common labels on wrapper objects.
- `dbRootPassword` is a non-functional placeholder so upstream still emits `secretKeyRef`.
- No wrapper PDB/HPA/NetworkPolicy for Frappe pods.
