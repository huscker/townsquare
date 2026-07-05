{{/*
Return the fully qualified frontend name.
*/}}
{{- define "townsquare.frontend.fullname" -}}
{{- printf "%s-frontend" (include "common.names.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the runtime-config.js content generated from values.
*/}}
{{- define "townsquare.frontend.runtimeConfig" -}}
window.RUNTIME_CONFIG = {
  {{- if .Values.frontend.runtimeConfig.wsUrl }}
  wsUrl: {{ .Values.frontend.runtimeConfig.wsUrl | quote }}
  {{- end }}
};
{{- end -}}
