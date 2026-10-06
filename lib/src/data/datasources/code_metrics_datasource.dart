package flutter_code_metrics_app.src.data.datasources;

import 'dart:convert';
import 'dart:io';

/// DataSource que interactúa con las herramientas de análisis de código.
/// Esta clase encapsula la comunicación con dart_code_metrics y otras
/// herramientas de análisis estático, transformando los resultados
/// crudos en estructuras de datos utilizables por la aplicación.
///
/// El datasource es responsable de:
/// - Ejecutar análisis de código mediante línea de comandos
/// - Parsear los resultados JSON retornados por las herramientas
/// - Almacenar resultados para consulta histórica
/// - Aplicar filtros y transformaciones necesarias
class CodeMetricsDatasource {
  static const String _metricsTool = 'dart-code-metrics';
  
  final String _toolsPath;

  CodeMetricsDatasource({
    String? toolsPath,
  }) : _toolsPath = toolsPath ?? 'tools/code_metrics';

  /// Ejecuta el análisis de código utilizando dart_code_metrics.
  /// Retorna un mapa con los resultados parseados del análisis.
  ///
  /// [projectPath] Ruta al proyecto Flutter a analizar.
  /// [configPath] Ruta opcional al archivo de configuración de umbrales.
  Future<Map<String, dynamic>> runAnalysis(
    String projectPath, {
    String? configPath,
  }) async {
    final args = <String>[
      'analyze',
      '--reporter=json',
      '--verbose',
    ];

    if (configPath != null) {
      args.addAll(['--config', configPath]);
    }

    final result = await _executeMetricsCommand(
      projectPath,
      args,
    );

    if (result.exitCode != 0) {
      throw MetricsAnalysisException(
        'El análisis de métricas falló con código: ${result.exitCode}',
        result.stderr,
      );
    }

    return _parseAnalysisOutput(result.stdout, projectPath);
  }

  /// Obtiene análisis almacenados previamente para consulta histórica.
  /// Los análisis se almacenan en el directorio de herramientas para
  /// permitir comparaciones de evolución de métricas.
  ///
  /// [limit] Número máximo de análisis a recuperar.
  Future<List<Map<String, dynamic>>> getStoredAnalyses({
    int limit = 10,
  }) async {
    final storageDir = Directory('$_toolsPath/history');
    
    if (!await storageDir.exists()) {
      return [];
    }

    final files = await storageDir
        .list()
        .where((entity) => entity is File && entity.path.endsWith('.json'))
        .cast<File>()
        .toList();

    files.sort((a, b) => b.path.compareTo(a.path));

    final limitedFiles = files.take(limit);
    final analyses = <Map<String, dynamic>>[];

    for (final file in limitedFiles) {
      try {
        final content = await file.readAsString();
        final data = jsonDecode(content) as Map<String, dynamic>;
        analyses.add(data);
      } catch (e) {
        continue;
      }
    }

    return analyses;
  }

  /// Guarda el resultado de un análisis para consulta futura.
  /// El archivo se naming con timestamp para facilitar la identificación.
  ///
  /// [analysis] Datos del análisis a almacenar.
  Future<void> storeAnalysis(Map<String, dynamic> analysis) async {
    final storageDir = Directory('$_toolsPath/history');
    
    if (!await storageDir.exists()) {
      await storageDir.create(recursive: true);
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('$_toolsPath/history/analysis_$timestamp.json');
    
    await file.writeAsString(jsonEncode(analysis));
  }

  /// Ejecuta el comando de dart_code_metrics y retorna el resultado.
  Future<ProcessResult> _executeMetricsCommand(
    String projectPath,
    List<String> args,
  ) async {
    return Process.run(
      _metricsTool,
      args,
      workingDirectory: projectPath,
      runInShell: true,
    );
  }

  /// Parsea la salida JSON del análisis y la transforma al formato
  /// interno de la aplicación.
  Map<String, dynamic> _parseAnalysisOutput(
    String stdout,
    String projectPath,
  ) {
    try {
      final jsonOutput = jsonDecode(stdout) as Map<String, dynamic>;
      return _transformToInternalFormat(jsonOutput, projectPath);
    } catch (e) {
      throw MetricsAnalysisException(
        'Error al parsear resultados del análisis',
        e.toString(),
      );
    }
  }

  /// Transforma el formato de salida de dart_code_metrics al formato
  /// interno esperado por la aplicación.
  Map<String, dynamic> _transformToInternalFormat(
    Map<String, dynamic> externalFormat,
    String projectPath,
  ) {
    final metrics = <Map<String, dynamic>>[];
    final antiPatterns = <String>[];

    final components = externalFormat['components'] as Map<String, dynamic>?;
    if (components != null) {
      for (final entry in components.entries) {
        final component = entry.value as Map<String, dynamic>;
        final componentMetrics = component['metrics'] as Map<String, dynamic>?;
        
        if (componentMetrics != null) {
          for (final metricEntry in componentMetrics.entries) {
            final metricData = metricEntry.value as Map<String, dynamic>;
            metrics.add({
              'metricName': metricEntry.key,
              'filePath': entry.key,
              'value': metricData['value'] ?? 0,
              'threshold': metricData['threshold'] ?? 0,
              'severity': metricData['severity'] ?? 'info',
              'description': metricData['description'] ?? '',
              'isCritical': (metricData['severity'] ?? 'info') == 'error',
            });
          }
        }

        final issues = component['issues'] as List<dynamic>?;
        if (issues != null) {
          for (final issue in issues) {
            final issueMap = issue as Map<String, dynamic>;
            if (issueMap['type'] == 'antiPattern') {
              antiPatterns.add(issueMap['message'] as String? ?? '');
            }
          }
        }
      }
    }

    final summary = externalFormat['summary'] as Map<String, dynamic>?;
    final totalFiles = summary?['files'] as int? ?? 0;
    final totalLoc = summary?['lines'] as int? ?? 0;
    final maintainability = (summary?['maintainability'] as num?)?.toDouble() ?? 100.0;

    return {
      'projectName': projectPath.split('/').last,
      'metrics': metrics,
      'antiPatterns': antiPatterns,
      'totalFilesAnalyzed': totalFiles,
      'totalLinesOfCode': totalLoc,
      'maintainabilityIndex': maintainability,
      'technicalDebt': _calculateDebtFromMetrics(metrics),
    };
  }

  double _calculateDebtFromMetrics(List<Map<String, dynamic>> metrics) {
    double debt = 0.0;
    
    for (final metric in metrics) {
      final value = metric['value'] as int? ?? 0;
      final threshold = metric['threshold'] as int? ?? 0;
      final severity = metric['severity'] as String? ?? 'info';

      if (value > threshold) {
        final excess = value - threshold;
        final severityMultiplier = severity == 'error' ? 2.0 : 1.0;
        debt += excess * severityMultiplier;
      }
    }

    return debt;
  }
}

/// Excepción específica para errores en el análisis de métricas.
/// Proporciona información detallada sobre el fallo para facilitar
/// el debugging y la solución de problemas.
class MetricsAnalysisException implements Exception {
  final String message;
  final String? details;

  MetricsAnalysisException(this.message, [this.details]);

  @override
  String toString() {
    if (details != null && details!.isNotEmpty) {
      return 'MetricsAnalysisException: $message\nDetalles: $details';
    }
    return 'MetricsAnalysisException: $message';
  }
}