# Common library

Path: `library/arkhadia-common/`

```yaml
type: library
version: 0.1.0
```

Application charts pin this version with a **file://** dependency (no remote Helm repo):

```yaml
dependencies:
  - name: arkhadia-common
    version: "0.1.0"
    repository: "file://../library/arkhadia-common"
```

Vendored tarball: `<chart>/charts/arkhadia-common-0.1.0.tgz` plus `Chart.lock`. Rebuild with `helm dependency update` after library changes.

The library does not install Kubernetes objects unless an application chart `include`s a `*.manifest` helper.

## Helpers

| Define | Role |
|--------|------|
| `arkhadia-common.name` / `fullname` / `chart` | Naming |
| `arkhadia-common.labels` / `selectorLabels` | Recommended labels + optional `platform.example/*` |
| `arkhadia-common.image` | `repository@digest` else `repository:tag` |
| `arkhadia-common.serviceAccount.manifest` | SA + IRSA annotation hook (empty by default) |
| `arkhadia-common.pdb.manifest` | Optional PDB |
| `arkhadia-common.hpa.manifest` | Optional HPA (Deployment) |
| `arkhadia-common.networkPolicy.manifest` | Optional NP |
| `arkhadia-common.certificate.manifest` | Optional cert-manager Certificate |
| `arkhadia-common.externalSecret.extract` | ESO extract |
| `arkhadia-common.podSecurityContext` / `containerSecurityContext` | Snippets |
| `arkhadia-common.topologySpread` / `podAntiAffinity` | Optional scheduling |

`global.*` / `application.*` from Phase 04 GitOps are **optional**. Charts render with chart `values.yaml` alone.
