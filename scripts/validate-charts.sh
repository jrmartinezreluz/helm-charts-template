#!/usr/bin/env bash
# Local/static Helm validation for Phase 05. Does not install or talk to a cluster.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GITOPS="${GITOPS:-$ROOT/../gitops-platform-template}"
cd "$ROOT"

for c in generic-web hotel n8n erpnext; do
  helm dependency build "$c" >/dev/null
done

helm lint generic-web
helm template generic-web "$ROOT/generic-web" >/dev/null
echo "OK generic-web defaults"

for role in nonprod prod; do
  for envdir in "$GITOPS/clusters/$role"/*; do
    env="$(basename "$envdir")"
    for app in hotel erpnext n8n; do
      helm lint "$app" -f "$envdir/$app.yaml"
      helm template "$app" "$ROOT/$app" -f "$envdir/$app.yaml" >/dev/null
      echo "OK $app $role/$env"
    done
  done
done

echo "12/12 GitOps overlays + generic-web defaults rendered"
