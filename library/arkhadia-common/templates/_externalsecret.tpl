{{/*
ExternalSecret with dataFrom extract.
dict: ctx, name, targetName, remoteKey, template (optional yaml string)
*/}}
{{- define "arkhadia-common.externalSecret.extract" -}}
{{- $ctx := .ctx }}
{{- $eso := $ctx.Values.platform.externalSecrets }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .name }}
  labels:
    {{- include "arkhadia-common.labels" $ctx | nindent 4 }}
spec:
  refreshInterval: {{ $eso.refreshInterval | default "1h" }}
  secretStoreRef:
    name: {{ $eso.secretStoreRef.name }}
    kind: {{ $eso.secretStoreRef.kind }}
  target:
    name: {{ .targetName }}
    creationPolicy: Owner
    {{- with .template }}
    template:
      {{- toYaml . | nindent 6 }}
    {{- end }}
  dataFrom:
    - extract:
        key: {{ .remoteKey | quote }}
{{- end }}
