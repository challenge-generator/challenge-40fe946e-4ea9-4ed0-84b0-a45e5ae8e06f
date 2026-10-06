package flutter_code_metrics_app.src.data.repositories;

import 'package:flutter_code_metrics_app/src/domain/entities/code_metric.dart';
import 'package:flutter_code_metrics_app/src/domain/entities/analysis_result.dart';
import 'package:flutter_code_metrics_app/src/domain/repositories/metrics_repository.dart';
import 'package:flutter_code_metrics_app/src/data/datasources/code_metrics_datasource.dart';

/// Implementación concreta del repositorio de métricas de calidad.
/// Esta clase orquesta la obtención de datos desde el datasource y
/// transforma los resultados crudos en entidades del dominio con
/// la estructura adecuada para la capa de presentación.
///
/// El repositorio implementa caching básico para evitar análisis
/// repetidos en cortos intervalos de tiempo, mejorando el rendimiento
/// en entornos de desarrollo.
class MetricsRepositoryImpl implements MetricsRepository {
  final CodeMetricsDatasource _datasource;
  
  AnalysisResult? _lastAnalysis;
  DateTime? _lastAnalysisTime;
  static const _cacheDuration = Duration(minutes: 5);

  MetricsRepositoryImpl({
    required CodeMetricsDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<AnalysisResult> analyzeProject(
    String projectPath, {
    String? configPath,
  }) async {
    if (_isCacheValid()) {
      return _lastAnalysis!;
    }

    final rawResult = await _datasource.runAnalysis(
      projectPath,
      configPath: configPath,
    );

    final metrics = rawResult['metrics'] as List<dynamic>;
    final codeMetrics = metrics.map((m) {
      final metricMap = m as Map<String, dynamic>;
      return CodeMetric.fromJson(metricMap);
    }).toList();

    final antiPatterns = (rawResult['antiPatterns'] as List<dynamic>?)
            ?.cast<String>() ??
        [];

    final totalLoc = rawResult['totalLinesOfCode'] as int? ?? 0;
    final totalFiles = rawResult['totalFilesAnalyzed'] as int? ?? 0;
    final maintainability = rawResult['maintainabilityIndex'] as double? ?? 100.0;
    final techDebt = rawResult['technicalDebt'] as double? ?? 0.0;

    _lastAnalysis = AnalysisResult(
      projectName: rawResult['projectName'] as String? ?? 'Unknown',
      analysisDate: DateTime.now(),
      metrics: codeMetrics,
      antiPatternsFound: antiPatterns,
      totalFilesAnalyzed: totalFiles,
      totalLinesOfCode: totalLoc,
      maintainabilityIndex: maintainability,
      technicalDebt: techDebt,
    );

    _lastAnalysisTime = DateTime.now();
    return _lastAnalysis!;
  }

  @override
  Future<List<CodeMetric>> getMetricsBySeverity(String severity) async {
    if (_lastAnalysis == null) {
      throw StateError('Debe ejecutar analyzeProject primero');
    }

    return _lastAnalysis!.metrics.where((m) {
      switch (severity.toLowerCase()) {
        case 'error':
          return m.isError;
        case 'warning':
          return m.isWarning;
        case 'info':
          return !m.isError && !m.isWarning;
        default:
          return false;
      }
    }).toList();
  }

  @override
  Future<List<AnalysisResult>> getAnalysisHistory({int limit = 10}) async {
    final history = await _datasource.getStoredAnalyses(limit: limit);
    return history.map((item) {
      final data = item as Map<String, dynamic>;
      final metricsList = data['metrics'] as List<dynamic>? ?? [];
      final metrics = metricsList.map((m) => CodeMetric.fromJson(m as Map<String, dynamic>)).toList();
      final antiPatterns = (data['antiPatternsFound'] as List<dynamic>?)?.cast<String>() ?? [];
      
      return AnalysisResult(
        projectName: data['projectName'] as String? ?? 'Unknown',
        analysisDate: DateTime.parse(data['analysisDate'] as String),
        metrics: metrics,
        antiPatternsFound: antiPatterns,
        totalFilesAnalyzed: data['totalFilesAnalyzed'] as int? ?? 0,
        totalLinesOfCode: data['totalLinesOfCode'] as int? ?? 0,
        maintainabilityIndex: (data['maintainabilityIndex'] as num?)?.toDouble() ?? 100.0,
        technicalDebt: (data['technicalDebt'] as num?)?.toDouble() ?? 0.0,
      );
    }).toList();
  }

  @override
  Future<List<CodeMetric>> getMetricsForFile(String filePath) async {
    if (_lastAnalysis == null) {
      throw StateError('Debe ejecutar analyzeProject primero');
    }

    return _lastAnalysis!.metrics
        .where((m) => m.filePath.contains(filePath))
        .toList();
  }

  @override
  Future<bool> validateThresholds() async {
    if (_lastAnalysis == null) {
      throw StateError('Debe ejecutar analyzeProject primero');
    }

    final exceedingMetrics = _lastAnalysis!.metrics
        .where((m) => m.exceedsThreshold)
        .toList();

    return exceedingMetrics.isEmpty;
  }

  @override
  Future<double> calculateTechnicalDebt() async {
    if (_lastAnalysis == null) {
      throw StateError('Debe ejecutar analyzeProject primero');
    }

    final errorsCount = _lastAnalysis!.totalErrors;
    final warningsCount = _lastAnalysis!.totalWarnings;
    final criticalCount = _lastAnalysis!.totalCriticalIssues;

    const errorWeight = 2.0;
    const warningWeight = 1.0;
    const criticalWeight = 4.0;

    final totalDebt = (errorsCount * errorWeight) +
        (warningsCount * warningWeight) +
        (criticalCount * criticalWeight);

    return totalDebt;
  }

  @override
  Future<double> getMaintainabilityIndex() async {
    if (_lastAnalysis == null) {
      throw StateError('Debe ejecutar analyzeProject primero');
    }

    return _lastAnalysis!.maintainabilityIndex;
  }

  bool _isCacheValid() {
    if (_lastAnalysis == null || _lastAnalysisTime == null) {
      return false;
    }
    return DateTime.now().difference(_lastAnalysisTime!) < _cacheDuration;
  }
}