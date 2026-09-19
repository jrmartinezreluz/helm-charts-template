# arkhadia-common

Helm **library** chart (`type: library`). It only provides named templates. Application charts pin an exact version:

```yaml
dependencies:
  - name: arkhadia-common
    version: 0.1.1
    repository: "file://../library/arkhadia-common"
```

There is no remote Helm repository for this library. Do not invent one.

## Helpers

| Define | Purpose |
|--------|---------|
| `arkhadia-common.labels` / `selectorLabels` | Kubernetes recommended labels + optional `platform.example/*` |
| `arkhadia-common.image` | `repo@digest` if digest set, else `repo:tag` |
| `arkhadia-common.serviceAccount.manifest` | Configurable ServiceAccount (IRSA annotations allowed, empty by default) |
| `arkhadia-common.pdb.manifest` | Optional PDB |
| `arkhadia-common.hpa.manifest` | Optional HPA (Deployment) |
| `arkhadia-common.networkPolicy.manifest` | Optional NP |
| `arkhadia-common.certificate.manifest` | Optional cert-manager Certificate |
| `arkhadia-common.externalSecret.extract` | ESO dataFrom extract |
| `arkhadia-common.podSecurityContext` | Pod security snippet |
| `arkhadia-common.topologySpread` / `podAntiAffinity` | Optional scheduling |
| `arkhadia-common.serviceMonitor.manifest` | Optional ServiceMonitor (`release: kube-prometheus-stack`) |
| `arkhadia-common.prometheusRule.manifest` | Optional PrometheusRule |
| `arkhadia-common.dashboard.manifest` | Optional Grafana dashboard ConfigMap |

`global.environment` and `application.name` from GitOps are **optional**. Charts render without them.
