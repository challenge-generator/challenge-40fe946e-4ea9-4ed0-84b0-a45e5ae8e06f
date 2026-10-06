# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Implementación y validación de métricas de calidad en código Flutter**.

| | |
|---|---|
| Tema | Métricas de calidad de código |
| Nivel | advanced-l2 |
| Chapter | Móvil |
| Especialidad | Flutter |
| Stack | Dart / Flutter |
| Patron arquitectonico | herramientas de calidad de código con validación CI/CD |
| Tiempo estimado | 20 horas |

## Receta del stack

Esqueleto obligatorio:

- `pubspec.yaml en la raiz`
- `lib/main.dart con runApp`
- `lib/domain con entidades y repositorios abstractos`
- `lib/data con las implementaciones y el cliente Dio`
- `lib/presentation con screens y blocs/notifiers`

Dependencias:

- flutter_lints 5.0.0
- dart_code_metrics 5.7.6
- very_good_analysis 5.2.0
- flutter_bloc 8.1.6
- equatable 2.0.7
- dio 5.7.0
- get_it 8.0.3
- json_annotation 4.9.0
- flutter_test sdk
- bloc_test 9.1.7
- mocktail 1.0.4

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `flutter pub get && flutter analyze` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `flutter pub get && flutter analyze` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Evaluación inicial de métricas de calidad**: Documento con el análisis de las métricas de calidad actuales y propuestas de mejora.
- **Fase 2 — Sugerencia y aplicación de herramientas de calidad de código**: Documento con la sugerencia y aplicación de herramientas de calidad de código, incluyendo resultados y mejoras obtenidas.
- **Fase 3 — Implementación de validaciones de código**: Implementación de validaciones de código y documento de diseño y resultados.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Lo que falta y tenes que completar

### 1. Archivos que la arquitectura declara (4 de 18)

La propuesta arquitectonica del reto los lista y no llegaron al repo. Crealos con implementacion real, respetando la capa en la que viven:

- [ ] `lib/src/presentation/screens/metrics_dashboard_screen.dart`
- [ ] `lib/src/presentation/screens/metrics_detail_screen.dart`
- [ ] `docs/HERRAMIENTAS_APLICADAS_FASE2.md`
- [ ] `docs/VALIDACIONES_IMPLEMENTADAS_FASE3.md`

### 2. Referencias colgando (2)

Salieron de un analisis estatico del codigo que SI esta en el repo. Cada una rompe la compilacion:

- [ ] `lib/src/presentation/blocs/metrics/metrics_bloc.dart` — `MetricsRepository.getAnalysisResult`
      Se invoca `getAnalysisResult` sobre `MetricsRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/src/presentation/blocs/metrics/metrics_bloc.dart` — `MetricsRepository.exportMetrics`
      Se invoca `exportMetrics` sobre `MetricsRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

### Presentes (17)

- `pubspec.yaml`
- `lib/main.dart`
- `lib/src/core/linting/app_lints.dart`
- `lib/src/domain/entities/code_metric.dart`
- `lib/src/domain/entities/analysis_result.dart`
- `lib/src/domain/repositories/metrics_repository.dart`
- `lib/src/data/repositories/metrics_repository_impl.dart`
- `lib/src/data/datasources/code_metrics_datasource.dart`
- `lib/src/presentation/blocs/metrics/metrics_bloc.dart`
- `lib/src/presentation/blocs/metrics/metrics_event.dart`
- `lib/src/presentation/blocs/metrics/metrics_state.dart`
- `android/app/src/main/AndroidManifest.xml`
- `analysis_options.yaml`
- `.github/workflows/code_quality.yml`
- `tools/code_metrics/run_analysis.sh`
- `tools/code_metrics/config/metrics_thresholds.json`
- `docs/ANALISIS_METRICAS_FASE1.md`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `.github/workflows`
- `lib/src/core/linting`
- `lib/src/domain/entities`
- `lib/src/domain/repositories`
- `lib/src/data/repositories`
- `lib/src/data/datasources`
- `lib/src/presentation/screens`
- `lib/src/presentation/blocs`
- `tools/code_metrics`
- `docs`

## Verificacion

```bash
flutter pub get && flutter analyze
```

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **herramientas de calidad de código con validación CI/CD**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Advanced
- Brecha que el reto ataca: Realizar código pensando en mejorar las métricas de: Complejidad ciclomática, complejidad de anidamiento, Código duplicado, Issues del lenguaje y es capaz de orientar al resto del equipo. Sugiere herramientas que ayuden a escribir mejor código. Realiza implementación de herramientas que validen el código dentro de los proyectos
- Mision: Desarrollador Senior en equipo mobile con experiencia en Flutter

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
