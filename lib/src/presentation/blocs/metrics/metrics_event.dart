package metrics_event;

import 'package:equatable/equatable.dart';

abstract class MetricsEvent extends Equatable {
  const MetricsEvent();

  @override
  List<Object?> get props => [];
}

class LoadMetricsEvent extends MetricsEvent {
  final String projectPath;
  final bool forceRefresh;

  const LoadMetricsEvent({
    required this.projectPath,
    this.forceRefresh = false,
  });

  @override
  List<Object?> get props => [projectPath, forceRefresh];
}

class RefreshMetricsEvent extends MetricsEvent {
  const RefreshMetricsEvent();
}

class FilterMetricsBySeverityEvent extends MetricsEvent {
  final String severity;

  const FilterMetricsBySeverityEvent({required this.severity});

  @override
  List<Object?> get props => [severity];
}

class FilterMetricsByFileEvent extends MetricsEvent {
  final String filePath;

  const FilterMetricsByFileEvent({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}

class AnalyzeProjectEvent extends MetricsEvent {
  final String projectPath;

  const AnalyzeProjectEvent({required this.projectPath});

  @override
  List<Object?> get props => [projectPath];
}

class ExportMetricsEvent extends MetricsEvent {
  final String outputPath;
  final String format;

  const ExportMetricsEvent({
    required this.outputPath,
    this.format = 'json',
  });

  @override
  List<Object?> get props => [outputPath, format];
}

class ClearMetricsEvent extends MetricsEvent {
  const ClearMetricsEvent();
}

class ApplyThresholdsEvent extends MetricsEvent {
  final Map<String, int> customThresholds;

  const ApplyThresholdsEvent({required this.customThresholds});

  @override
  List<Object?> get props => [customThresholds];
}

class ValidateRuleEvent extends MetricsEvent {
  final String ruleName;

  const ValidateRuleEvent({required this.ruleName});

  @override
  List<Object?> get props => [ruleName];
}

class ToggleRuleEvent extends MetricsEvent {
  final String ruleName;
  final bool isEnabled;

  const ToggleRuleEvent({
    required this.ruleName,
    required this.isEnabled,
  });

  @override
  List<Object?> get props => [ruleName, isEnabled];
}