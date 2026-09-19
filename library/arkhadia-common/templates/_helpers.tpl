{{/*
Arkhadia common helpers. All defines are prefixed arkhadia-common.*
Context is the parent application chart (`.Chart` / `.Values` / `.Release`).
*/}}

{{- define "arkhadia-common.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "arkhadia-common.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "arkhadia-common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "arkhadia-common.partOf" -}}
{{- $app := .Values.application | default dict }}
{{- default (include "arkhadia-common.name" .) $app.name }}
{{- end }}

{{- define "arkhadia-common.selectorLabels" -}}
app.kubernetes.io/name: {{ include "arkhadia-common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "arkhadia-common.labels" -}}
helm.sh/chart: {{ include "arkhadia-common.chart" . }}
{{ include "arkhadia-common.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: {{ include "arkhadia-common.partOf" . | quote }}
{{- include "arkhadia-common.portfolioLabels" . }}
{{- end }}

{{- define "arkhadia-common.portfolioLabels" -}}
{{- $g := .Values.global | default dict }}
{{- $a := .Values.application | default dict }}
{{- with $g.environment }}
platform.example/environment: {{ . | quote }}
{{- end }}
{{- with $a.name }}
platform.example/solution: {{ . | quote }}
{{- end }}
{{- end }}

{{/*
Image reference. Prefers digest when set.
Usage: include "arkhadia-common.image" .Values.image
Image map: repository, tag, digest (optional).
*/}}
{{- define "arkhadia-common.image" -}}
{{- if .digest }}
{{- printf "%s@%s" .repository .digest }}
{{- else }}
{{- printf "%s:%s" .repository (.tag | default "latest") }}
{{- end }}
{{- end }}

{{- define "arkhadia-common.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "arkhadia-common.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "arkhadia-common.podSecurityContext" -}}
{{- with .Values.podSecurityContext }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{- define "arkhadia-common.containerSecurityContext" -}}
{{- with .Values.securityContext }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{/*
Optional topology spread. Usage under spec.template.spec:
  include "arkhadia-common.topologySpread" (dict "ctx" . "selectorLabels" (include "arkhadia-common.selectorLabels" .))
*/}}
{{- define "arkhadia-common.topologySpread" -}}
{{- $ctx := .ctx }}
{{- $ts := $ctx.Values.topologySpread | default dict }}
{{- if $ts.enabled }}
topologySpreadConstraints:
  - maxSkew: {{ $ts.maxSkew | default 1 }}
    topologyKey: {{ $ts.topologyKey | default "topology.kubernetes.io/zone" }}
    whenUnsatisfiable: {{ $ts.whenUnsatisfiable | default "ScheduleAnyway" }}
    labelSelector:
      matchLabels:
        {{- .selectorLabels | nindent 8 }}
{{- end }}
{{- end }}

{{- define "arkhadia-common.podAntiAffinity" -}}
{{- $ctx := .ctx }}
{{- $pa := $ctx.Values.podAntiAffinity | default dict }}
{{- if $pa.enabled }}
affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          topologyKey: {{ $pa.topologyKey | default "kubernetes.io/hostname" }}
          labelSelector:
            matchLabels:
              {{- .selectorLabels | nindent 14 }}
{{- end }}
{{- end }}
