package metrics_state;

import 'package:equatable/equatable.dart';
import '../../../domain/entities/code_metric.dart';
import '../../../domain/entities/analysis_result.dart';

abstract class MetricsState extends Equatable {
  const MetricsState();

  @override
  List<Object?> get props => [];
}

class MetricsInitialState extends MetricsState {
  const MetricsInitialState();
}

class MetricsLoadingState extends MetricsState {
  final String? message;
  final double? progress;

  const MetricsLoadingState({
    this.message,
    this.progress,
  });

  @override
  List<Object?> get props => [message, progress];
}

class MetricsLoadedState extends MetricsState {
  final AnalysisResult analysisResult;
  final List<CodeMetric> filteredMetrics;
  final String? currentFilter;
  final Map<String, int> activeThresholds;
  final DateTime lastUpdated;

  const MetricsLoadedState({
    required this.analysisResult,
    required this.filteredMetrics,
    this.currentFilter,
    this.activeThresholds = const {},
    required this.lastUpdated,
  });

  int get totalErrors => analysisResult.totalErrors;
  int get totalWarnings => analysisResult.totalWarnings;
  int get totalCriticalIssues => analysisResult.totalCriticalIssues;
  bool get hasCriticalIssues => analysisResult.hasCriticalIssues;
  bool get hasMaintainabilityRisks => analysisResult.hasMaintainabilityRisks;
  double get maintainabilityIndex => analysisResult.maintainabilityIndex;
  double get technicalDebt => analysisResult.technicalDebt;

  List<CodeMetric> get errorMetrics =>
      analysisResult.metrics.where((m) => m.isError).toList();

  List<CodeMetric> get warningMetrics =>
      analysisResult.metrics.where((m) => m.isWarning).toList();

  List<CodeMetric> get criticalMetrics =>
      analysisResult.metrics.where((m) => m.isCritical).toList();

  List<CodeMetric> get exceededThresholdMetrics =>
      analysisResult.exceededThresholdMetrics;

  MetricsLoadedState copyWith({
    AnalysisResult? analysisResult,
    List<CodeMetric>? filteredMetrics,
    String? currentFilter,
    Map<String, int>? activeThresholds,
    DateTime? lastUpdated,
  }) {
    return MetricsLoadedState(
      analysisResult: analysisResult ?? this.analysisResult,
      filteredMetrics: filteredMetrics ?? this.filteredMetrics,
      currentFilter: currentFilter ?? this.currentFilter,
      activeThresholds: activeThresholds ?? this.activeThresholds,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [
        analysisResult,
        filteredMetrics,
        currentFilter,
        activeThresholds,
        lastUpdated,
      ];
}

class MetricsErrorState extends MetricsState {
  final String message;
  final String? stackTrace;
  final int? errorCode;

  const MetricsErrorState({
    required this.message,
    this.stackTrace,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, stackTrace, errorCode];
}

class MetricsExportingState extends MetricsState {
  final String format;
  final String outputPath;
  final double progress;

  const MetricsExportingState({
    required this.format,
    required this.outputPath,
    this.progress = 0.0,
  });

  @override
  List<Object?> get props => [format, outputPath, progress];
}

class MetricsExportedState extends MetricsState {
  final String outputPath;
  final String format;
  final int metricsCount;
  final DateTime exportedAt;

  const MetricsExportedState({
    required this.outputPath,
    required this.format,
    required this.metricsCount,
    required this.exportedAt,
  });

  @override
  List<Object?> get props => [outputPath, format, metricsCount, exportedAt];
}