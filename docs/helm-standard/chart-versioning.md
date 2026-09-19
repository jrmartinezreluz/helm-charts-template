# Chart versioning

| Field | Meaning |
|-------|---------|
| `Chart.yaml` `version` | Helm chart release (this repo’s packaging) |
| `Chart.yaml` `appVersion` | Application / container version |

They are independent. Bumping probes in the chart is a chart `version` bump, not an `appVersion` bump.

## Current pins

| Chart | version | appVersion |
|-------|---------|------------|
| arkhadia-common | 0.1.0 | (library; none) |
| generic-web | 0.2.0 | 1.0.0 |
| hotel | 0.2.0 | 1.0.0 |
| n8n | 0.2.0 | 1.108.2 |
| erpnext | 0.2.0 | 15 |

Application charts **must pin** `arkhadia-common` `0.1.0`. After library changes: bump library version, bump the pin, `helm dependency update`, commit `charts/*.tgz` and `Chart.lock`.

ERPNext upstream remains `7.0.159` (vendored). Do not float that without an explicit bump.
