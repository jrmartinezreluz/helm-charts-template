{{/*
Grafana dashboard ConfigMap for the kube-prometheus-stack sidecar
(label grafana_dashboard=1, watched in all namespaces).
dict: ctx, name (optional), dashboard (optional)
dashboard.json must be a Grafana dashboard JSON string.
*/}}
{{- define "arkhadia-common.dashboard.manifest" -}}
{{- $ctx := .ctx }}
{{- $db := .dashboard | default $ctx.Values.dashboard }}
{{- if and $db $db.enabled $db.json }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .name | default (printf "%s-dashboard" (include "arkhadia-common.fullname" $ctx)) }}
  labels:
    {{- include "arkhadia-common.labels" $ctx | nindent 4 }}
    grafana_dashboard: "1"
  annotations:
    grafana_folder: {{ $db.folder | default "Platform" | quote }}
data:
  {{ printf "%s.json" (include "arkhadia-common.fullname" $ctx) }}: |-
{{ $db.json | indent 4 }}
{{- end }}
{{- end }}
