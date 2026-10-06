#!/bin/bash

set -e

echo "========================================="
echo "Ejecutando análisis de métricas de código"
echo "========================================="

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT"

echo "Directorio del proyecto: $PROJECT_ROOT"
echo ""

if [ ! -f "pubspec.yaml" ]; then
    echo "ERROR: No se encontró pubspec.yaml en el directorio raíz"
    exit 1
fi

echo "Paso 1: Obteniendo dependencias..."./gradlew :app:dependencies --configuration releaseRuntimeClasspath 2>/dev/null || true
echo "Ejecutando flutter pub get..."
flutter pub get

echo ""
echo "Paso 2: Ejecutando análisis estático con flutter analyze..."
flutter analyze --no-fatal-infos --no-fatal-warnings
ANALYZE_EXIT=$?

echo ""
echo "Paso 3: Ejecutando análisis de métricas con dart_code_metrics..."
if command -v flutter &> /dev/null; then
    flutter pub run dart_code_metrics:metrics analyze lib \
        --reporter=console \
        --metrics-output-file=tools/code_metrics/output/metrics_report.json \
        --set-exit-on-violation-level=warning
    METRICS_EXIT=$?
else
    echo "WARN: Flutter no disponible, saltando análisis de métricas"
    METRICS_EXIT=0
fi

echo ""
echo "Paso 4: Verificando umbrales configurados..."
CONFIG_FILE="tools/code_metrics/config/metrics_thresholds.json"
if [ -f "$CONFIG_FILE" ]; then
    echo "Archivo de configuración encontrado: $CONFIG_FILE"
    
    if command -v python3 &> /dev/null; then
        python3 -c "
import json
import sys

with open('$CONFIG_FILE', 'r') as f:
    config = json.load(f)

thresholds = config.get('thresholds', {})
print(f'Umbrales cargados: {len(thresholds)} métricas configuradas')

for metric, value in thresholds.items():
    max_val = value.get('maxValue', 'N/A')
    severity = value.get('severity', 'info')
    print(f'  - {metric}: max={max_val}, severity={severity}')
"
    else
        echo "Python3 no disponible para validación de configuración"
    fi
else
    echo "WARN: Archivo de configuración de umbrales no encontrado"
fi

echo ""
echo "========================================="
echo "RESUMEN DEL ANÁLISIS"
echo "========================================="
echo "Estado de flutter analyze: $([ $ANALYZE_EXIT -eq 0 ] && echo 'OK' || echo 'FALLÓ')"
echo "Estado de métricas: $([ $METRICS_EXIT -eq 0 ] && echo 'OK' || echo 'FALLÓ')"
echo ""

if [ $ANALYZE_EXIT -ne 0 ] || [ $METRICS_EXIT -ne 0 ]; then
    echo "RESULTADO: El análisis encontró problemas que deben resolverse"
    exit 1
else
    echo "RESULTADO: Todas las validaciones pasaron exitosamente"
    exit 0
fi