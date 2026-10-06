package lib.src.presentation.blocs.metrics;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/code_metric.dart';
import '../../domain/entities/analysis_result.dart';
import '../../domain/repositories/metrics_repository.dart';

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

class FilterMetricsEvent extends MetricsEvent {
  final String? severityFilter;
  final String? metricTypeFilter;
  final bool showOnlyCritical;

  const FilterMetricsEvent({
    this.severityFilter,
    this.metricTypeFilter,
    this.showOnlyCritical = false,
  });

  @override
  List<Object?> get props => [severityFilter, metricTypeFilter, showOnlyCritical];
}

class RefreshMetricsEvent extends MetricsEvent {
  const RefreshMetricsEvent();
}

class ExportMetricsEvent extends MetricsEvent {
  final String format;

  const ExportMetricsEvent({this.format = 'json'});

  @override
  List<Object?> get props => [format];
}

abstract class MetricsState extends Equatable {
  const MetricsState();

  @override
  List<Object?> get props => [];
}

class MetricsInitial extends MetricsState {
  const MetricsInitial();
}

class MetricsLoading extends MetricsState {
  final String? message;

  const MetricsLoading({this.message});

  @override
  List<Object?> get props => [message];
}

class MetricsLoaded extends MetricsState {
  final AnalysisResult analysisResult;
  final List<CodeMetric> filteredMetrics;
  final String? activeSeverityFilter;
  final String? activeMetricTypeFilter;
  final bool showOnlyCritical;

  const MetricsLoaded({
    required this.analysisResult,
    required this.filteredMetrics,
    this.activeSeverityFilter,
    this.metricTypeFilter,
    this.showOnlyCritical = false,
  });

  String? get metricTypeFilter;

  @override
  List<Object?> get props => [
        analysisResult,
        filteredMetrics,
        activeSeverityFilter,
        metricTypeFilter,
        showOnlyCritical,
      ];

  MetricsLoaded copyWith({
    AnalysisResult? analysisResult,
    List<CodeMetric>? filteredMetrics,
    String? activeSeverityFilter,
    String? metricTypeFilter,
    bool? showOnlyCritical,
  }) {
    return MetricsLoaded(
      analysisResult: analysisResult ?? this.analysisResult,
      filteredMetrics: filteredMetrics ?? this.filteredMetrics,
      activeSeverityFilter: activeSeverityFilter ?? this.activeSeverityFilter,
      metricTypeFilter: metricTypeFilter ?? this.metricTypeFilter,
      showOnlyCritical: showOnlyCritical ?? this.showOnlyCritical,
    );
  }
}

class MetricsError extends MetricsState {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  const MetricsError({
    required this.message,
    this.statusCode,
    this.originalError,
  });

  @override
  List<Object?> get props => [message, statusCode, originalError];
}

class MetricsExporting extends MetricsState {
  const MetricsExporting();
}

class MetricsExported extends MetricsState {
  final String filePath;
  final String format;
  final int metricsCount;

  const MetricsExported({
    required this.filePath,
    required this.format,
    required this.metricsCount,
  });

  @override
  List<Object?> get props => [filePath, format, metricsCount];
}

class MetricsBloc extends Bloc<MetricsEvent, MetricsState> {
  final MetricsRepository _metricsRepository;
  String? _lastProjectPath;

  MetricsBloc(this._metricsRepository) : super(const MetricsInitial()) {
    on<LoadMetricsEvent>(_onLoadMetrics);
    on<FilterMetricsEvent>(_onFilterMetrics);
    on<RefreshMetricsEvent>(_onRefreshMetrics);
    on<ExportMetricsEvent>(_onExportMetrics);
  }

  Future<void> _onLoadMetrics(
    LoadMetricsEvent event,
    Emitter<MetricsState> emit,
  ) async {
    emit(const MetricsLoading(message: 'Cargando métricas de código...'));

    try {
      _lastProjectPath = event.projectPath;
      
      final AnalysisResult result = await _metricsRepository.getAnalysisResult(
        event.projectPath,
        forceRefresh: event.forceRefresh,
      );

      final List<CodeMetric> filteredMetrics = _applyFilters(
        result,
        null,
        null,
        false,
      );

      emit(MetricsLoaded(
        analysisResult: result,
        filteredMetrics: filteredMetrics,
      ));
    } on DioException catch (e) {
      emit(MetricsError(
        message: _mapDioErrorMessage(e),
        statusCode: e.response?.statusCode,
        originalError: e,
      ));
    } catch (e) {
      emit(MetricsError(
        message: 'Error al cargar métricas: ${e.toString()}',
        originalError: e,
      ));
    }
  }

  Future<void> _onFilterMetrics(
    FilterMetricsEvent event,
    Emitter<MetricsState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is! MetricsLoaded) {
      return;
    }

    final filteredMetrics = _applyFilters(
      currentState.analysisResult,
      event.severityFilter,
      event.metricTypeFilter,
      event.showOnlyCritical,
    );

    emit(currentState.copyWith(
      filteredMetrics: filteredMetrics,
      activeSeverityFilter: event.severityFilter,
      metricTypeFilter: event.metricTypeFilter,
      showOnlyCritical: event.showOnlyCritical,
    ));
  }

  Future<void> _onRefreshMetrics(
    RefreshMetricsEvent event,
    Emitter<MetricsState> emit,
  ) async {
    if (_lastProjectPath == null) {
      emit(const MetricsError(
        message: 'No hay proyecto cargado para actualizar',
      ));
      return;
    }

    add(LoadMetricsEvent(
      projectPath: _lastProjectPath!,
      forceRefresh: true,
    ));
  }

  Future<void> _onExportMetrics(
    ExportMetricsEvent event,
    Emitter<MetricsState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is! MetricsLoaded) {
      emit(const MetricsError(
        message: 'No hay métricas cargadas para exportar',
      ));
      return;
    }

    emit(const MetricsExporting());

    try {
      final filePath = await _metricsRepository.exportMetrics(
        currentState.analysisResult,
        format: event.format,
      );

      emit(MetricsExported(
        filePath: filePath,
        format: event.format,
        metricsCount: currentState.filteredMetrics.length,
      ));

      emit(currentState);
    } catch (e) {
      emit(MetricsError(
        message: 'Error al exportar métricas: ${e.toString()}',
        originalError: e,
      ));
    }
  }

  List<CodeMetric> _applyFilters(
    AnalysisResult result,
    String? severityFilter,
    String? metricTypeFilter,
    bool showOnlyCritical,
  ) {
    List<CodeMetric> filtered = result.metrics;

    if (showOnlyCritical) {
      filtered = filtered.where((m) => m.isCritical).toList();
    }

    if (severityFilter != null && severityFilter.isNotEmpty) {
      filtered = filtered
          .where((m) => m.severity.toLowerCase() == severityFilter.toLowerCase())
          .toList();
    }

    if (metricTypeFilter != null && metricTypeFilter.isNotEmpty) {
      filtered = filtered
          .where((m) => m.metricName.toLowerCase().contains(metricTypeFilter.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  String _mapDioErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Tiempo de conexión agotado. Verifica tu conexión a internet.';
      case DioExceptionType.sendTimeout:
        return 'Tiempo de envío agotado. Intenta con un proyecto más pequeño.';
      case DioExceptionType.receiveTimeout:
        return 'Tiempo de recepción agotado. El análisis está tomando demasiado tiempo.';
      case DioExceptionType.badResponse:
        return 'Respuesta inválida del servidor: ${e.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Solicitud cancelada por el usuario.';
      case DioExceptionType.connectionError:
        return 'Error de conexión. Verifica tu red.';
      default:
        return 'Error de red: ${e.message}';
    }
  }

  @override
  Future<void> close() {
    _lastProjectPath = null;
    return super.close();
  }
}