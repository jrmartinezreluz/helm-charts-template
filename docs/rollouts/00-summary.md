# 00 — Phase 07 summary

**Status:** Hotel frontend Helm model is an Argo Rollouts blue/green `Rollout`. Backend stays a `Deployment`. Controller is **not installed**. No live cluster, Argo, or AWS changes.

Traffic promotion is `kubectl argo rollouts promote` (manual). GitOps PRs still move **digests**. `traffic-promote.yml` is LEGACY and fails when `rollout.enabled` is true.

Proposed controller pin (not approved for live install): Helm chart `argo-rollouts` **2.43.0** / `argoproj/argo-rollouts` **v1.10.0**. Otherwise **VERSION TO BE SELECTED BEFORE LIVE INSTALL**.
