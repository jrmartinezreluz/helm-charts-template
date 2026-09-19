{{/*
PDB manifest.
dict: ctx, name (optional), selectorLabels (string from include), pdb (optional values override)
Does not emit a resource when enabled is false.
minAvailable and maxUnavailable are mutually exclusive; minAvailable wins if both set.
*/}}
{{- define "arkhadia-common.pdb.manifest" -}}
{{- $ctx := .ctx }}
{{- $pdb := .pdb | default $ctx.Values.podDisruptionBudget }}
{{- if and $pdb $pdb.enabled }}
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ .name | default (include "arkhadia-common.fullname" $ctx) }}
  labels:
    {{- include "arkhadia-common.labels" $ctx | nindent 4 }}
spec:
  {{- if $pdb.maxUnavailable }}
  maxUnavailable: {{ $pdb.maxUnavailable }}
  {{- else }}
  minAvailable: {{ $pdb.minAvailable | default 1 }}
  {{- end }}
  selector:
    matchLabels:
      {{- .selectorLabels | nindent 6 }}
{{- end }}
{{- end }}
