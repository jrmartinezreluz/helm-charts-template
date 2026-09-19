{{/*
PrometheusRule. dict: ctx, name (optional), prometheusRule (optional)
Emits nothing unless prometheusRule.enabled and groups are set.
Must carry release=kube-prometheus-stack for the platform Prometheus selector.
*/}}
{{- define "arkhadia-common.prometheusRule.manifest" -}}
{{- $ctx := .ctx }}
{{- $pr := .prometheusRule | default $ctx.Values.prometheusRule }}
{{- if and $pr $pr.enabled $pr.groups }}
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: {{ .name | default (printf "%s-alerts" (include "arkhadia-common.fullname" $ctx)) }}
  labels:
    {{- include "arkhadia-common.labels" $ctx | nindent 4 }}
    release: kube-prometheus-stack
    {{- with $pr.additionalLabels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  groups:
    {{- toYaml $pr.groups | nindent 4 }}
{{- end }}
{{- end }}
