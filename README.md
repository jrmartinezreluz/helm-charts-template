# helm-charts-template

Sanitized Helm charts for GitOps delivery: a shared library plus example application charts (generic HTTP, hospitality blue/green, n8n, ERPNext wrapper).

This is a **curated public template**. It is **not** the live operational chart repository.

| Chart | Type | Notes |
|-------|------|-------|
| `library/arkhadia-common` | library | Labels, SA, PDB, NetworkPolicy, HPA, TLS, ESO, metrics helpers |
| `generic-web` | application | Reference HTTP workload |
| `hotel` | application | Frontend Rollout (blue/green) + backend |
| `n8n` | application | Workflow automation example |
| `erpnext` | application | Thin Frappe wrapper (upstream chart from helm.erpnext.com) |

Chart **directory names** are examples. Values defaults use `example.internal` and fictional secret paths.

## Usage

```bash
helm dependency build generic-web
helm lint generic-web
helm template generic-web ./generic-web
```

Pin consumers to a **tag or SHA**, not `@main`.

## Security defaults

Charts expect: non-root, dropped capabilities, NetworkPolicy support, PDB, resource requests/limits, optional External Secrets. See `docs/security.md`.

## Versioning

`Chart.yaml` `version` is the chart release. `appVersion` is the application version. Template tag `v0.1.0` is the first public snapshot.

## License

Apache-2.0. See `LICENSE` and `SECURITY.md`.
