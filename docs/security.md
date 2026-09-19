# Security defaults

- `podSecurityContext.runAsNonRoot: true` and dropped capabilities where the workload allows
- NetworkPolicy helpers in `arkhadia-common`
- PDB and HPA opt-in
- External Secrets paths are **examples** (`apps/<app>/<env>/...`)
- TLS examples use `example.internal` and a placeholder ClusterIssuer
