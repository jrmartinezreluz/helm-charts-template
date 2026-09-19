{{/*
ServiceMonitor for application metrics.
dict: ctx, name (optional), selectorLabels (string), serviceMonitor (optional), metrics (optional)
Emits nothing unless serviceMonitor.enabled.
Prometheus in this platform selects ServiceMonitors with label release=kube-prometheus-stack.
*/}}
{{- define "arkhadia-common.serviceMonitor.manifest" -}}
{{- $ctx := .ctx }}
{{- $sm := .serviceMonitor | default $ctx.Values.serviceMonitor }}
{{- $metrics := .metrics | default $ctx.Values.metrics }}
{{- if and $sm $sm.enabled $metrics $metrics.enabled }}
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: {{ .name | default (include "arkhadia-common.fullname" $ctx) }}
  labels:
    {{- include "arkhadia-common.labels" $ctx | nindent 4 }}
    release: kube-prometheus-stack
    {{- with $sm.additionalLabels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  selector:
    matchLabels:
      {{- .selectorLabels | nindent 6 }}
  endpoints:
    - port: {{ $metrics.portName | default "http-metrics" }}
      path: {{ $metrics.path | default "/metrics" }}
      interval: {{ $sm.interval | default "30s" }}
      scrapeTimeout: {{ $sm.scrapeTimeout | default "10s" }}
      scheme: http
{{- end }}
{{- end }}
