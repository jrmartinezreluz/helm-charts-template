{{/*
Optional cert-manager Certificate for a shared wildcard secret.
dict uses chart context `.`
Emits only when platform.tls.enabled and platform.tls.certificate.create.
*/}}
{{- define "arkhadia-common.certificate.manifest" -}}
{{- $tls := .Values.platform.tls | default dict }}
{{- $cert := $tls.certificate | default dict }}
{{- if and $tls.enabled $cert.create }}
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: {{ $cert.name | default "example-internal-wildcard" }}
  labels:
    {{- include "arkhadia-common.labels" . | nindent 4 }}
spec:
  secretName: {{ $tls.secretName }}
  duration: {{ $cert.duration | default "2160h" }}
  renewBefore: {{ $cert.renewBefore | default "360h" }}
  privateKey:
    algorithm: ECDSA
    size: 256
  issuerRef:
    name: {{ $cert.issuerRef.name | default "example-internal-ca" }}
    kind: {{ $cert.issuerRef.kind | default "ClusterIssuer" }}
  dnsNames:
    {{- if $cert.dnsNames }}
    {{- toYaml $cert.dnsNames | nindent 4 }}
    {{- else }}
    - {{ .Values.platform.internalDomain }}
    - "*.{{ .Values.platform.internalDomain }}"
    {{- end }}
{{- end }}
{{- end }}
