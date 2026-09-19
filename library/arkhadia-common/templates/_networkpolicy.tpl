{{/*
NetworkPolicy. dict: ctx, name (optional), selectorLabels (required string), networkPolicy (optional)
DNS egress to kube-system:53 is added when networkPolicy.dns is true (default).
allowAllEgress adds an empty egress rule (allow all). Default is false (10B). n8n sets true explicitly.
*/}}
{{- define "arkhadia-common.networkPolicy.manifest" -}}
{{- $ctx := .ctx }}
{{- $np := .networkPolicy | default $ctx.Values.networkPolicy }}
{{- if and $np $np.enabled }}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: {{ .name | default (include "arkhadia-common.fullname" $ctx) }}
  labels:
    {{- include "arkhadia-common.labels" $ctx | nindent 4 }}
spec:
  podSelector:
    matchLabels:
      {{- .selectorLabels | nindent 6 }}
  policyTypes:
    {{- toYaml ($np.policyTypes | default (list "Ingress" "Egress")) | nindent 4 }}
  {{- if $np.ingress }}
  ingress:
    {{- toYaml $np.ingress | nindent 4 }}
  {{- end }}
  egress:
    {{- if $np.dns | default true }}
    - to:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: kube-system
      ports:
        - protocol: UDP
          port: 53
        - protocol: TCP
          port: 53
    {{- end }}
    {{- if $np.allowAllEgress | default false }}
    - {}
    {{- end }}
    {{- with $np.egress }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
{{- end }}
{{- end }}
