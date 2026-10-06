# Implementación y validación de métricas de calidad en código Flutter

Como desarrollador Senior en el equipo móvil, tu tarea es mejorar las métricas de calidad del código en proyectos Flutter. Debes enfocarte en la complejidad ciclomática, complejidad de anidamiento, código duplicado y issues del lenguaje. Además, deberás sugerir y aplicar herramientas que ayuden a escribir mejor código y realizar implementaciones que validen el código dentro de los proyectos.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Métricas de calidad de código |
| **Nivel** | advanced-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 20 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Evaluación inicial de métricas de calidad

**Objetivo:** Identificar y evaluar las métricas de calidad actuales del código en un proyecto Flutter.

**Tiempo estimado:** 5 horas

**Instrucciones:**

- Analiza un proyecto Flutter existente para identificar la complejidad ciclomática, complejidad de anidamiento, código duplicado y issues del lenguaje.
- Documenta los hallazgos y propone mejoras basadas en las métricas identificadas.

**Entregable:** Documento con el análisis de las métricas de calidad actuales y propuestas de mejora.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el impacto de las métricas en la mantenibilidad y escalabilidad del código.
- Investiga herramientas que puedan automatizar la evaluación de estas métricas.

</details>

### Fase 2: Sugerencia y aplicación de herramientas de calidad de código

**Objetivo:** Sugerir y aplicar herramientas que ayuden a mejorar la calidad del código en proyectos Flutter.

**Tiempo estimado:** 8 horas

**Instrucciones:**

- Investiga y selecciona herramientas que puedan ayudar a mejorar las métricas de calidad identificadas en la fase anterior.
- Aplica estas herramientas en el proyecto Flutter y documenta el proceso y los resultados.

**Entregable:** Documento con la sugerencia y aplicación de herramientas de calidad de código, incluyendo resultados y mejoras obtenidas.

<details>
<summary>Pistas de conocimiento</summary>

- Evalúa la eficacia de las herramientas en términos de mejora de las métricas de calidad.
- Considera la integración de estas herramientas en el flujo de trabajo del equipo.

</details>

### Fase 3: Implementación de validaciones de código

**Objetivo:** Implementar validaciones de código que aseguren la mejora continua de las métricas de calidad en proyectos Flutter.

**Tiempo estimado:** 7 horas

**Instrucciones:**

- Diseña e implementa validaciones de código que se ejecuten automáticamente en el proyecto Flutter.
- Asegura que estas validaciones ayuden a mantener y mejorar las métricas de calidad identificadas.
- Documenta el diseño y la implementación de las validaciones.

**Entregable:** Implementación de validaciones de código y documento de diseño y resultados.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el impacto de las validaciones en el flujo de trabajo del equipo.
- Evalúa la efectividad de las validaciones en términos de mejora de las métricas de calidad.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué son las métricas de calidad de código y por qué son importantes?
- **paraQueSirve**: ¿Para qué sirven las herramientas de calidad de código en un proyecto Flutter?
- **comoSeUsa**: ¿Cómo se aplican las validaciones de código para mejorar las métricas de calidad?
- **erroresComunes**: ¿Cuáles son los errores comunes al implementar métricas de calidad de código?
- **queDecisionesImplica**: ¿Qué decisiones debes tomar al seleccionar y aplicar herramientas de calidad de código?

## Criterios de Evaluacion

- Identificación y evaluación de métricas de calidad de código en un proyecto Flutter.
- Sugerencia y aplicación de herramientas que mejoren la calidad del código.
- Implementación de validaciones de código que aseguren la mejora continua de las métricas de calidad.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
flutter pub get && flutter analyze
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
