import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'src/presentation/blocs/metrics/metrics_bloc.dart';
import 'src/presentation/screens/metrics_dashboard_screen.dart';
import 'src/domain/repositories/metrics_repository.dart';
import 'src/data/repositories/metrics_repository_impl.dart';
import 'src/data/datasources/code_metrics_datasource.dart';

final getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _setupDependencies();
  runApp(const CodeMetricsApp());
}

void _setupDependencies() {
  // Registro de dependencias con GetIt
  getIt.registerLazySingleton<CodeMetricsDataSource>(() => CodeMetricsDataSource());
  getIt.registerLazySingleton<MetricsRepository>(() => MetricsRepositoryImpl(getIt()));

  // Configuración inicial del BLoC
  getIt.registerFactory(() => MetricsBloc(getIt()));
}

class CodeMetricsApp extends StatelessWidget {
  const CodeMetricsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Quality Metrics Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => getIt<MetricsBloc>()..add(const LoadMetrics()),
        child: const MetricsDashboardScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Configuración global de análisis estático
enum AnalysisSeverity { error, warning, info }

class AnalysisConfiguration {
  static const Map<String, AnalysisSeverity> ruleSeverities = {
    'unused_local_variable': AnalysisSeverity.warning,
    'unused_import': AnalysisSeverity.error,
    'invalid_annotation_target': AnalysisSeverity.info,
    'avoid-unused-parameters': AnalysisSeverity.error,
    'avoid-nested-conditional-expressions': AnalysisSeverity.error,
    'binary-expression-operand-order': AnalysisSeverity.warning,
    'double-literal-format': AnalysisSeverity.warning,
    'no-boolean-literal-compare': AnalysisSeverity.warning,
    'prefer-conditional-expressions': AnalysisSeverity.warning,
    'avoid-global-state': AnalysisSeverity.error,
    'avoid-shadowing': AnalysisSeverity.warning,
    'avoid-dynamic': AnalysisSeverity.warning,
    'avoid-passing-async-when-sync-expected': AnalysisSeverity.error,
  };

  static const Map<String, int> metricThresholds = {
    'cyclomatic-complexity': 10,
    'maximum-nesting-level': 4,
    'number-of-parameters': 4,
    'source-lines-of-code': 50,
  };

  static bool isRuleEnabled(String ruleName) {
    return ruleSeverities.containsKey(ruleName);
  }

  static AnalysisSeverity getRuleSeverity(String ruleName) {
    return ruleSeverities[ruleName] ?? AnalysisSeverity.info;
  }

  static int getMetricThreshold(String metricName) {
    return metricThresholds[metricName] ?? 0;
  }
}
"