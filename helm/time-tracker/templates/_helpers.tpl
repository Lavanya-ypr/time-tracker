{{- define "time-tracker.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "time-tracker.fullname" -}}
{{ include "time-tracker.name" . }}-{{ .Release.Name }}
{{- end }}
