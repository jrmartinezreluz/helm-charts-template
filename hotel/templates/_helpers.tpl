{{- define "hotel.name" -}}
{{- include "arkhadia-common.name" . }}
{{- end }}

{{- define "hotel.fullname" -}}
{{- include "arkhadia-common.fullname" . }}
{{- end }}

{{- define "hotel.labels" -}}
{{- include "arkhadia-common.labels" . }}
{{- end }}

{{- define "hotel.backendSelectorLabels" -}}
{{ include "arkhadia-common.selectorLabels" . }}
app.kubernetes.io/component: backend
{{- end }}

{{- define "hotel.frontendSelectorLabels" -}}
{{ include "arkhadia-common.selectorLabels" . }}
app.kubernetes.io/component: frontend
{{- end }}

{{- define "hotel.rolloutEnabled" -}}
{{- $ro := .Values.rollout | default dict -}}
{{- if $ro.enabled }}true{{- else }}{{- end -}}
{{- end }}

{{- define "hotel.activeSlot" -}}
{{- required "blueGreen.activeSlot is required (blue or green) when rollout.enabled=false" .Values.blueGreen.activeSlot -}}
{{- end }}

{{- define "hotel.previewSlot" -}}
{{- if eq (include "hotel.activeSlot" .) "blue" -}}green{{- else -}}blue{{- end -}}
{{- end }}

{{- define "hotel.frontendFullname" -}}
{{- printf "%s-frontend-%s" (include "hotel.fullname" .) .slot -}}
{{- end }}
