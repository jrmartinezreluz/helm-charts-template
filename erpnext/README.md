# ERPNext platform chart

Thin wrapper around the official [Frappe ERPNext Helm chart](https://helm.erpnext.com) (`7.0.159`, vendored in `charts/`).

Wrapper adds: Traefik Ingress, cert-manager Certificate, External Secrets, optional create-site Job, `arkhadia-common` labels.

**Delegated to upstream (do not duplicate):** gunicorn/nginx/socketio/worker HPA templates, Redis/MariaDB PDBs, Frappe ServiceAccount `{{ .Release.Name }}`, probes/resources on Frappe pods.

`erpnext.dbRootPassword` is `UNSET-REQUIRES-EXTERNAL-SECRET` — not a real password. ESO writes `db-root-password` on the release Secret.

```bash
helm dependency update erpnext/
helm template erpnext ./erpnext -f ../gitops-platform-template/clusters/nonprod/dev/erpnext.yaml
```

Chart version (`0.2.0`) is not `appVersion` (`15`).
