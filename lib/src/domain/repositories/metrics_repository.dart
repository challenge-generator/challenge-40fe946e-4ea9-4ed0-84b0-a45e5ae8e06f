package flutter_code_metrics_app.src.domain.repositories;

import 'package:flutter_code_metrics_app/src/domain/entities/code_metric.dart';
import 'package:flutter_code_metrics_app/src/domain/entities/analysis_result.dart';

/// Repositorio abstracto que define el contrato para acceder a las métricas
/// de calidad del código. Esta interfaz sigue el patrón de dominio limpio,
/// permitiendo que la capa de aplicación dependa de abstracciones en lugar
/// de implementaciones concretas.
///
/// La implementación de este repositorio es inyectada en tiempo de ejecución
/// mediante el contenedor de dependencias, lo que facilita las pruebas unitarias
/// y el intercambio de fuentes de datos.
abstract class MetricsRepository {
  /// Ejecuta un análisis completo de métricas de código en el proyecto.
  /// Retorna un objeto AnalysisResult con todas las métricas recopiladas,
  /// incluyendo complejidad ciclomática, anidamiento, líneas de código,
  /// y detección de anti-patterns.
  ///
  /// [projectPath] Ruta absoluta al proyecto Flutter que será analizado.
  /// [configPath] Ruta al archivo de configuración de umbrales (opcional).
  Future<AnalysisResult> analyzeProject(
    String projectPath, {
    String? configPath,
  });

  /// Obtiene una lista de métricas específicas filtradas por severidad.
  /// Útil para generar reportes diferenciados para errores, advertencias
  /// e información.
  ///
  /// [severity] Nivel de severidad a filtrar: 'error', 'warning', 'info'.
  Future<List<CodeMetric>> getMetricsBySeverity(String severity);

  /// Recupera el historial de análisis realizados. Permite consultar
  /// análisis anteriores para comparar la evolución de las métricas
  /// a lo largo del tiempo.
  ///
  /// [limit] Número máximo de resultados a retornar.
  Future<List<AnalysisResult>> getAnalysisHistory({int limit = 10});

  /// Obtiene métricas de un archivo específico. Útil para analizar
  /// el impacto de cambios particulares en archivos individuales.
  ///
  /// [filePath] Ruta al archivo a analizar.
  Future<List<CodeMetric>> getMetricsForFile(String filePath);

  /// Valida si el código actual cumple con los umbrales configurados.
  /// Retorna true si todas las métricas están dentro de los límites
  /// establecidos, false en caso contrario.
  Future<bool> validateThresholds();

  /// Genera un reporte de deuda técnica estimada en horas.
  /// Calcula el tiempo necesario para abordar todos los issues
  /// encontrados, basándose en heurísticas de la industria.
  Future<double> calculateTechnicalDebt();

  /// Obtiene métricas agregadas de mantenibilidad del proyecto.
  /// El índice de mantenibilidad es un valor entre 0 y 100 que
  /// indica la facilidad de mantener el código.
  Future<double> getMaintainabilityIndex();
}