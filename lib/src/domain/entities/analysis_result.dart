// Entidad que representa el resultado completo de un análisis de calidad de código.
// Agrupa métricas, issues y estadísticas generales del proyecto.

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'code_metric.dart';

part 'analysis_result.g.dart';

@JsonSerializable()
class AnalysisResult extends Equatable {
  final String projectName;
  final DateTime analysisDate;
  final List<CodeMetric> metrics;
  final List<String> antiPatternsFound;
  final int totalFilesAnalyzed;
  final int totalLinesOfCode;
  final double maintainabilityIndex;
  final double technicalDebt;

  const AnalysisResult({
    required this.projectName,
    required this.analysisDate,
    required this.metrics,
    required this.antiPatternsFound,
    required this.totalFilesAnalyzed,
    required this.totalLinesOfCode,
    required this.maintainabilityIndex,
    required this.technicalDebt,
  });

  factory AnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$AnalysisResultFromJson(json);

  Map<String, dynamic> toJson() => _$AnalysisResultToJson(this);

  @override
  List<Object?> get props => [
        projectName,
        analysisDate,
        metrics,
        antiPatternsFound,
        totalFilesAnalyzed,
        totalLinesOfCode,
        maintainabilityIndex,
        technicalDebt,
      ];

  AnalysisResult copyWith({
    String? projectName,
    DateTime? analysisDate,
    List<CodeMetric>? metrics,
    List<String>? antiPatternsFound,
    int? totalFilesAnalyzed,
    int? totalLinesOfCode,
    double? maintainabilityIndex,
    double? technicalDebt,
  }) {
    return AnalysisResult(
      projectName: projectName ?? this.projectName,
      analysisDate: analysisDate ?? this.analysisDate,
      metrics: metrics ?? this.metrics,
      antiPatternsFound: antiPatternsFound ?? this.antiPatternsFound,
      totalFilesAnalyzed: totalFilesAnalyzed ?? this.totalFilesAnalyzed,
      totalLinesOfCode: totalLinesOfCode ?? this.totalLinesOfCode,
      maintainabilityIndex: maintainabilityIndex ?? this.maintainabilityIndex,
      technicalDebt: technicalDebt ?? this.technicalDebt,
    );
  }

  int get totalErrors => metrics.where((m) => m.isError).length;
  int get totalWarnings => metrics.where((m) => m.isWarning).length;
  int get totalCriticalIssues => metrics.where((m) => m.isCritical).length;

  List<CodeMetric> get metricsExceedingThreshold =>
      metrics.where((m) => m.exceedsThreshold).toList();

  List<CodeMetric> get criticalMetrics =>
      metrics.where((m) => m.isCritical).toList();

  List<CodeMetric> get maintainabilityRisks =>
      metrics.where((m) => m.isMaintainabilityRisk).toList();

  Map<String, List<CodeMetric>> get metricsByFile {
    final map = <String, List<CodeMetric>>{};
    for (final metric in metrics) {
      map.putIfAbsent(metric.filePath, () => []);
      map[metric.filePath]!.add(metric);
    }
    return map;
  }

  Map<String, List<CodeMetric>> get metricsByType {
    final map = <String, List<CodeMetric>>{};
    for (final metric in metrics) {
      map.putIfAbsent(metric.metricName, () => []);
      map[metric.metricName]!.add(metric);
    }
    return map;
  }

  bool get hasCriticalIssues => totalCriticalIssues > 0;
  bool get hasMaintainabilityRisks => maintainabilityRisks.isNotEmpty;

  double get codeDuplicationPercentage {
    final dupMetrics = metrics
        .where((m) => m.metricName == 'code-duplication')
        .toList();
    if (dupMetrics.isEmpty) return 0.0;
    return dupMetrics.first.value.toDouble();
  }

  double get averageCyclomaticComplexity {
    final complexityMetrics = metrics
        .where((m) => m.metricName == 'cyclomatic-complexity')
        .toList();
    if (complexityMetrics.isEmpty) return 0.0;
    return complexityMetrics
            .map((m) => m.value)
            .reduce((a, b) => a + b) /
        complexityMetrics.length;
  }
}