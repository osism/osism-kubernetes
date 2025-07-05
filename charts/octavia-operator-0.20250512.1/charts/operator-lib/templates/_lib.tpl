{{- define "yaook.operator-lib.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "yaook.operator-lib.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 55 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 55 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 55 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "yaook.operator-lib.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "yaook.operator-lib.labels" -}}
helm.sh/chart: {{ include "yaook.operator-lib.chart" . }}
{{ include "yaook.operator-lib.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end -}}

{{- define "yaook.operator-lib.selectorLabels" -}}
app.kubernetes.io/name: {{ include "yaook.operator-lib.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "yaook.operator-lib.image" -}}
{{ .Values.operator.image.repository }}:{{ default .Chart.AppVersion .Values.operator.image.tag }}
{{- end -}}

{{- define "yaook.operator.extraEnv" -}}
{{- end -}}

{{- define "yaook.operator-lib.env" -}}
{{- range .Values.operator.extraEnv }}
- {{ . | toYaml | nindent 2 }}
{{- end }}
{{ include "yaook.operator.extraEnv" . }}
{{- end -}}

{{- define "yaook.operator-lib.applySchedulingKeys" -}}
affinity:
    nodeAffinity:
        requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            {{- range . }}
                - matchExpressions:
                    - key: {{ . }}
                      operator: Exists
            {{- end }}
tolerations:
    {{- range . }}
    - key: {{ . }}
      operator: Exists
    {{- end }}
{{- end -}}

{{- define "yaook.operator-lib.scheduling" -}}
{{- if .Values.operator.schedulingKeys }}
{{- include "yaook.operator-lib.applySchedulingKeys" .Values.operator.schedulingKeys }}
{{- else }}
{{- with .Values.operator.nodeSelector }}
nodeSelector:
{{- toYaml . | nindent 8 }}
{{- end }}
{{- with .Values.operator.affinity }}
affinity:
{{- toYaml . | nindent 8 }}
{{- end }}
{{- with .Values.operator.tolerations }}
tolerations:
{{- toYaml . | nindent 8 }}
{{- end }}
{{- end }}
{{- end -}}
