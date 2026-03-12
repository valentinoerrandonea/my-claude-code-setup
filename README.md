<a id="readme-top"></a>

<div align="center">

```
  _____ _                 _         ___          _
 / ____| |               | |       / __\___   __| | ___
| |    | | __ _ _   _  __| | ___  / /  / _ \ / _` |/ _ \
| |    | |/ _` | | | |/ _` |/ _ \/ /__| (_) | (_| |  __/
 \____|_|\__,_|\__,_|\__,_|\___/\____/\___/ \__,_|\___|
  ____                          ____       _
 |  _ \ _____      _____ _ __ / ___|  ___| |_ _   _ _ __
 | |_) / _ \ \ /\ / / _ \ '__\___ \ / _ \ __| | | | '_ \
 |  __/ (_) \ V  V /  __/ |   ___) |  __/ |_| |_| | |_) |
 |_|   \___/ \_/\_/ \___|_|  |____/ \___|\__|\__,_| .__/
                                                    |_|
```

**Multiples agentes de IA trabajando en paralelo, en una grilla dentro de tu terminal, con un solo atajo de teclado.**

[![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)](LICENSE)
[![macOS](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey?style=flat-square)]()
[![Claude Code](https://img.shields.io/badge/Claude%20Code-powered-blueviolet?style=flat-square)](https://claude.ai)
[![tmux](https://img.shields.io/badge/tmux-multiplexer-1BB91F?style=flat-square)](https://github.com/tmux/tmux)
[![Ghostty](https://img.shields.io/badge/Ghostty-terminal-orange?style=flat-square)](https://ghostty.org)

[Instalacion](#-como-instalarlo) |
[Uso](#-como-se-usa) |
[Guia de Tools](docs/tools-guide.md) |
[Contribuir](#-como-contribuir-vos-o-tus-amigos) |
[Troubleshooting](docs/troubleshooting.md)

</div>

---

<details>
<summary><strong>Tabla de Contenidos</strong></summary>

- [Que es esto?](#-que-es-esto)
- [Que necesitas antes de empezar](#-que-necesitas-antes-de-empezar)
- [Como instalarlo](#-como-instalarlo)
- [Como se usa](#-como-se-usa)
- [Dos formas de trabajar](#-dos-formas-de-trabajar-y-cuando-usar-cada-una)
- [Que se instala exactamente](#-que-se-instala-exactamente)
- [Cosas que podes pedirle a Claude Code](#-cosas-que-podes-pedirle-a-claude-code)
- [Como contribuir](#-como-contribuir-vos-o-tus-amigos)
- [Donde esta cada cosa](#-donde-esta-cada-cosa-despues-de-instalar)
- [Personalizacion](#-personalizacion)
- [Documentacion completa](#-documentacion-completa)
- [Desinstalar](#-desinstalar)
- [Nota sobre los archivos](#-nota-sobre-los-archivos-de-este-repo)

</details>

---

## Que es esto?

Este repositorio es un **kit de instalacion automatica** que configura tu computadora para trabajar con Claude Code de la manera mas productiva posible.

En vez de tener un solo Claude Code abierto, este setup te permite:

- Tener **varios Claude Code al mismo tiempo** en una grilla (uno escribe codigo, otro hace tests, otro revisa seguridad)
- Abrir nuevos agentes con **un solo atajo de teclado** (<kbd>Cmd</kbd>+<kbd>N</kbd>)
- Moverte entre ellos con **las flechas del teclado**
- Ponerle **nombres** a cada panel para saber que esta haciendo cada uno
- Tener **reglas globales** que hacen que Claude escriba mejor codigo automaticamente
- Acceder a **herramientas avanzadas** de orquestacion multi-agente

Todo se instala y configura automaticamente. Vos no tenes que tocar nada.

### Como funciona?

La mayoria de los archivos de este repositorio son **instrucciones que lee Claude Code**, no vos. Cuando le decis a tu Claude Code "instala esto", el lee los archivos `CLAUDE.md` y `CONTRIBUTING.md`, entiende que tiene que hacer, y lo hace solo.

> [!TIP]
> Vos solo le das la orden. El hace el resto.

<p align="right"><a href="#readme-top">volver arriba</a></p>

---

## Que necesitas antes de empezar

| Requisito | Donde conseguirlo |
|:----------|:------------------|
| **macOS** o **Linux** | Ya lo tenes |
| **Git** | macOS: viene instalado. Linux: `sudo apt install git` |
| **Homebrew** (solo macOS) | [brew.sh](https://brew.sh) |
| **Node.js** o **Bun** | [nodejs.org](https://nodejs.org) o [bun.sh](https://bun.sh) |
| **Ghostty** (terminal) | [ghostty.org](https://ghostty.org) |
| **Cuenta de Claude** | Pro, Max, Teams o Enterprise en [claude.ai](https://claude.ai) |
| **Claude Code** instalado | Se instala automaticamente, pero si lo queres hacer manual: `npm install -g @anthropic-ai/claude-code` |

<p align="right"><a href="#readme-top">volver arriba</a></p>

---

## Como instalarlo

### Opcion 1: Decile a tu Claude Code (recomendado)

Abri Claude Code y decile:

> "Clona este repo e instala todo: `<url-del-repo>`"

Claude Code lee el archivo `CLAUDE.md` del repo y ejecuta toda la instalacion automaticamente. No tenes que hacer nada mas.

### Opcion 2: Correr el instalador manualmente

```bash
git clone <url-del-repo>
cd claude-code-power-setup
chmod +x install.sh scripts/*.sh
./install.sh
```

### Despues de instalar

1. **Recarga tu shell**: `source ~/.zshrc`
2. **Autenticate** (si es la primera vez): escribi `claude` y segui el login en el navegador
3. **Reinicia Ghostty** para que tome la nueva config
4. **Listo!** Escribi `cc` para arrancar

> [!IMPORTANT]
> Todas las configs son **globales**. `cc` funciona desde cualquier directorio y Claude Code se abre en el directorio donde estes parado.

<p align="right"><a href="#readme-top">volver arriba</a></p>

---

## Como se usa

### Los 4 comandos para arrancar

Escribilos en tu terminal (Ghostty):

| Comando | Que hace |
|:--------|:---------|
| `cc` | Abre Claude Code **en el directorio donde estes parado**. Si ya habia una sesion, te reconecta |
| `ccnew` | Borra todo y arranca un Claude Code nuevo de cero (en el directorio actual) |
| `ccresume` | Abre Claude Code y continua tu ultima conversacion (en el directorio actual) |
| `ccpick` | Te muestra una lista de conversaciones pasadas para elegir (en el directorio actual) |

### Atajos de teclado

<details open>
<summary><strong>Crear y manejar paneles</strong></summary>

| Atajo | Que hace |
|:------|:---------|
| <kbd>Cmd</kbd>+<kbd>N</kbd> | Abre un nuevo Claude Code al lado (se acomodan solos en grilla) |
| <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>N</kbd> | Abre un nuevo Claude Code abajo |
| <kbd>Cmd</kbd>+<kbd>Ctrl</kbd>+<kbd>R</kbd> | Renombra el panel actual (ej: "backend", "tests") |
| <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>=</kbd> | Redistribuye todos los paneles en partes iguales |

</details>

<details open>
<summary><strong>Moverse entre paneles</strong></summary>

| Atajo | Que hace |
|:------|:---------|
| <kbd>Option</kbd>+<kbd>Ctrl</kbd>+<kbd>Flechas</kbd> | Salta al panel de la izquierda, derecha, arriba o abajo |
| Click del mouse | Hace foco en el panel que clickeas |
| Scroll del mouse | Scrollea el output del panel |

</details>

<details>
<summary><strong>Otros atajos utiles</strong></summary>

| Atajo | Que hace |
|:------|:---------|
| <kbd>Ctrl</kbd>+<kbd>A</kbd> luego <kbd>d</kbd> | Desconectar de tmux (la sesion sigue viva en segundo plano) |
| <kbd>Ctrl</kbd>+<kbd>D</kbd> o `exit` | Cerrar el panel actual |
| <kbd>Cmd</kbd>+<kbd>\`</kbd> | Terminal dropdown rapido (aparece desde arriba) |
| <kbd>Cmd</kbd>+<kbd>Shift</kbd>+<kbd>,</kbd> | Recargar config de Ghostty |

</details>

<p align="right"><a href="#readme-top">volver arriba</a></p>

---

## Dos formas de trabajar (y cuando usar cada una)

Este setup te da dos formas de usar multiples Claudes. Es importante entender la diferencia:

### Problema: varios Claudes tocando el mismo codigo

Si abris 3 paneles con <kbd>Cmd</kbd>+<kbd>N</kbd> y los 3 modifican el mismo archivo al mismo tiempo, **se van a pisar**. Uno escribe una funcion, el otro la sobreescribe, y se rompe todo. Esto es un problema real.

> [!WARNING]
> Nunca pongas dos paneles a modificar el mismo archivo. Usa **roles distintos** para los paneles y **worktrees** para codigo en paralelo.

### Solucion: separar por AREA (paneles) y por CODIGO (worktrees)

```
┌─────────────────┬─────────────────┐
│   "coder"       │   "researcher"  │  ← Paneles tmux (Cmd+N)
│                 │                 │     Cada uno tiene un ROL distinto
│   Escribe       │   Responde      │     NO tocan el mismo codigo
│   codigo        │   preguntas     │
│                 │                 │
│   (usa worktrees│                 │
│    internamente │                 │
│    si necesita  │                 │
│    paralelizar) │                 │
├─────────────────┼─────────────────┤
│   "planner"     │   "analyzer"    │
│                 │                 │
│   Planifica     │   Analiza       │
│   la proxima    │   performance   │
│   feature       │   y seguridad   │
│                 │                 │
└─────────────────┴─────────────────┘
```

### Paneles tmux (<kbd>Cmd</kbd>+<kbd>N</kbd>) &rarr; para ROLES distintos

Cada panel es un Claude con un **proposito diferente**. No deberian tocar los mismos archivos al mismo tiempo.

<details open>
<summary><strong>Ejemplos de roles</strong></summary>

| Panel | Rol | Que le decis |
|:------|:----|:-------------|
| `coder` | Programador | "Implementa la feature de login" |
| `researcher` | Investigador | "Busca las mejores practicas para auth con JWT" |
| `planner` | Planificador | "Arma el plan de las proximas 3 features" |
| `analyzer` | Analista | "Revisame el proyecto y decime que mejorar" |
| `reviewer` | Revisor | "Hace code review de lo que hizo el coder" |

</details>

Como cada uno tiene un proposito distinto, no se pisan. El coder escribe codigo, el researcher busca info, el planner arma documentos, el analyzer lee sin modificar.

**Ejemplo paso a paso:**

```
1. Abri terminal y escribi: cc
2. Tocas Cmd+N → aparece un segundo Claude
3. Tocas Cmd+N → aparece un tercero (grilla de 3)
4. Renombras cada uno con Cmd+Ctrl+R:
   - "coder" → "Implementa el sistema de pagos"
   - "researcher" → "Investiga como integrar Stripe en Node.js"
   - "reviewer" → "Cuando el coder termine, revisale el codigo"
```

### Worktrees &rarr; para CODIGO en paralelo (dentro de un panel)

Cuando UN Claude necesita hacer varias cosas que tocan el mismo codigo, usa **worktrees**. Cada tarea trabaja en su propia copia aislada del proyecto, y al final se mergea todo.

**Ejemplo:** Le decis al panel "coder":

> "Implementa login, registro y recuperacion de password en paralelo con worktrees"

Ese Claude crea 3 agentes internos, cada uno con su copia aislada:

```
Claude "coder":
  ├── Agente 1 → copia aislada → implementa login
  ├── Agente 2 → copia aislada → implementa registro
  └── Agente 3 → copia aislada → implementa recuperacion

  ... los 3 trabajan sin pisarse ...

Claude "coder": "Listo. Mergee todo. Aca tenes el resumen."
```

> [!NOTE]
> **Requisito:** Tu proyecto tiene que tener Git. Si no lo tiene:
> ```bash
> cd tu-proyecto
> git init && git add -A && git commit -m "initial commit"
> ```
> No necesitas GitHub. Solo Git local.

### Resumen: cuando usar que

| Situacion | Que usar |
|:----------|:---------|
| Quiero Claudes con propositos distintos (uno codea, otro investiga) | **Paneles tmux** (<kbd>Cmd</kbd>+<kbd>N</kbd>) |
| Quiero que un Claude haga varias tareas de codigo en paralelo | **Worktrees** (decile "hacelo en paralelo con worktrees") |
| Quiero ambas cosas | **Paneles para roles + worktrees dentro del panel que codea** |

### El combo completo (lo recomendado)

```
┌──────────────────────────────────┬──────────────────┐
│  "coder"                         │  "researcher"    │
│                                  │                  │
│  "Implementa auth, payments      │  "Buscame las    │
│   y notifications en paralelo    │   mejores libs   │
│   con worktrees"                 │   para emails"   │
│                                  │                  │
│  → internamente crea 3 agentes   │  → solo busca,   │
│    cada uno en su copia aislada  │    no toca codigo │
│    y al final mergea todo        │                  │
├──────────────────────────────────┼──────────────────┤
│  "planner"                       │  "reviewer"      │
│                                  │                  │
│  "Planifica el roadmap del       │  "Cuando el      │
│   proximo sprint"                │   coder termine, │
│                                  │   revisale todo" │
│  → arma documentos,              │                  │
│    no toca codigo                │  → lee y analiza │
└──────────────────────────────────┴──────────────────┘
```

Asi tenes lo mejor de ambos mundos:
- **Paneles** para separar roles (nadie se pisa)
- **Worktrees** dentro del panel que codea (paralelismo seguro)

> [!TIP]
> Para la guia completa de worktrees: [Agent Teams + Worktrees Guide](docs/agent-teams-guide.md)

<p align="right"><a href="#readme-top">volver arriba</a></p>

---

## Que se instala exactamente

<details open>
<summary><strong>Lo esencial</strong></summary>

| Componente | Que es | Para que sirve |
|:-----------|:-------|:---------------|
| **Claude Code** | Asistente de IA en la terminal | El cerebro de todo. Le hablas y codea por vos |
| **tmux** | Multiplicador de pantallas | Divide tu terminal en multiples paneles |
| **Ghostty config** | Configuracion del terminal | Atajos de teclado, tema visual, transparencia |
| **Launcher script** | Script de arranque | Los comandos `cc`, `ccnew`, `ccresume`, `ccpick` |

</details>

<details>
<summary><strong>Plugins de tmux (se instalan solos)</strong></summary>

| Plugin | Que hace |
|:-------|:---------|
| **tmux-yank** | Seleccionar texto con mouse = copiado al clipboard |
| **tmux-better-mouse-mode** | Scroll con mouse funciona en todos lados |
| **tmux-resurrect** | Guarda tus paneles y los restaura si se cierra |
| **tmux-continuum** | Auto-guarda cada 15 minutos |
| **tmux-sensible** | Configuraciones logicas por defecto |
| **tmux-open** | Click en URLs para abrirlas en el navegador |

</details>

<details>
<summary><strong>Agent Teams + Worktrees (viene incluido)</strong></summary>

No es una herramienta que se instala aparte. Es una capacidad que ya tiene Claude Code y que este setup deja configurada y lista para usar. Solo necesitas un repo de Git y decirle "hacelo en paralelo".

| Componente | Que hace |
|:-----------|:---------|
| **Agent Teams** | Claude crea y coordina otros Claudes automaticamente |
| **Worktrees** | Cada agente trabaja en una copia aislada (no se pisan) |
| **Merge automatico** | El lider junta todo cuando terminan |

</details>

<details>
<summary><strong>Reglas globales para Claude Code</strong></summary>

Se instalan en `~/.claude/rules/` y hacen que **cualquier Claude Code en cualquier proyecto** sea mas inteligente:

| Regla | Que le dice a Claude |
|:------|:---------------------|
| **coding-style** | Codigo limpio, archivos chicos, inmutabilidad |
| **testing** | Escribir tests primero, minimo 80% cobertura |
| **security** | Nunca poner passwords en el codigo, validar todo |
| **git-workflow** | Commits con formato claro (`feat:`, `fix:`, etc.) |
| **development-workflow** | Investigar antes de codear, planificar primero |
| **performance** | Usar el modelo correcto para cada tarea |
| **agents** | Usar multiples agentes en paralelo cuando corresponde |

</details>

<details>
<summary><strong>Herramientas multi-agente</strong></summary>

Herramientas avanzadas para orquestar muchos Claudes automaticamente:

| Herramienta | Que es en simple | Lenguaje |
|:------------|:-----------------|:---------|
| [Claude Swarm](https://github.com/claudio-silva/claude-swarm) | Director de orquesta: define roles y los coordina | Python |
| [Zerg](https://github.com/codeium/zerg) | General de ejercito: manda muchos agentes en paralelo | Python |
| [Overstory](https://github.com/overtone-app/overstory) | Panel de control: ves que hace cada agente en un dashboard | Bun/Node |
| [ccswarm](https://github.com/deansher/ccswarm) | Coordinador ultra-rapido hecho en Rust | Rust |
| [Ruflo](https://github.com/ruflo/ruflo) | Linea de produccion: automatiza pasos en secuencia | Node.js |

</details>

<details>
<summary><strong>Repos de referencia</strong></summary>

| Repo | Que tiene |
|:-----|:---------|
| [awesome-claude-code](https://github.com/anthropics/awesome-claude-code) | Lista curada de tips, trucos y recursos |
| [agents](https://github.com/wshobson/agents) | Ejemplos de agentes personalizados |
| [claude-code-mcp-servers](https://github.com/anthropics/claude-code-mcp-servers) | Conectores oficiales (bases de datos, APIs, etc.) |
| [awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) | Conectores de la comunidad (Google Drive, Slack, etc.) |

</details>

<p align="right"><a href="#readme-top">volver arriba</a></p>

---

## Cosas que podes pedirle a Claude Code

Este setup esta pensado para que vos le hables a Claude Code y el haga las cosas. Aca van ejemplos concretos:

<details open>
<summary><strong>Instalar algo nuevo</strong></summary>

> "Instala la herramienta X y configurala globalmente"

Claude Code va a:
1. Crear un branch nuevo
2. Instalar la herramienta
3. Agregar un script de instalacion
4. Documentar todo
5. Crear un PR para que vos lo apruebes

</details>

<details open>
<summary><strong>Mejorar algo existente</strong></summary>

> "Mejora la config de tmux para que tenga mejor soporte de colores"

Claude Code modifica lo necesario, actualiza la documentacion y crea un PR.

</details>

<details>
<summary><strong>Agregar una skill o regla nueva</strong></summary>

> "Agrega una skill que revise la accesibilidad del codigo"

Claude Code la crea, la configura globalmente (para que funcione en cualquier proyecto), la documenta, y crea un PR.

</details>

<details>
<summary><strong>Arreglar algo roto</strong></summary>

> "El comando ccresume no funciona, arreglalo"

Claude Code diagnostica el problema, lo arregla, actualiza troubleshooting si corresponde, y crea un PR.

</details>

> [!IMPORTANT]
> Todos los cambios se hacen en un branch nuevo y generan un PR. Nada se mergea a `main` sin tu aprobacion.

<p align="right"><a href="#readme-top">volver arriba</a></p>

---

## Como contribuir (vos o tus amigos)

Este repo esta vivo. Crece cada vez que alguien agrega algo nuevo.

### El flujo es asi:

```
   Tu instruccion          Claude Code lee          Crea branch          Hace cambios
  ┌─────────────┐        ┌──────────────┐        ┌────────────┐       ┌─────────────┐
  │  "Agrega    │───────▶│  CLAUDE.md   │───────▶│  tool/new  │──────▶│  Instala,   │
  │  tal tool"  │        │  CONTRIBUTING │        │  branch    │       │  configura, │
  └─────────────┘        └──────────────┘        └────────────┘       │  documenta  │
                                                                       └──────┬──────┘
                                                                              │
   Se mergea               Vos revisas              Crea PR                   │
  ┌─────────────┐        ┌──────────────┐        ┌────────────┐              │
  │  main ←─────│◀───────│  Aprobar /   │◀───────│  PR con    │◀─────────────┘
  │  actualizado│        │  Pedir       │        │  formato   │
  └─────────────┘        │  cambios     │        │  estandar  │
                          └──────────────┘        └────────────┘
```

### Reglas que sigue Claude Code automaticamente

- Todo cambio va en un **branch nuevo** (`tool/nombre`, `skill/nombre`, `fix/nombre`, etc.)
- Todo lo nuevo debe estar **documentado en lenguaje simple** (sin jerga tecnica)
- Las tools y skills se instalan **globalmente** (funcionan desde cualquier directorio)
- Los PRs tienen **formato estandar** con seccion de "Que", "Por que", "Que cambio", checklist
- Ningun path esta hardcodeado a un usuario especifico (usa `$HOME`)
- Se hacen **backups** de configs existentes antes de sobreescribir

Todo esto esta detallado en [`CONTRIBUTING.md`](CONTRIBUTING.md) y en la Parte 3 del [`CLAUDE.md`](CLAUDE.md).

<p align="right"><a href="#readme-top">volver arriba</a></p>

---

## Donde esta cada cosa despues de instalar

```
~/.config/ghostty/config     ← Config del terminal (tema, atajos, transparencia)
~/.tmux.conf                 ← Config de tmux (tema, plugins, bindings de Claude)
~/claude-launcher.sh         ← Script que ejecutan cc, ccnew, ccresume, ccpick
~/.claude/rules/             ← Reglas globales (TDD, seguridad, estilo, etc.)
~/.claude/settings.json      ← Settings de Claude Code (agent teams, permisos)
~/.tmux/plugins/             ← Plugins de tmux (yank, mouse, resurrect, etc.)
~/claude-tools/              ← Herramientas multi-agente y repos de referencia
```

<p align="right"><a href="#readme-top">volver arriba</a></p>

---

## Personalizacion

<details>
<summary><strong>Cambiar el tema de tmux</strong></summary>

Edita `~/.tmux.conf`. Los colores actuales son Tokyo Night:
- Fondo: `#1a1b26`
- Texto: `#a9b1d6`
- Acento: `#7aa2f7`

</details>

<details>
<summary><strong>Cambiar el tema de Ghostty</strong></summary>

Edita `~/.config/ghostty/config` y cambia la linea:
```
theme = catppuccin-mocha
```
Para ver todos los temas disponibles: `ghostty +list-themes`

</details>

<details>
<summary><strong>Agregar reglas propias para Claude Code</strong></summary>

Crea archivos `.md` en `~/.claude/rules/common/` para reglas globales, o en `/python/` y `/typescript/` para reglas por lenguaje.

</details>

<details>
<summary><strong>Desactivar bypass de permisos</strong></summary>

Edita `~/claude-launcher.sh` y sacale `--dangerously-skip-permissions` a la variable `CLAUDE`. Tambien sacalo de las lineas `bind n` y `bind N` en `~/.tmux.conf`.

</details>

<p align="right"><a href="#readme-top">volver arriba</a></p>

---

## Documentacion completa

| Documento | Que tiene |
|:----------|:---------|
| [Agent Teams + Worktrees](docs/agent-teams-guide.md) | Guia completa del trabajo paralelo automatico |
| [Guia de Tools (No-Tech)](docs/tools-guide.md) | Cada herramienta explicada con analogias de la vida real |
| [Guia de Uso](docs/usage-guide.md) | Instrucciones detalladas de como usar todo |
| [Referencia de Atajos](docs/keybindings-reference.md) | Tabla completa de todos los atajos de teclado |
| [Herramientas Multi-Agente](docs/multi-agent-tools.md) | Guia tecnica de las herramientas de orquestacion |
| [Troubleshooting](docs/troubleshooting.md) | Problemas comunes y como resolverlos |
| [Como Contribuir](CONTRIBUTING.md) | Reglas para agregar cosas nuevas al repo |

---

## Desinstalar

<details>
<summary><strong>Click para ver los comandos de desinstalacion</strong></summary>

```bash
tmux kill-server                    # Matar tmux
rm -f ~/.tmux.conf                  # Borrar config tmux
rm -rf ~/.tmux/                     # Borrar plugins tmux
rm -f ~/claude-launcher.sh          # Borrar launcher
rm -rf ~/.claude/rules/             # Borrar reglas
rm -f ~/.claude/settings.json       # Borrar settings
rm -rf ~/claude-tools/              # Borrar herramientas

# Editar ~/.zshrc y borrar el bloque "Claude Code Power Setup"
# Restaurar config de Ghostty desde backup:
# ls ~/.config/ghostty/config.backup.*
# cp ~/.config/ghostty/config.backup.<timestamp> ~/.config/ghostty/config
```

</details>

---

## Nota sobre los archivos de este repo

> [!NOTE]
> La mayoria de los archivos aca **no son para que los leas vos**. Son instrucciones que lee Claude Code para saber como instalar, configurar y contribuir automaticamente.

| Archivo | Quien lo lee | Para que |
|:--------|:-------------|:---------|
| `CLAUDE.md` | Claude Code | Saber como instalar todo y como hacer PRs |
| `CONTRIBUTING.md` | Claude Code + humanos | Reglas de contribucion y formato de PRs |
| `install.sh` | Claude Code (o vos) | Ejecutar la instalacion completa |
| `scripts/*.sh` | Claude Code (o vos) | Scripts individuales de instalacion |
| `configs/*` | Los scripts de instalacion | Archivos de config que se copian a tu sistema |
| `.github/pull_request_template.md` | GitHub | Template automatico cuando se crea un PR |
| `README.md` | Vos | Este archivo. La explicacion general de todo |
| `docs/*` | Vos | Guias de uso y referencia |

---

<div align="center">

**MIT License**

Hecho con Claude Code y mucho cafe.

</div>
