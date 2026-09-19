# Analysis model

| Item | State |
|------|--------|
| `AnalysisTemplate` Helm template | DESIGNED (gated by `rollout.analysis.enabled`) |
| Wired into Rollout `prePromotionAnalysis` | NOT implemented |
| Prometheus 5xx / P95 for hotel Ingress | NOT verified (no hotel-specific Traefik/nginx PromQL in repo) |
| Blackbox `probe_success` | PRESENT for **hotel-dev** `/healthz` and `/api/health` in `cluster-nonprod` probes — not parameterized per env |
| Booking success KPI | FUTURE (app does not export it) |

Default: `rollout.analysis.enabled: false`. Do not invent PromQL.

Candidate (FUTURE, if blackbox covers the preview host):

```text
max(probe_success{job=~"blackbox.*", instance=~"<previewHost>.*"}) == 1
```

Prometheus address in values (`kube-prometheus-stack-prometheus.monitoring.svc:9090`) is a convention, **not verified** against the live Service name.
