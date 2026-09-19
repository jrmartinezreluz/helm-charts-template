{{/*
HPA manifest for a Deployment.
dict: ctx, name, targetName, autoscaling (optional override)
*/}}
{{- define "arkhadia-common.hpa.manifest" -}}
{{- $ctx := .ctx }}
{{- $as := .autoscaling | default $ctx.Values.autoscaling }}
{{- if and $as $as.enabled }}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ .name | default (include "arkhadia-common.fullname" $ctx) }}
  labels:
    {{- include "arkhadia-common.labels" $ctx | nindent 4 }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ .targetName | default (include "arkhadia-common.fullname" $ctx) }}
  minReplicas: {{ $as.minReplicas }}
  maxReplicas: {{ $as.maxReplicas }}
  metrics:
    {{- if $as.targetCPUUtilizationPercentage }}
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: {{ $as.targetCPUUtilizationPercentage }}
    {{- end }}
    {{- if $as.targetMemoryUtilizationPercentage }}
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: {{ $as.targetMemoryUtilizationPercentage }}
    {{- end }}
{{- end }}
{{- end }}
