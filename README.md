# Claude Code Power Setup

Un setup completo para usar Claude Code como un profesional. Multiples agentes de IA trabajando en paralelo, en una grilla dentro de tu terminal, con un solo atajo de teclado.

---

## Que es esto?

Este repositorio es un **kit de instalacion automatica** que configura tu computadora para trabajar con Claude Code de la manera mas productiva posible.

En vez de tener un solo Claude Code abierto, este setup te permite:

- Tener **varios Claude Code al mismo tiempo** en una grilla (uno escribe codigo, otro hace tests, otro revisa seguridad)
- Abrir nuevos agentes con **un solo atajo de teclado** (`Cmd+N`)
- Moverte entre ellos con **las flechas del teclado**
- Ponerle **nombres** a cada panel para saber que esta haciendo cada uno
- Tener **reglas globales** que hacen que Claude escriba mejor codigo automaticamente
- Acceder a **herramientas avanzadas** de orquestacion multi-agente

Todo se instala y configura automaticamente. Vos no tenes que tocar nada.

### Como funciona?

La mayoria de los archivos de este repositorio son **instrucciones que lee Claude Code**, no vos. Cuando le decis a tu Claude Code "instala esto", el lee los archivos `CLAUDE.md` y `CONTRIBUTING.md`, entiende que tiene que hacer, y lo hace solo.

Vos solo le das la orden. El hace el resto.

---

## Que necesitas antes de empezar

| Requisito | Donde conseguirlo |
|-----------|-------------------|
| **macOS** o **Linux** | Ya lo tenes |
| **Git** | macOS: viene instalado. Linux: `sudo apt install git` |
| **Homebrew** (solo macOS) | [brew.sh](https://brew.sh) |
| **Node.js** o **Bun** | [nodejs.org](https://nodejs.org) o [bun.sh](https://bun.sh) |
| **Ghostty** (terminal) | [ghostty.org](https://ghostty.org) |
| **Cuenta de Claude** | Pro, Max, Teams o Enterprise en [claude.ai](https://claude.ai) |
| **Claude Code** instalado | Se instala automaticamente, pero si lo queres hacer manual: `npm install -g @anthropic-ai/claude-code` |

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

---

## Como se usa

### Los 4 comandos para arrancar

Escribilos en tu terminal (Ghostty):

| Comando | Que hace |
|---------|----------|
| `cc` | Abre Claude Code. Si ya habia una sesion, te reconecta |
| `ccnew` | Borra todo y arranca un Claude Code nuevo de cero |
| `ccresume` | Abre Claude Code y continua tu ultima conversacion |
| `ccpick` | Te muestra una lista de conversaciones pasadas para elegir |

### Atajos de teclado (dentro de Ghostty + tmux)

#### Crear y manejar paneles

| Atajo | Que hace |
|-------|----------|
| `Cmd+N` | Abre un nuevo Claude Code al lado (se acomodan solos en grilla) |
| `Cmd+Shift+N` | Abre un nuevo Claude Code abajo |
| `Cmd+Ctrl+R` | Renombra el panel actual (ej: "backend", "tests") |
| `Cmd+Shift+=` | Redistribuye todos los paneles en partes iguales |

#### Moverse entre paneles

| Atajo | Que hace |
|-------|----------|
| `Option+Ctrl+Flechas` | Salta al panel de la izquierda, derecha, arriba o abajo |
| Click del mouse | Hace foco en el panel que clickeas |
| Scroll del mouse | Scrollea el output del panel |

#### Otros atajos utiles

| Atajo | Que hace |
|-------|----------|
| `Ctrl+A` luego `d` | Desconectar de tmux (la sesion sigue viva en segundo plano) |
| `Ctrl+D` o `exit` | Cerrar el panel actual |
| `` Cmd+` `` | Terminal dropdown rapido (aparece desde arriba) |
| `Cmd+Shift+,` | Recargar config de Ghostty |

### Ejemplo: Trabajar con 3 agentes a la vez

```
1. Abri terminal y escribi: cc
2. Tocas Cmd+N → aparece un segundo Claude Code
3. Tocas Cmd+N → aparece un tercero (grilla de 3)
4. Tocas Cmd+Ctrl+R → escribis "main"
5. Te moves al segundo con Option+Ctrl+Derecha
6. Tocas Cmd+Ctrl+R → escribis "tests"
7. Te moves al tercero
8. Tocas Cmd+Ctrl+R → escribis "docs"
```

Ahora le decis a cada uno que hacer:
- **main**: "Implementa la API de autenticacion"
- **tests**: "Escribi tests de integracion para los endpoints de auth"
- **docs**: "Actualiza la documentacion de la API"

Los tres trabajan al mismo tiempo. Te moves entre ellos para ver como van.

---

## Que se instala exactamente

### Lo esencial

| Componente | Que es | Para que sirve |
|------------|--------|----------------|
| **Claude Code** | Asistente de IA en la terminal | El cerebro de todo. Le hablas y codea por vos |
| **tmux** | Multiplicador de pantallas | Divide tu terminal en multiples paneles |
| **Ghostty config** | Configuracion del terminal | Atajos de teclado, tema visual, transparencia |
| **Launcher script** | Script de arranque | Los comandos `cc`, `ccnew`, `ccresume`, `ccpick` |

### Plugins de tmux (se instalan solos)

| Plugin | Que hace |
|--------|----------|
| **tmux-yank** | Seleccionar texto con mouse = copiado al clipboard |
| **tmux-better-mouse-mode** | Scroll con mouse funciona en todos lados |
| **tmux-resurrect** | Guarda tus paneles y los restaura si se cierra |
| **tmux-continuum** | Auto-guarda cada 15 minutos |
| **tmux-sensible** | Configuraciones logicas por defecto |
| **tmux-open** | Click en URLs para abrirlas en el navegador |

### Reglas globales para Claude Code

Se instalan en `~/.claude/rules/` y hacen que **cualquier Claude Code en cualquier proyecto** sea mas inteligente:

| Regla | Que le dice a Claude |
|-------|---------------------|
| **coding-style** | Codigo limpio, archivos chicos, inmutabilidad |
| **testing** | Escribir tests primero, minimo 80% cobertura |
| **security** | Nunca poner passwords en el codigo, validar todo |
| **git-workflow** | Commits con formato claro (`feat:`, `fix:`, etc.) |
| **development-workflow** | Investigar antes de codear, planificar primero |
| **performance** | Usar el modelo correcto para cada tarea |
| **agents** | Usar multiples agentes en paralelo cuando corresponde |

### Herramientas multi-agente

Herramientas avanzadas para orquestar muchos Claudes automaticamente:

| Herramienta | Que es en simple | Lenguaje |
|-------------|-----------------|----------|
| [Claude Swarm](https://github.com/claudio-silva/claude-swarm) | Director de orquesta: define roles y los coordina | Python |
| [Zerg](https://github.com/codeium/zerg) | General de ejercito: manda muchos agentes en paralelo | Python |
| [Overstory](https://github.com/overtone-app/overstory) | Panel de control: ves que hace cada agente en un dashboard | Bun/Node |
| [ccswarm](https://github.com/deansher/ccswarm) | Coordinador ultra-rapido hecho en Rust | Rust |
| [Ruflo](https://github.com/ruflo/ruflo) | Linea de produccion: automatiza pasos en secuencia | Node.js |

### Repos de referencia

| Repo | Que tiene |
|------|----------|
| [awesome-claude-code](https://github.com/anthropics/awesome-claude-code) | Lista curada de tips, trucos y recursos |
| [agents](https://github.com/wshobson/agents) | Ejemplos de agentes personalizados |
| [claude-code-mcp-servers](https://github.com/anthropics/claude-code-mcp-servers) | Conectores oficiales (bases de datos, APIs, etc.) |
| [awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) | Conectores de la comunidad (Google Drive, Slack, etc.) |

---

## Cosas que podes pedirle a Claude Code

Este setup esta pensado para que vos le hables a Claude Code y el haga las cosas. Aca van ejemplos concretos de cosas que podes pedirle:

### Instalar algo nuevo

> "Instala la herramienta X y configurala globalmente"

Claude Code va a:
1. Crear un branch nuevo
2. Instalar la herramienta
3. Agregar un script de instalacion
4. Documentar todo
5. Crear un PR para que vos lo apruebes

### Mejorar algo existente

> "Mejora la config de tmux para que tenga mejor soporte de colores"

Claude Code modifica lo necesario, actualiza la documentacion y crea un PR.

### Agregar una skill o regla nueva

> "Agrega una skill que revise la accesibilidad del codigo"

Claude Code la crea, la configura globalmente (para que funcione en cualquier proyecto), la documenta, y crea un PR.

### Arreglar algo roto

> "El comando ccresume no funciona, arreglalo"

Claude Code diagnostica el problema, lo arregla, actualiza troubleshooting si corresponde, y crea un PR.

**IMPORTANTE:** Todos los cambios se hacen en un branch nuevo y generan un PR. Nada se mergea a `main` sin tu aprobacion.

---

## Como contribuir (vos o tus amigos)

Este repo esta vivo. Crece cada vez que alguien agrega algo nuevo.

### El flujo es asi:

1. **Decile a tu Claude Code que hacer** (ej: "agrega tal herramienta")
2. Claude Code lee las reglas del repo (`CLAUDE.md`, `CONTRIBUTING.md`)
3. **Crea un branch nuevo** automaticamente (nunca toca `main` directo)
4. **Hace los cambios**: instala, configura, escribe scripts
5. **Actualiza TODA la documentacion**: guia de tools, README, keybindings, troubleshooting
6. **Crea un Pull Request** con formato estandar
7. **Vos lo revisas** y lo aprobas (o pedis cambios)
8. Se mergea a `main`

### Reglas que sigue Claude Code automaticamente

- Todo cambio va en un **branch nuevo** (`tool/nombre`, `skill/nombre`, `fix/nombre`, etc.)
- Todo lo nuevo debe estar **documentado en lenguaje simple** (sin jerga tecnica)
- Las tools y skills se instalan **globalmente** (funcionan desde cualquier directorio)
- Los PRs tienen **formato estandar** con seccion de "Que", "Por que", "Que cambio", checklist
- Ningun path esta hardcodeado a un usuario especifico (usa `$HOME`)
- Se hacen **backups** de configs existentes antes de sobreescribir

Todo esto esta detallado en [`CONTRIBUTING.md`](CONTRIBUTING.md) y en la Parte 2 del [`CLAUDE.md`](CLAUDE.md).

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

---

## Personalizacion

### Cambiar el tema de tmux

Edita `~/.tmux.conf`. Los colores actuales son Tokyo Night:
- Fondo: `#1a1b26`
- Texto: `#a9b1d6`
- Acento: `#7aa2f7`

### Cambiar el tema de Ghostty

Edita `~/.config/ghostty/config` y cambia la linea:
```
theme = catppuccin-mocha
```
Para ver todos los temas disponibles: `ghostty +list-themes`

### Agregar reglas propias para Claude Code

Crea archivos `.md` en `~/.claude/rules/common/` para reglas globales, o en `/python/` y `/typescript/` para reglas por lenguaje.

### Desactivar bypass de permisos

Edita `~/claude-launcher.sh` y sacale `--dangerously-skip-permissions` a la variable `CLAUDE`. Tambien sacalo de las lineas `bind n` y `bind N` en `~/.tmux.conf`.

---

## Documentacion completa

| Documento | Que tiene |
|-----------|----------|
| [Guia de Tools (No-Tech)](docs/tools-guide.md) | Cada herramienta explicada con analogias de la vida real |
| [Guia de Uso](docs/usage-guide.md) | Instrucciones detalladas de como usar todo |
| [Referencia de Atajos](docs/keybindings-reference.md) | Tabla completa de todos los atajos de teclado |
| [Herramientas Multi-Agente](docs/multi-agent-tools.md) | Guia tecnica de las herramientas de orquestacion |
| [Troubleshooting](docs/troubleshooting.md) | Problemas comunes y como resolverlos |
| [Como Contribuir](CONTRIBUTING.md) | Reglas para agregar cosas nuevas al repo |

---

## Desinstalar

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

---

## Nota sobre los archivos de este repo

La mayoria de los archivos aca **no son para que los leas vos**. Son instrucciones que lee Claude Code para saber como instalar, configurar y contribuir automaticamente:

| Archivo | Quien lo lee | Para que |
|---------|-------------|----------|
| `CLAUDE.md` | Claude Code | Saber como instalar todo y como hacer PRs |
| `CONTRIBUTING.md` | Claude Code + humanos | Reglas de contribucion y formato de PRs |
| `install.sh` | Claude Code (o vos) | Ejecutar la instalacion completa |
| `scripts/*.sh` | Claude Code (o vos) | Scripts individuales de instalacion |
| `configs/*` | Los scripts de instalacion | Archivos de config que se copian a tu sistema |
| `.github/pull_request_template.md` | GitHub | Template automatico cuando se crea un PR |
| `README.md` | Vos | Este archivo. La explicacion general de todo |
| `docs/*` | Vos | Guias de uso y referencia |

---

## License

MIT
