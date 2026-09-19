{{- define "n8n-platform.name" -}}
{{- include "arkhadia-common.name" . }}
{{- end }}

{{- define "n8n-platform.fullname" -}}
{{- include "arkhadia-common.fullname" . }}
{{- end }}

{{- define "n8n-platform.labels" -}}
{{- include "arkhadia-common.labels" . }}
{{- end }}

{{- define "n8n-platform.selectorLabels" -}}
{{- include "arkhadia-common.selectorLabels" . }}
{{- end }}

{{- define "n8n-platform.n8nSelectorLabels" -}}
{{ include "n8n-platform.selectorLabels" . }}
app.kubernetes.io/component: n8n
{{- end }}

{{- define "n8n-platform.postgresSelectorLabels" -}}
{{ include "n8n-platform.selectorLabels" . }}
app.kubernetes.io/component: postgres
{{- end }}

{{- define "n8n-platform.postgresHost" -}}
{{- if .Values.postgresql.enabled -}}
{{- default (printf "%s-postgres" (include "n8n-platform.fullname" .)) .Values.postgresql.serviceName -}}
{{- else -}}
{{- required "externalDatabase.host is required when postgresql.enabled is false" .Values.externalDatabase.host -}}
{{- end -}}
{{- end }}
