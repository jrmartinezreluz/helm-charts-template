# Security baseline

Applied where the workload allows it. Exceptions: [application-exceptions.md](application-exceptions.md).

## ServiceAccount

| Chart | create (default) | Notes |
|-------|------------------|--------|
| generic-web | true | Pods use it; `automountServiceAccountToken: false` |
| hotel | true | Shared by backend + both frontend slots |
| n8n | true | n8n + in-cluster Postgres |
| erpnext | false (no wrapper SA) | Upstream Frappe chart owns `{{ .Release.Name }}` |

`serviceAccount.annotations` may hold IRSA / Pod Identity later. Phase 05 does not set IAM role ARNs.

## Pod / container security

Default for generic-web, hotel, and the n8n **app** container:

```yaml
podSecurityContext:
  runAsNonRoot: true
  seccompProfile:
    type: RuntimeDefault
securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop: [ALL]
```

`readOnlyRootFilesystem` stays **false** (nginx/n8n/hotel need writable paths).

Not forced on: n8n volume-permissions init (root chown), n8n PostgreSQL (image user), ERPNext/Frappe/Redis (upstream).

## TLS

| Chart | Default |
|-------|---------|
| hotel | Reference `example-internal-wildcard-tls`; `certificate.create: false` |
| generic-web, n8n, erpnext | Create Certificate when `platform.tls.enabled` (same secret name) |

Do not duplicate a Certificate in a namespace that already mounts the platform wildcard.

## External Secrets

Remote refs only. Hotel has **no** ESO (none invented). erpnext/n8n/generic-web keep existing `platform.externalSecrets` keys.

erpnext `dbRootPassword` is `UNSET-REQUIRES-EXTERNAL-SECRET` so Helm still enables upstream `secretKeyRef`; the live value comes from ESO → release Secret.
