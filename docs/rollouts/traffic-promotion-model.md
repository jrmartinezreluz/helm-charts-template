# Traffic promotion model

Artifact promotion (digest along DEV→STAGING→UAT→PRODUCTION) is unchanged from Phase 06.

Traffic promotion is **not** a GitOps image copy.

```text
GitOps digest PR
    ↓
Argo CD Sync (spec)
    ↓
Rollout preview ReplicaSet + previewService
    ↓
validate preview host
    ↓
kubectl argo rollouts promote
    ↓
activeService
```

Initial production-ready path: **manual operator promote**. `rollout-promote.yml` only prints the command (no cluster credentials).

Future GitHub automation: GitHub Environment approval → short-lived auth (EKS OIDC / `aws eks get-token`, or controlled RKE2 operator access) → promote. Do not store kubeconfig, RKE2 tokens, or static AWS keys in Actions.

`promote` vs `promote --full`: with `autoPromotionEnabled: false` and no Analysis pause, `promote` unpauses blue/green and makes preview active. `--full` skips remaining pauses/analysis; it is **not meaningful** until AnalysisTemplate is wired. Prefer `promote` now.

`traffic-promote.yml` is LEGACY. `gitops-update.py promote-traffic` refuses `rollout.enabled`.
