// Entidad que representa una métrica de código con sus valores y umbrales.
// Incluye validaciones para métricas de complejidad, anidamiento y duplicación.

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'code_metric.g.dart';

@JsonSerializable()
class CodeMetric extends Equatable {
  final String metricName;
  final String filePath;
  final int value;
  final int threshold;
  final String severity;
  final String? description;
  final bool isCritical;

  const CodeMetric({
    required this.metricName,
    required this.filePath,
    required this.value,
    required this.threshold,
    required this.severity,
    this.description,
    this.isCritical = false,
  });

  factory CodeMetric.fromJson(Map<String, dynamic> json) =>
      _$CodeMetricFromJson(json);

  Map<String, dynamic> toJson() => _$CodeMetricToJson(this);

  bool get isWarning => severity == 'warning';
  bool get isError => severity == 'error';
  bool get exceedsThreshold => value > threshold;

  String get status {
    if (value <= threshold) return 'within threshold';
    if (isError) return 'error';
    return 'warning';
  }

  @override
  List<Object?> get props => [
        metricName,
        filePath,
        value,
        threshold,
        severity,
        description,
        isCritical,
      ];

  CodeMetric copyWith({
    String? metricName,
    String? filePath,
    int? value,
    int? threshold,
    String? severity,
    String? description,
    bool? isCritical,
  }) {
    return CodeMetric(
      metricName: metricName ?? this.metricName,
      filePath: filePath ?? this.filePath,
      value: value ?? this.value,
      threshold: threshold ?? this.threshold,
      severity: severity ?? this.severity,
      description: description ?? this.description,
      isCritical: isCritical ?? this.isCritical,
    );
  }

  static const knownMetrics = {
    'cyclomatic-complexity': 'Complejidad ciclomática',
    'maximum-nesting-level': 'Nivel máximo de anidamiento',
    'number-of-parameters': 'Número de parámetros',
    'source-lines-of-code': 'Líneas de código fuente',
    'code-duplication': 'Porcentaje de código duplicado',
  };

  String get displayName {
    return knownMetrics[metricName] ?? metricName;
  }

  double get percentageOfThreshold {
    if (threshold == 0) return 0.0;
    return (value / threshold) * 100;
  }

  bool get isMaintainabilityRisk {
    return metricName == 'cyclomatic-complexity' && value > threshold * 1.5 ||
        metricName == 'maximum-nesting-level' && value > threshold * 1.2 ||
        metricName == 'code-duplication' && value > 3;
  }
}