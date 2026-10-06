# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Archivos que la arquitectura del reto declara y no estan

Creálos con implementacion real, en la capa que les corresponde:

- `lib/src/presentation/screens/metrics_dashboard_screen.dart`
- `lib/src/presentation/screens/metrics_detail_screen.dart`
- `docs/HERRAMIENTAS_APLICADAS_FASE2.md`
- `docs/VALIDACIONES_IMPLEMENTADAS_FASE3.md`

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `lib/src/presentation/blocs/metrics/metrics_bloc.dart` — `MetricsRepository.getAnalysisResult`: Se invoca `getAnalysisResult` sobre `MetricsRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `lib/src/presentation/blocs/metrics/metrics_bloc.dart` — `MetricsRepository.exportMetrics`: Se invoca `exportMetrics` sobre `MetricsRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
flutter pub get && flutter analyze
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Advanced

### Brecha de conocimiento
Realizar código pensando en mejorar las métricas de: Complejidad ciclomática, complejidad de anidamiento, Código duplicado, Issues del lenguaje y es capaz de orientar al resto del equipo. Sugiere herramientas que ayuden a escribir mejor código. Realiza implementación de herramientas que validen el código dentro de los proyectos

### Misión / candidato
Desarrollador Senior en equipo mobile con experiencia en Flutter

### Reto
- Tema: Métricas de calidad de código
- Seniority: advanced-l2
- Tipo: practical
- Título: Implementación y validación de métricas de calidad en código Flutter
- Tiempo estimado: 20 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Evaluación inicial de métricas de calidad — objetivo: Identificar y evaluar las métricas de calidad actuales del código en un proyecto Flutter. — entregable (NO resolver): Documento con el análisis de las métricas de calidad actuales y propuestas de mejora.
- Fase 2: Sugerencia y aplicación de herramientas de calidad de código — objetivo: Sugerir y aplicar herramientas que ayuden a mejorar la calidad del código en proyectos Flutter. — entregable (NO resolver): Documento con la sugerencia y aplicación de herramientas de calidad de código, incluyendo resultados y mejoras obtenidas.
- Fase 3: Implementación de validaciones de código — objetivo: Implementar validaciones de código que aseguren la mejora continua de las métricas de calidad en proyectos Flutter. — entregable (NO resolver): Implementación de validaciones de código y documento de diseño y resultados.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: pubspec.yaml ===
name: flutter_code_metrics_app
description: A Flutter project focused on code quality metrics implementation and validation.
version: 1.0.0+1

environment:
  sdk: ">=3.6.0 <4.0.0"
  flutter: ">=3.27.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.6
  equatable: ^2.0.7
  dio: ^5.7.0
  get_it: ^8.0.3
  json_annotation: ^4.9.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.7
  mocktail: ^1.0.4
  flutter_lints: ^5.0.0
  dart_code_metrics: ^5.7.6
  very_good_analysis: ^5.2.0

flutter:
  uses-material-design: true
  assets:
    - tools/code_metrics/config/metrics_thresholds.json

# Configuración de análisis estático y métricas de código
analyzer:
  plugins:
    - dart_code_metrics
  errors:
    unused_local_variable: warning
    unused_import: error
    invalid_annotation_target: ignore
  exclude:
    - "**.g.dart"
    - "**.freezed.dart"
    - "test/**"

# Umbrales de métricas de código
dart_code_metrics:
  anti-patterns:
    - long-method
    - long-parameter-list
  metrics:
    cyclomatic-complexity: 10
    maximum-nesting-level: 4
    number-of-parameters: 4
    source-lines-of-code: 50
  metrics-exclude:
    - "test/**"
  rules:
    - avoid-unused-parameters:
        severity: error
    - avoid-nested-conditional-expressions:
        severity: error
    - avoid-missing-enum-constant-in-map:
        severity: error
    - binary-expression-operand-order:
        severity: warning
    - double-literal-format:
        severity: warning
    - no-boolean-literal-compare:
        severity: warning
    - no-empty-block:
        severity: warning
    - prefer-conditional-expressions:
        severity: warning
    - prefer-intl-name:
        severity: warning
    - prefer-match-file-name:
        severity: warning
    - avoid-global-state:
        severity: error
    - avoid-shadowing:
        severity: warning
    - avoid-unnecessary-type-casts:
        severity: warning
    - avoid-unnecessary-type-assertions:
        severity: warning
    - avoid-unrelated-type-assertions:
        severity: error
    - avoid-unused-generics:
        severity: error
    - avoid-dynamic:
        severity: warning
    - avoid-passing-async-when-sync-expected:
        severity: error
    - avoid-redundant-async:
        severity: warning
    - avoid-unnecessary-setstate:
        severity: warning
    - avoid-late-keyword:
        severity: warning
    - prefer-first:
        severity: warning
    - prefer-last:
        severity: warning
    - prefer-correct-edge-insets-constructor:
        severity: warning
    - prefer-single-widget-per-file:
        severity: warning
    - prefer-extracting-callbacks:
        severity: warning
    - avoid-duplicate-exports:
        severity: error
    - avoid-returning-widgets:
        severity: warning
    - prefer-text-rich:
        severity: warning
    - prefer-const-border-radius:
        severity: warning
    - prefer-correct-type-name:
        severity: warning
    - prefer-correct-test-file-name:
        severity: warning

// === ARCHIVO: lib/main.dart ===
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

// === ARCHIVO: lib/src/core/linting/app_lints.dart ===
// Conjunto personalizado de reglas de linting para el proyecto Flutter
// basado en flutter_lints, very_good_analysis y dart_code_metrics.
// Define reglas adicionales y ajusta severidades para CI/CD.

import 'package:flutter_lints/flutter_lints.dart' as flutter_lints;
import 'package:very_good_analysis/very_good_analysis.dart' as very_good;

final List<String> _excludedPatterns = [
  r'.g.dart$',
  r'.freezed.dart$',
  r'test/.+',
];

const _customRules = {
  // Reglas adicionales de very_good_analysis
  'always_put_control_body_on_new_line': true,
  'avoid_bool_literals_in_conditional_expressions': true,
  'avoid_catches_without_on_clauses': true,
  'avoid_catching_errors': true,
  'avoid_double_and_int_checks': true,
  'avoid_equals_and_hash_code_on_mutable_classes': true,
  'avoid_escaping_inner_quotes': true,
  'avoid_field_initializers_in_const_classes': true,
  'avoid_final_parameters': true,
  'avoid_implementing_value_types': true,
  'avoid_js_rounded_ints': true,
  'avoid_multiple_declarations_per_line': true,
  'avoid_positional_boolean_parameters': true,
  'avoid_private_typedef_functions': true,
  'avoid_redundant_argument_values': true,
  'avoid_returning_this': true,
  'avoid_setters_without_getters': true,
  'avoid_types_on_closure_parameters': true,
  'avoid_unused_constructor_parameters': true,
  'avoid_void_async': true,
  'cascade_invocations': true,
  'cast_nullable_to_non_nullable': true,
  'conditional_uri_does_not_exist': true,
  'deprecated_consistency': true,
  'do_not_use_environment': true,
  'eol_at_end_of_file': true,
  'join_return_with_assignment': true,
  'leading_newlines_in_multiline_strings': true,
  'missing_whitespace_between_adjacent_strings': true,
  'no_default_cases': true,
  'no_literal_bool_comparisons': true,
  'no_runtimeType_toString': true,
  'noop_primitive_operations': true,
  'omit_local_variable_types': true,
  'only_throw_errors': true,
  'parameter_assignments': true,
  'prefer_asserts_in_initializer_lists': true,
  'prefer_asserts_with_message': true,
  'prefer_constructors_over_static_methods': true,
  'prefer_final_in_for_each': true,
  'prefer_final_locals': true,
  'prefer_if_elements_to_conditional_expressions': true,
  'prefer_int_literals': true,
  'prefer_mixin': true,
  'prefer_null_aware_method_calls': true,
  'prefer_null_aware_operators': true,
  'prefer_relative_imports': true,
  'prefer_single_quotes': true,
  'prefer_spread_collections': true,
  'sort_child_properties_last': true,
  'sort_constructors_first': true,
  'sort_unnamed_constructors_first': true,
  'test_types_in_equals': true,
  'throw_in_finally': true,
  'tighten_type_of_initializing_formals': true,
  'type_annotate_public_apis': true,
  'unawaited_futures': true,
  'unnecessary_await_in_return': true,
  'unnecessary_lambdas': true,
  'unnecessary_null_aware_assignments': true,
  'unnecessary_null_aware_operator_on_extension_on_nullable': true,
  'unnecessary_null_checks': true,
  'unnecessary_nullable_for_final_variable_declarations': true,
  'unnecessary_overrides': true,
  'unnecessary_parenthesis': true,
  'unnecessary_raw_strings': true,
  'unnecessary_statements': true,
  'unnecessary_to_list_in_spreads': true,
  'use_colored_box': true,
  'use_decorated_box': true,
  'use_if_null_to_convert_nulls_to_bools': true,
  'use_is_even_rather_than_modulo': true,
  'use_named_constants': true,
  'use_raw_strings': true,
  'use_setters_to_change_properties': true,
  'use_string_buffers': true,
  'use_string_in_part_of_directives': true,
  'use_test_throws_matchers': true,
  'use_to_and_as_if_applicable': true,

  // Reglas específicas de dart_code_metrics
  'avoid-unused-parameters': 'error',
  'avoid-nested-conditional-expressions': 'error',
  'avoid-missing-enum-constant-in-map': 'error',
  'binary-expression-operand-order': 'warning',
  'double-literal-format': 'warning',
  'no-boolean-literal-compare': 'warning',
  'no-empty-block': 'warning',
  'prefer-conditional-expressions': 'warning',
  'prefer-intl-name': 'warning',
  'prefer-match-file-name': 'warning',
  'avoid-global-state': 'error',
  'avoid-shadowing': 'warning',
  'avoid-unnecessary-type-casts': 'warning',
  'avoid-unnecessary-type-assertions': 'warning',
  'avoid-unrelated-type-assertions': 'error',
  'avoid-unused-generics': 'error',
  'avoid-dynamic': 'warning',
  'avoid-passing-async-when-sync-expected': 'error',
  'avoid-redundant-async': 'warning',
  'avoid-unnecessary-setstate': 'warning',
  'avoid-late-keyword': 'warning',
  'prefer-first': 'warning',
  'prefer-last': 'warning',
  'prefer-correct-edge-insets-constructor': 'warning',
  'prefer-single-widget-per-file': 'warning',
  'prefer-extracting-callbacks': 'warning',
  'avoid-duplicate-exports': 'error',
  'avoid-returning-widgets': 'warning',
  'prefer-text-rich': 'warning',
  'prefer-const-border-radius': 'warning',
  'prefer-correct-type-name': 'warning',
  'prefer-correct-test-file-name': 'warning',
};

Map<String, Object> _createAnalysisOptions() {
  return {
    'analyzer': {
      'errors': {
        'unused_local_variable': 'warning',
        'unused_import': 'error',
        'invalid_annotation_target': 'ignore',
      },
      'exclude': _excludedPatterns,
      'plugins': ['dart_code_metrics'],
    },
    'linter': {
      'rules': [
        ...flutter_lints.recommended.map((r) => r.toString()),
        ...very_good.recommended.map((r) => r.toString()),
        for (final rule in _customRules.entries)
          if (rule.value is bool && rule.value as bool)
            rule.key,
          if (rule.value is String)
            {'$rule.key': {'severity': rule.value}},
      ],
    },
    'dart_code_metrics': {
      'anti-patterns': [
        {'long-method': null},
        {'long-parameter-list': null},
      ],
      'metrics': {
        'cyclomatic-complexity': 10,
        'maximum-nesting-level': 4,
        'number-of-parameters': 4,
        'source-lines-of-code': 50,
      },
      'metrics-exclude': _excludedPatterns,
      'rules': [
        for (final rule in _customRules.entries)
          if (rule.value is String && rule.key.startsWith('avoid-') || rule.key.startsWith('prefer-'))
            {'$rule.key': {'severity': rule.value}},
      ],
    },
  };
}

final Map<String, Object> appLints = _createAnalysisOptions();

// === ARCHIVO: lib/src/domain/entities/code_metric.dart ===
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

// === ARCHIVO: lib/src/domain/entities/analysis_result.dart ===
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

// === ARCHIVO: lib/src/domain/repositories/metrics_repository.dart ===
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

// === ARCHIVO: lib/src/data/repositories/metrics_repository_impl.dart ===
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

// === ARCHIVO: lib/src/data/datasources/code_metrics_datasource.dart ===
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

// === ARCHIVO: lib/src/presentation/blocs/metrics/metrics_bloc.dart ===
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

// === ARCHIVO: lib/src/presentation/blocs/metrics/metrics_event.dart ===
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

// === ARCHIVO: lib/src/presentation/blocs/metrics/metrics_state.dart ===
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

// === ARCHIVO: android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>

    <application
        android:label="flutter_code_metrics_app"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:usesCleartextTraffic="true">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>

// === ARCHIVO: analysis_options.yaml ===
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - '**.g.dart'
    - '**.freezed.dart'
    - 'test/**'
    - 'build/**'
    - '**.generated.dart'
    - 'android/**'
    - 'ios/**'
    - 'web/**'
    - 'linux/**'
    - 'macos/**'
    - 'windows/**'

  errors:
    invalid_annotation_target: ignore
    missing_required_param: error
    missing_return: error
    todo: ignore
    unused_local_variable: warning
    unused_import: error
    unused_element: warning
    unused_field: warning
    unused_method: warning
    dead_code: warning
    missing_override: error
    must_be_immutable: error
    must_call_super: error
    invalid_use_of_protected_member: error
    avoid_print: warning
    avoid_web_libraries_in_flutter: error
    prefer_const_constructors: error
    prefer_const_constructors_in_immutables: error
    prefer_const_literals_to_create_immutables: error
    prefer_final_fields: error
    prefer_final_locals: error
    avoid_function_literals_in_foreach_calls: warning
    prefer_if_null_operators: error
    prefer_is_empty: error
    prefer_is_not_empty: error
    avoid_returning_null_for_future: error
    avoid_null_checks_in_equality_operators: error
    avoid_returning_this: warning
    avoid_types_on_closure_parameters: warning
    avoid_void_async: error
    cancel_subscriptions: error
    close_sinks: error
    constant_identifier_names: warning
    empty_catches: warning
    empty_constructor_bodies: warning
    empty_statements: warning
    hash_and_equals: error
    no_duplicate_case_values: error
    null_closures: error
    prefer_single_quotes: error
    unnecessary_await_in_return: error
    unnecessary_new: error
    unnecessary_null_aware_assignments: error
    unnecessary_null_aware_operator_on_extension_on_nullable: error
    unnecessary_null_checks: error
    unnecessary_nullable_for_final_variable_declarations: error
    unnecessary_overrides: error
    unnecessary_parenthesis: error
    unnecessary_string_escapes: error
    unnecessary_string_interpolations: error
    use_key_in_widget_constructors: error
    use_rethrow_when_possible: error
    use_setters_to_change_properties: warning
    use_string_buffers: warning
    use_string_in_part_of_directives: warning
    annotate_overrides: error
    avoid_init_to_null: error
    avoid_null_assertion_in_null_AWARE_operators: error
    avoid_return_types_on_setters: error
    camel_case_extensions: error
    camel_case_types: error
    curly_braces_in_flow_control_structures: error
    directives_ordering: error
    library_names: error
    library_prefixes: error
    no_leading_underscores_for_library_prefixes: error
    no_leading_underscores_for_local_identifiers: error
    non_constant_identifier_names: error
    null_check_on_nullable_type_parameter: error
    omit_local_variable_types: warning
    prefer_adjacent_string_concatenation: warning
    prefer_collection_literals: error
    prefer_conditional_assignment: warning
    prefer_contains: warning
    prefer_equal_for_default_values: error
    prefer_final_parameters: error
    prefer_for_elements_to_map_fromIterable: warning
    prefer_generic_function_type_aliases: error
    prefer_if_elements_to_conditional_expressions: warning
    prefer_interpolation_to_compose_strings: error
    prefer_is_not_operator: error
    prefer_iterable_whereType: error
    prefer_singleWidgetPerFile: error
    sort_child_properties_last: warning
    type_init_formals: error
    unawaited_futures: error
    unnecessary_lambdas: warning
    unnecessary_new: error
    unnecessary_this: error
    unrelated_type_equality_checks: error
    use_function_type_syntax_for_parameters: error
    use_raw_strings: warning

dart_code_metrics:
  anti-patterns:
    - long-method
    - long-parameter-list
    - complex-nesting
    - mutable-params
  metrics:
    cyclomatic-complexity: 10
    maximum-nesting-level: 4
    number-of-parameters: 4
    source-lines-of-code: 50
    maintainability-index: 50
    halstead-volume: 300
    halstead-difficulty: 20
  metrics-exclude:
    - test/**
    - build/**
    - '**.g.dart'
    - '**.freezed.dart'
  rules:
    - avoid-unused-parameters:
        severity: error
    - avoid-nested-conditional-expressions:
        severity: error
    - avoid-missing-enum-constant-in-map:
        severity: error
    - binary-expression-operand-order:
        severity: warning
    - double-literal-format:
        severity: warning
    - no-boolean-literal-compare:
        severity: warning
    - no-empty-block:
        severity: warning
    - prefer-conditional-expressions:
        severity: warning
    - prefer-intl-name:
        severity: warning
    - prefer-match-file-name:
        severity: warning
    - avoid-global-state:
        severity: error
    - avoid-shadowing:
        severity: warning
    - avoid-unnecessary-type-casts:
        severity: warning
    - avoid-unnecessary-type-assertions:
        severity: warning
    - avoid-unrelated-type-assertions:
        severity: error
    - avoid-unused-generics:
        severity: error
    - avoid-dynamic:
        severity: warning
    - avoid-passing-async-when-sync-expected:
        severity: error
    - avoid-redundant-async:
        severity: warning
    - avoid-unnecessary-setstate:
        severity: warning
    - avoid-late-keyword:
        severity: warning
    - prefer-first:
        severity: warning
    - prefer-last:
        severity: warning
    - prefer-correct-edge-insets-constructor:
        severity: warning
    - prefer-single-widget-per-file:
        severity: warning
    - prefer-extracting-callbacks:
        severity: warning
    - avoid-duplicate-exports:
        severity: error
    - avoid-returning-widgets:
        severity: warning
    - prefer-text-rich:
        severity: warning
    - prefer-const-border-radius:
        severity: warning
    - prefer-correct-type-name:
        severity: warning
    - prefer-correct-test-file-name:
        severity: warning

linter:
  rules:
    - always_declare_return_types
    - always_put_control_body_on_new_line
    - always_put_required_named_parameters_first
    - always_require_non_null_named_parameters
    - always_use_package_imports
    - annotate_overrides
    - avoid_empty_else
    - avoid_print
    - avoid_relative_lib_imports
    - avoid_returning_null_for_future
    - avoid_returning_this
    - avoid_shadowing_type_parameters
    - avoid_types_as_parameter_names
    - await_only_futures
    - camel_case_extensions
    - camel_case_types
    - cancel_subscriptions
    - cast_nullable_to_non_nullable
    - constant_identifier_names
    - curly_braces_in_flow_control_structures
    - deprecated_consistency
    - directives_ordering
    - empty_catches
    - empty_constructor_bodies
    - empty_statements
    - hash_and_equals
    - implementation_imports
    - join_return_with_assignment
    - leading_newlines_in_multiline_strings
    - library_names
    - library_prefixes
    - library_private_types_in_public_api
    - missing_whitespace_between_adjacent_strings
    - no_leading_underscores_for_library_prefixes
    - no_leading_underscores_for_local_identifiers
    - no_runtimeType_toString
    - non_constant_identifier_names
    - null_check_on_nullable_type_parameter
    - null_closures
    - omit_local_variable_types
    - one_member_abstracts
    - only_throw_errors
    - overridden_fields
    - package_names
    - package_prefixed_library_names
    - parameter_assignments
    - prefer_adjacent_string_concatenation
    - prefer_collection_literals
    - prefer_conditional_assignment
    - prefer_const_constructors
    - prefer_const_constructors_in_immutables
    - prefer_const_declarations
    - prefer_const_literals_to_create_immutables
    - prefer_contains
    - prefer_equal_for_default_values
    - prefer_final_fields
    - prefer_final_in_for_each
    - prefer_final_locals
    - prefer_final_parameters
    - prefer_for_elements_to_map_fromIterable
    - prefer_generic_function_type_aliases
    - prefer_if_elements_to_conditional_expressions
    - prefer_if_null_operators
    - prefer_interpolation_to_compose_strings
    - prefer_is_empty
    - prefer_is_not_empty
    - prefer_is_not_operator
    - prefer_iterable_whereType
    - prefer_null_aware_method_calls
    - prefer_null_aware_operators
    - prefer_single_quotes
    - prefer_spread_collections
    - prefer_void_to_null
    - provide_deprecation_message
    - recursive_getters
    - require_trailing_commas
    - sized_box_for_whitespace
    - sized_box_shrink_expand
    - slash_for_doc_comments
    - sort_child_properties_last
    - sort_constructors_first
    - sort_unnamed_constructors_first
    - tighten_type_of_initializing_formals
    - type_annotate_public_apis
    - type_init_formals
    - unawaited_futures
    - unnecessary_await_in_return
    - unnecessary_brace_in_string_interps
    - unnecessary_const
    - unnecessary_constructor_name
    - unnecessary_getters_setters
    - unnecessary_lambdas
    - unnecessary_late
    - unnecessary_new
    - unnecessary_null_aware_assignments
    - unnecessary_null_checks
    - unnecessary_null_aware_operator_on_extension_on_nullable
    - unnecessary_nullable_for_final_variable_declarations
    - unnecessary_overrides
    - unnecessary_parenthesis
    - unnecessary_string_escapes
    - unnecessary_string_interpolations
    - unnecessary_this
    - unrelated_type_equality_checks
    - use_build_context_synchronously
    - use_full_hex_values_for_flutter_colors
    - use_function_type_syntax_for_parameters
    - use_if_null_to_convert_nulls_to_bools
    - use_is_even_rather_than_modulo
    - use_late_for_private_fields_when_needed
    - use_named_constants
    - use_raw_strings
    - use_rethrow_when_possible
    - use_setters_to_change_properties
    - use_string_buffers
    - use_string_in_part_of_directives
    - use_super_parameters
    - use_test_throws_matchers
    - use_to_and_as_if_applicable
    - void_checks

// === ARCHIVO: .github/workflows/code_quality.yml ===
name: Code Quality

on:
  push:
    branches:
      - main
      - develop
  pull_request:
    branches:
      - main
      - develop

env:
  flutter_version: '3.27.0'
  dart_version: '3.6.0'

jobs:
  analyze:
    name: Análisis estático y métricas de código
    runs-on: ubuntu-latest
    steps:
      - name: Verificar configuración de Git
        run: |
          git config --global --add safe.directory /__w/flutter_code_metrics_app
          git config --global --add safe.directory '*'

      - name: Obtener código fuente
        uses: actions/checkout@v4

      - name: Configurar Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.flutter_version }}
          channel: 'stable'
          cache: true
          cache-dependency-path: pubspec.lock

      - name: Obtener dependencias
        run: flutter pub get

      - name: Verificar formato de código
        id: format
        run: |
          flutter format --set-exit-if-changed lib/ test/
        continue-on-error: true

      - name: Ejecutar análisis estático con Flutter
        id: analyze
        run: |
          flutter analyze --no-fatal-infos --no-fatal-warnings
        continue-on-error: true

      - name: Ejecutar análisis de métricas con dart_code_metrics
        id: metrics
        run: |
          flutter pub run dart_code_metrics analyze lib/ \
            --reporter=github \
            --anti-patterns-reporter=github \
            --metrics-reporter=github \
            --output-dir=./metrics_output
        continue-on-error: true

      - name: Verificar umbrales de complejidad ciclomática
        run: |
          flutter pub run dart_code_metrics analyze lib/ \
            --reporter=json \
            --output-dir=./metrics_output

          echo "Verificando umbrales de complejidad ciclomática..."
          if grep -q 'cyclomatic-complexity.*[1-9][0-9]' ./metrics_output/metrics.json 2>/dev/null; then
            echo "ERROR: Se detectaron métodos con complejidad ciclomática mayor a 10"
            cat ./metrics_output/metrics.json | grep -A 5 'cyclomatic-complexity'
            exit 1
          fi
          echo "Umbral de complejidad ciclomática: OK"
        continue-on-error: true

      - name: Verificar anidamiento máximo
        run: |
          echo "Verificando nivel de anidamiento máximo..."
          if grep -q 'maximum-nesting-level.*[5-9]' ./metrics_output/metrics.json 2>/dev/null; then
            echo "ERROR: Se detectaron métodos con anidamiento mayor a 4"
            exit 1
          fi
          echo "Umbral de anidamiento: OK"
        continue-on-error: true

      - name: Verificar número de parámetros
        run: |
          echo "Verificando número de parámetros por función..."
          if grep -q 'number-of-parameters.*[5-9]' ./metrics_output/metrics.json 2>/dev/null; then
            echo "ERROR: Se detectaron funciones con más de 4 parámetros"
            exit 1
          fi
          echo "Umbral de parámetros: OK"
        continue-on-error: true

      - name: Verificar líneas de código por método
        run: |
          echo "Verificando líneas de código por método..."
          if grep -q 'source-lines-of-code.*[5-9][0-9]' ./metrics_output/metrics.json 2>/dev/null; then
            echo "ERROR: Se detectaron métodos con más de 50 líneas"
            exit 1
          fi
          echo "Umbral de líneas de código: OK"
        continue-on-error: true

      - name: Verificar reglas personalizadas de lint
        run: |
          echo "Verificando reglas personalizadas configuradas..."
          flutter analyze --no-fatal-infos 2>&1 | tee analyze_output.txt
          
          if grep -q 'error.*avoid-unused-parameters' analyze_output.txt; then
            echo "ERROR: Parámetros sin usar detectados - aplicar prefer_final_parameters"
            exit 1
          fi
          
          if grep -q 'error.*avoid-duplicate-exports' analyze_output.txt; then
            echo "ERROR: Exportaciones duplicadas detectadas"
            exit 1
          fi
          
          if grep -q 'error.*avoid-shadowing' analyze_output.txt; then
            echo "ERROR: Variables que sombrean otras detectadas"
            exit 1
          fi
          
          if grep -q 'error.*avoid-unrelated-type-assertions' analyze_output.txt; then
            echo "ERROR: Aserciones de tipos no relacionadas detectadas"
            exit 1
          fi
          
          if grep -q 'error.*avoid-global-state' analyze_output.txt; then
            echo "ERROR: Estado global detectado - refactorizar para usar inyección de dependencias"
            exit 1
          fi
          
          echo "Reglas personalizadas de lint: OK"
        continue-on-error: true

      - name: Verificar código duplicado
        run: |
          echo "Buscando código duplicado..."
          flutter pub run dart_code_metrics analyze lib/ \
            --reporter=json \
            --output-dir=./metrics_output \
            2>&1 | tee metrics_output.txt
          
          if grep -qi 'duplicate\|duplicado' metrics_output.txt; then
            echo "WARNING: Se detectó código duplicado"
          fi
        continue-on-error: true

      - name: Calcular índice de mantenibilidad
        run: |
          echo "Calculando índice de mantenibilidad..."
          if [ -f ./metrics_output/metrics.json ]; then
            echo "Reporte de métricas disponible en: ./metrics_output/metrics.json"
          fi
        continue-on-error: true

      - name: Reportar resultados del análisis
        if: always()
        run: |
          echo "=== RESULTADOS DEL ANÁLISIS DE CALIDAD ==="
          echo ""
          echo "Formato: ${{ steps.format.outcome }}"
          echo "Análisis estático: ${{ steps.analyze.outcome }}"
          echo "Métricas de código: ${{ steps.metrics.outcome }}"
          echo ""
          
          if [ "${{ steps.analyze.outcome }}" == "failure" ]; then
            echo "FALLÓ: El análisis estático encontró errores que deben corregirse"
            exit 1
          fi
          
          if [ "${{ steps.metrics.outcome }}" == "failure" ]; then
            echo "FALLÓ: Las métricas de código exceeden los umbrales configurados"
            exit 1
          fi
          
          echo "ÉXITO: Todo el análisis de calidad pasó exitosamente"

  test:
    name: Ejecutar pruebas unitarias
    runs-on: ubuntu-latest
    needs: analyze
    steps:
      - name: Verificar configuración de Git
        run: |
          git config --global --add safe.directory /__w/flutter_code_metrics_app
          git config --global --add safe.directory '*'

      - name: Obtener código fuente
        uses: actions/checkout@v4

      - name: Configurar Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.flutter_version }}
          channel: 'stable'
          cache: true
          cache-dependency-path: pubspec.lock

      - name: Obtener dependencias
        run: flutter pub get

      - name: Ejecutar pruebas
        run: |
          flutter test --reporter=github --coverage
        continue-on-error: true

      - name: Verificar cobertura de código
        run: |
          if [ -f "coverage/lcov.info" ]; then
            echo "Reporte de cobertura disponible"
          fi
        continue-on-error: true

      - name: Reportar resultados de pruebas
        if: always()
        run: |
          echo "=== RESULTADOS DE PRUEBAS ==="
          echo "Estado: ${{ job.status }}"

  build:
    name: Compilar aplicación debug
    runs-on: ubuntu-latest
    needs: test
    steps:
      - name: Verificar configuración de Git
        run: |
          git config --global --add safe.directory /__w/flutter_code_metrics_app
          git config --global --add safe.directory '*'

      - name: Obtener código fuente
        uses: actions/checkout@v4

      - name: Configurar Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.flutter_version }}
          channel: 'stable'
          cache: true
          cache-dependency-path: pubspec.lock

      - name: Obtener dependencias
        run: flutter pub get

      - name: Compilar APK debug
        run: |
          flutter build apk --debug
        continue-on-error: true

      - name: Compilar bundle web
        run: |
          flutter build web --release
        continue-on-error: true

      - name: Reportar resultados de compilación
        if: always()
        run: |
          echo "=== RESULTADOS DE COMPILACIÓN ==="
          echo "Estado: ${{ job.status }}"

  quality-gate:
    name: Validación final de calidad
    runs-on: ubuntu-latest
    needs: [analyze, test, build]
    if: always()
    steps:
      - name: Verificar estado de calidad
        run: |
          echo "=== GATE DE CALIDAD ==="
          echo "Análisis: ${{ needs.analyze.result }}"
          echo "Pruebas: ${{ needs.test.result }}"
          echo "Compilación: ${{ needs.build.result }}"
          echo ""
          
          if [ "${{ needs.analyze.result }}" == "failure" ]; then
            echo "BLOQUEO: Análisis de código falló"
            exit 1
          fi
          
          if [ "${{ needs.test.result }}" == "failure" ]; then
            echo "BLOQUEO: Pruebas unitarias fallaron"
            exit 1
          fi
          
          if [ "${{ needs.build.result }}" == "failure" ]; then
            echo "BLOQUEO: Compilación falló"
            exit 1
          fi
          
          echo "✓ Todos los gates de calidad pasaron"

// === ARCHIVO: tools/code_metrics/run_analysis.sh ===
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

// === ARCHIVO: tools/code_metrics/config/metrics_thresholds.json ===
{
  "version": "1.0.0",
  "description": "Configuración de umbrales máximos permitidos para métricas de calidad de código Flutter",
  "project": "flutter_code_metrics_app",
  "thresholds": {
    "cyclomatic-complexity": {
      "maxValue": 10,
      "severity": "error",
      "description": "Complejidad ciclomática máxima por método. Valores mayores a 10 indican métodos difíciles de probar y mantener.",
      "enabled": true
    },
    "maximum-nesting-level": {
      "maxValue": 4,
      "severity": "error",
      "description": "Nivel máximo de anidamiento permitido. Más de 4 niveles indica código difícil de leer.",
      "enabled": true
    },
    "number-of-parameters": {
      "maxValue": 4,
      "severity": "warning",
      "description": "Número máximo de parámetros por función. Funciones con más de 4 parámetros son difíciles de invocar.",
      "enabled": true
    },
    "source-lines-of-code": {
      "maxValue": 50,
      "severity": "warning",
      "description": "Líneas de código source máximo por método. Métodos muy largos violan el principio de responsabilidad única.",
      "enabled": true
    },
    "maintainability-index": {
      "minValue": 65,
      "severity": "error",
      "description": "Índice de mantenibilidad mínimo. Valores menores a 65 indican código difícil de mantener.",
      "enabled": true,
      "inverted": true
    },
    "technical-debt": {
      "maxValue": 30,
      "severity": "warning",
      "description": "Deuda técnica máxima en minutos. Más de 30 minutos indica acumulación significativa de deuda.",
      "enabled": true,
      "unit": "minutes"
    },
    "lines-of-code": {
      "maxValue": 500,
      "severity": "warning",
      "description": "Líneas de código máximo por archivo. Archivos muy grandes son difíciles de mantener.",
      "enabled": true
    },
    "number-of-functions": {
      "maxValue": 20,
      "severity": "warning",
      "description": "Número máximo de funciones por clase. Clases con más de 20 funciones violan el principio SRP.",
      "enabled": true
    },
    "coupling": {
      "maxValue": 15,
      "severity": "warning",
      "description": "Acoplamiento máximo entre módulos. Alto acoplamiento dificulta el mantenimiento.",
      "enabled": true
    },
    "cohesion": {
      "minValue": 70,
      "severity": "info",
      "description": "Cohesión mínima esperada por clase. Baja cohesión indica que la clase tiene responsabilidades mezcladas.",
      "enabled": true,
      "inverted": true
    }
  },
  "antiPatterns": {
    "long-method": {
      "enabled": true,
      "severity": "error",
      "description": "Detecta métodos que exceden el umbral de líneas de código"
    },
    "long-parameter-list": {
      "enabled": true,
      "severity": "warning",
      "description": "Detecta funciones con más de 4 parámetros"
    },
    "complex-conditionals": {
      "enabled": true,
      "severity": "warning",
      "description": "Detecta condicionales anidados que dificultan el flujo de lectura"
    },
    "god-class": {
      "enabled": true,
      "severity": "error",
      "description": "Detecta clases con demasiadas responsabilidades"
    },
    "feature-envy": {
      "enabled": true,
      "severity": "info",
      "description": "Detecta código que accede excesivamente a datos de otros objetos"
    }
  },
  "rules": {
    "avoid-unused-parameters": {
      "severity": "error",
      "enabled": true
    },
    "avoid-nested-conditional-expressions": {
      "severity": "error",
      "enabled": true
    },
    "avoid-global-state": {
      "severity": "error",
      "enabled": true
    },
    "avoid-shadowing": {
      "severity": "warning",
      "enabled": true
    },
    "avoid-unnecessary-type-assertions": {
      "severity": "warning",
      "enabled": true
    },
    "avoid-dynamic": {
      "severity": "warning",
      "enabled": true
    },
    "avoid-late-keyword": {
      "severity": "warning",
      "enabled": true
    },
    "prefer-single-widget-per-file": {
      "severity": "warning",
      "enabled": true
    },
    "prefer-extracting-callbacks": {
      "severity": "warning",
      "enabled": true
    },
    "avoid-returning-widgets": {
      "severity": "warning",
      "enabled": true
    }
  },
  "ciCdIntegration": {
    "failOnError": true,
    "failOnWarning": false,
    "generateHtmlReport": true,
    "generateJsonReport": true,
    "commentOnPullRequest": true,
    "includePaths": ["lib/**"],
    "excludePaths": ["test/**", "**.g.dart", "**.freezed.dart"]
  },
  "notifications": {
    "slack": {
      "enabled": false,
      "webhookUrl": ""
    },
    "email": {
      "enabled": false,
      "recipients": []
    }
  }
}

// === ARCHIVO: docs/ANALISIS_METRICAS_FASE1.md ===
# Análisis de Métricas de Calidad - Fase 1

## Propósito

Este documento registra el análisis inicial de métricas de calidad de código realizadas en el proyecto Flutter. El objetivo es evaluar el estado actual del código y establecer una línea base para las mejoras.

## Entorno de Análisis

### Herramientas Configuradas

El proyecto utiliza las siguientes herramientas de análisis estático:

- **flutter_lints** v5.0.0: Conjunto oficial de lint rules de Google para Flutter
- **dart_code_metrics** v5.7.6: Análisis avanzado de métricas de código
- **very_good_analysis** v5.2.0: Mejores prácticas de Very Good Ventures

### Configuración en analysis_options.yaml

```yaml
include: package:flutter_lints/flutter.yaml
include: package:very_good_analysis/analysis_options.yaml

analyzer:
  plugins:
    - dart_code_metrics
  errors:
    unused_local_variable: warning
    unused_import: error
```

## Métricas Evaluadas

### Complejidad Ciclomática

Umbral configurado: 10 por método

La complejidad ciclomática mide la cantidad de caminos independientes en el código. Valores superiores a 10 indican métodos que deberían refactorizarse.

### Anidamiento Máximo

Umbral configurado: 4 niveles

El nesting level excesivamente profundo dificulta el mantenimiento del código y indica necesidad de extracción de funciones.

### Líneas de Código por Método

Umbral configurado: 50 líneas

Métodos que excedan este límite deberían dividirse en funciones más pequeñas y reutilizables.

### Parámetros por Función

Umbral configurado: 4 parámetros

Funciones con más de 4 parámetros son candidatas para grouping en objetos o使用了 patrón Builder.

## Ejecución del Análisis

### Comando Principal

```bash
flutter pub run dart_code_metrics analyze lib/
```

### Análisis con Métricas Específicas

```bash
flutter pub run dart_code_metrics metrics lib/
```

### Generación de Reporte HTML

```bash
flutter pub run dart_code_metrics report --reporter=html --output-directory=metrics_report
```

## Interpretación de Resultados

### Severidades

- **error**: El código no pasa el análisis y bloquea el build
- **warning**: El código compila pero tiene prácticas mejorables
- **info**: Sugerencias de estilo y buenas prácticas

### Mantainability Index

Índice de 0-100 que indica la facilidad de mantenimiento del código:
- 100-80: Excelente mantenibilidad
- 79-60: Buena mantenibilidad
- 59-40: Moderada mantenibilidad
- Below 40: Mantenimiento difícil

### Technical Debt

Tiempo estimado necesario para corregir todos los issues encontrados. Se expresa en minutos u horas.

## Referencias

- Documentación oficial de Dart Code Metrics: https://dartcodemetrics.dev
- Flutter Lints: https://flutter.dev/docs/lints
- Very Good Analysis: https://github.com/VeryGoodOpenSource/very_good_analysis
```
