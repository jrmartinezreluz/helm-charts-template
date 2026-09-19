# Rollout values model

```yaml
rollout:
  enabled: true
  autoPromotionEnabled: false   # env-specific
  scaleDownDelaySeconds: 30     # 300 in production GitOps
  analysis:
    enabled: false
frontend:
  image:
    repository: ...
    tag: sha-<git>
    digest: sha256:...          # authoritative when set
```

| Environment | `autoPromotionEnabled` |
|-------------|------------------------|
| dev | `true` (velocity; Sync ≈ live after digest) |
| staging | `true` (short automatic; still a separate Rollouts step if you later set false) |
| uat | `false` (preview URL, then manual promote). UAT DNS/SM may be missing — not live. |
| production | `false` (mandatory). Argo CD stays **manual sync**. Destination unverified. |

Recommended later (not applied): auto-sync Rollout **spec** on dev/staging/uat; keep production manual until `cluster-prod` is verified. Traffic promote stays separate wherever `autoPromotionEnabled` is false.
