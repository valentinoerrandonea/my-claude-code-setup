# Agentes Personalizados - Guia Completa

Los agentes personalizados son **especialistas reutilizables** que Claude Code puede invocar automaticamente cuando detecta que una tarea encaja con su perfil.

---

## Que es un agente personalizado?

**Que es:** Un archivo de texto (`.md`) que le dice a Claude Code "cuando alguien pida hacer X, usa estas instrucciones especializadas". Es como un manual de procedimientos para una tarea especifica.

**Analogia:** Imaginate que tenes una empresa. En vez de explicarle a un empleado nuevo cada vez que llega como hacer una auditoria de seguridad, le das un manual escrito: "Para auditorias de seguridad, revisa estos 10 puntos, usa este formato, y reporta asi". Eso es un agente personalizado.

**Ejemplo concreto:** Tenes un agente llamado `code-reviewer`. Cada vez que le decis a Claude Code "revisame el codigo" o "hace un code review", Claude automaticamente activa ese agente y sigue las instrucciones especificas que le escribiste: que revisar, como reportar, que formato usar.

---

## Para que sirven?

Los agentes son ideales para **tareas repetitivas con un foco especifico**:

| Tarea | Sin agente | Con agente |
|:------|:-----------|:-----------|
| Code review | Claude revisa "lo que le parece" | Sigue un checklist de 10 puntos, clasifica por severidad, da formato consistente |
| Seguridad | Revisa solo lo obvio | Escanea 10 categorias de vulnerabilidad, reporta con impacto y remediacion |
| Tests | Escribe tests basicos | Sigue el ciclo RED-GREEN-REFACTOR, exige 80% cobertura, testea edge cases |
| Planificacion | Arranca a codear directo | Investiga soluciones existentes, arma plan, identifica riesgos |

**La clave:** Le estas dando instrucciones ESPECIFICAS y CONSISTENTES que se aplican SIEMPRE que esa tarea se necesite. No dependes de que Claude "se acuerde" de como hacerlo bien.

---

## Donde van los agentes?

Los agentes son archivos `.md` que van en una de estas carpetas:

| Ubicacion | Alcance | Cuando usar |
|:----------|:--------|:------------|
| `~/.claude/agents/` | **Global** - funciona en cualquier proyecto | Tareas generales: code review, seguridad, TDD |
| `.claude/agents/` (en tu proyecto) | **Solo ese proyecto** | Tareas especificas: "deploy a produccion", "generar migraciones" |

> [!TIP]
> Este setup instala agentes globales en `~/.claude/agents/`. Si queres agentes solo para un proyecto, crea la carpeta `.claude/agents/` dentro de ese proyecto.

---

## Como se ve un agente?

Un agente es un archivo `.md` con dos partes:

1. **Cabecera YAML** (entre `---`): configuracion tecnica
2. **Cuerpo Markdown**: las instrucciones que sigue el agente

### Ejemplo: `code-reviewer.md`

```markdown
---
name: code-reviewer
description: Reviews code for quality, readability, and best practices. Use for code review tasks, PR reviews, and quality checks.
tools:
  - Read
  - Glob
  - Grep
model: sonnet
---

You are a senior code reviewer. Your job is to review code thoroughly.

## Review Checklist

1. Are function names clear?
2. Are functions small (<50 lines)?
3. Are errors handled properly?
4. Is user input validated?
5. No hardcoded secrets?
...
```

### Que significa cada campo de la cabecera

| Campo | Que hace | Ejemplo |
|:------|:---------|:--------|
| `name` | Nombre del agente | `code-reviewer` |
| `description` | **Lo mas importante.** Claude lee esto para decidir cuando activar el agente automaticamente | `"Reviews code for quality..."` |
| `tools` | Que herramientas puede usar (Read, Write, Edit, Bash, Grep, etc.) | `[Read, Glob, Grep]` |
| `model` | Que modelo de IA usar (`sonnet`, `opus`, `haiku`, `inherit`) | `sonnet` |

### Campos opcionales avanzados

| Campo | Que hace |
|:------|:---------|
| `disallowedTools` | Herramientas que NO puede usar (por seguridad) |
| `maxTurns` | Limite de pasos que puede dar antes de detenerse |
| `permissionMode` | Como maneja permisos (`default`, `acceptEdits`, `bypassPermissions`) |
| `memory` | Habilita memoria persistente entre sesiones (`user`, `project`, `local`) |
| `background` | Si corre en segundo plano (`true` / `false`) |
| `isolation` | Si trabaja en un worktree aislado (`worktree`) |

> [!NOTE]
> Para la mayoria de los agentes, solo necesitas `name`, `description`, `tools` y `model`. El resto es para casos avanzados.

---

## Como Claude decide cuando usar un agente?

Claude lee el campo `description` de cada agente. Cuando le pedis algo y la descripcion de un agente coincide con tu pedido, **Claude lo activa automaticamente**. No necesitas ningun comando especial.

**Ejemplos:**

| Vos decis | Claude activa | Por que |
|:----------|:-------------|:--------|
| "Revisame el codigo" | `code-reviewer` | La descripcion dice "Reviews code for quality" |
| "Hay alguna vulnerabilidad?" | `security-reviewer` | La descripcion dice "security analysis" |
| "Escribi tests para esta funcion" | `tdd-guide` | La descripcion dice "test-driven development" |
| "Planifica como implementar esta feature" | `planner` | La descripcion dice "implementation plans for complex features" |

### Tambien podes invocarlo explicitamente

Si queres forzar un agente especifico:
- Mencionalo por nombre: "Usa el agente code-reviewer para revisar esto"
- Usa el comando `/agents` en Claude Code para ver la lista y seleccionar uno

---

## Como crear un buen agente

### Regla de oro: la descripcion es TODO

La `description` es lo que Claude lee para decidir si activar el agente. Tiene que ser:

- **Especifica**: "Reviews Python code for PEP 8 compliance" ✅ vs "Reviews code" ❌
- **Orientada a la accion**: "Performs security analysis" ✅ vs "Security stuff" ❌
- **Con contexto de cuando usarlo**: "Use for code review tasks, PR reviews" ✅

### Estructura recomendada del cuerpo

```markdown
## Rol
Describe quien es el agente (ej: "You are a senior security analyst")

## Proceso / Checklist
Lista ordenada de pasos o items a verificar

## Formato de salida
Como debe reportar los resultados (tabla, lista, etc.)

## Reglas
Restricciones importantes (ej: "Never modify files", "Focus on CRITICAL first")
```

### Tips para agentes efectivos

1. **Se especifico con las instrucciones**: "Revisa estos 10 puntos" es mejor que "revisa el codigo"
2. **Define el formato de salida**: Si queres un reporte con severidades, especificalo
3. **Limita las herramientas**: Un reviewer no necesita `Write` ni `Edit` — solo `Read` y `Grep`
4. **Ponle restricciones claras**: "Never modify files" evita accidentes
5. **Usa el modelo correcto**:
   - `haiku` → tareas simples y rapidas (formatos, linting)
   - `sonnet` → la mayoria de tareas (review, tests, planning)
   - `opus` → analisis profundo (arquitectura, decisiones complejas)

---

## Pedile a Claude que cree agentes por vos

No necesitas escribir los agentes a mano. Podes pedirle a Claude Code:

> "Creame un agente personalizado que se encargue de revisar performance en codigo Python. Que busque N+1 queries, imports innecesarios, y bucles ineficientes. Guardalo en ~/.claude/agents/"

Claude Code va a:
1. Crear el archivo `.md` con la estructura correcta
2. Escribir la cabecera YAML con los campos adecuados
3. Definir un checklist especifico para performance
4. Guardarlo en la carpeta de agentes

**Otro ejemplo:**

> "Creame un agente que genere documentacion automatica para APIs REST. Que lea los endpoints, los parametros, y genere un markdown con ejemplos"

> [!TIP]
> Despues de crear un agente, probalo: "Usa el agente [nombre] para [tarea]" y fijate si hace lo que esperabas. Si no, pedile a Claude que lo ajuste.

---

## Cuando usar agentes custom vs Agent Teams

Esto es importante. Son cosas distintas para situaciones distintas:

| | Agentes Custom | Agent Teams |
|:-|:---------------|:------------|
| **Que son** | Plantillas reutilizables con instrucciones especializadas | Multiples Claudes trabajando en paralelo |
| **Cuantos corren** | Uno a la vez (activado dentro de tu Claude) | Varios al mismo tiempo |
| **Para que** | Tareas repetitivas con foco especifico | Dividir trabajo grande en partes paralelas |
| **Ejemplo** | "Siempre que revises codigo, segui este checklist de 10 puntos" | "Implementa login, registro y recovery en paralelo" |
| **Analogia** | Un manual de procedimientos | Un equipo de empleados |
| **Requiere Git** | No | Si (para worktrees) |

### Cuando usar agentes custom

- Queres **consistencia**: que cada code review siga el mismo formato
- Queres **especializacion**: un agente que solo busque vulnerabilidades SQL
- La tarea es **recurrente**: la haces seguido y queres automatizar el "como"
- Queres que Claude active el comportamiento **automaticamente** sin que vos lo pidas cada vez

### Cuando usar Agent Teams

- El trabajo se puede **dividir en partes independientes**
- Necesitas **velocidad**: que 3 cosas se hagan al mismo tiempo
- Las partes tocan **archivos distintos** (para evitar conflictos)
- Es una tarea **grande y unica** (no recurrente)

### Combo: agentes custom + Agent Teams

Lo mejor de ambos mundos:

> "Implementa el sistema de pagos en paralelo con worktrees. Usa el agente security-reviewer para revisarlo cuando termine."

Claude:
1. Crea 3 agentes en paralelo (Agent Teams + worktrees) para implementar
2. Cuando terminan, activa el agente `security-reviewer` para auditar
3. Te da el resultado final con el reporte de seguridad incluido

---

## Agentes incluidos en este setup

Este setup instala 4 agentes listos para usar:

| Agente | Que hace | Se activa cuando decis |
|:-------|:---------|:----------------------|
| **code-reviewer** | Revisa calidad del codigo con checklist de 8 puntos | "Revisame el codigo", "Hace code review" |
| **security-reviewer** | Busca vulnerabilidades con checklist de 10 categorias | "Hay vulnerabilidades?", "Revisa la seguridad" |
| **tdd-guide** | Guia desarrollo con tests primero (RED-GREEN-REFACTOR) | "Escribi tests", "Implementa con TDD" |
| **planner** | Planifica antes de codear: investiga, analiza, arma plan | "Planifica esta feature", "Como implemento esto?" |

> [!TIP]
> Estos agentes estan en `~/.claude/agents/` y tambien en `configs/agents/` del repo. Podes modificarlos, mejorarlos, o crear nuevos y mandar un PR para que otros los usen tambien.

---

## Ejemplo completo: crear tu propio agente

Supongamos que siempre necesitas generar changelogs cuando haces un release. Pedile a Claude:

> "Creame un agente que genere changelogs automaticos. Que lea los commits desde el ultimo tag, los agrupe por tipo (feat, fix, docs), y genere un CHANGELOG.md con formato bonito."

Claude crea `~/.claude/agents/changelog-generator.md`:

```markdown
---
name: changelog-generator
description: Generates changelogs from git commits. Use when preparing releases, creating version notes, or updating CHANGELOG.md.
tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
  - Grep
model: haiku
---

You are a changelog generator. Your job is to create clear, organized changelogs.

## Process

1. Find the last git tag: `git describe --tags --abbrev=0`
2. Get commits since that tag: `git log <tag>..HEAD --oneline`
3. Group commits by type (feat, fix, docs, refactor, etc.)
4. Generate CHANGELOG.md with sections for each type
5. Include date, version, and contributor info

## Output Format

### [version] - YYYY-MM-DD

#### Features
- Description of feature (commit hash)

#### Bug Fixes
- Description of fix (commit hash)

#### Documentation
- Description of doc change (commit hash)
```

Ahora, cada vez que digas "genera el changelog" o "preparame las release notes", Claude activa este agente automaticamente.

---

## Resumen rapido

| Pregunta | Respuesta |
|:---------|:---------|
| Donde van? | `~/.claude/agents/` (global) o `.claude/agents/` (por proyecto) |
| Que formato tienen? | Archivo `.md` con cabecera YAML + instrucciones markdown |
| Se activan solos? | Si, Claude lee la `description` y decide cuando activarlos |
| Puedo crearlos sin escribir codigo? | Si, pedile a Claude "creame un agente que haga X" |
| Cuantos puedo tener? | Los que quieras |
| Puedo combinarlos con Agent Teams? | Si, son complementarios |

Los agentes del repo estan en `configs/agents/`. Podes modificarlos, mejorarlos, o agregar nuevos y mandar un PR.
