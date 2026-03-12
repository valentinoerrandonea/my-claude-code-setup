# Guia de Herramientas - Explicada Simple

Esta guia explica cada herramienta que se instala, para que sirve, y como usarla. Esta pensada para gente que no es tecnica y quiere entender que hace cada cosa.

---

## Lo Basico: Que es Claude Code?

Claude Code es un asistente de inteligencia artificial que vive en tu terminal (esa pantalla negra donde se escriben comandos). Vos le hablas en lenguaje natural y el:

- Escribe codigo por vos
- Modifica archivos
- Corre comandos
- Busca errores y los arregla
- Lee tu proyecto entero y lo entiende

**Ejemplo:** Le decis "crea una pagina de login con email y password" y el la crea entera: archivos, estilos, logica, todo.

---

## Ghostty - Tu Terminal

**Que es:** La aplicacion donde corre todo. Es como el "navegador" pero para codigo. En vez de ver paginas web, ves texto y comandos.

**Por que Ghostty y no otra:** Es rapida, bonita, y tiene atajos de teclado que se integran perfecto con el resto del setup.

**Que hace nuestra config:**
- Fondo semi-transparente con blur (se ve lindo)
- Tema oscuro "Catppuccin Mocha" (colores suaves para la vista)
- Terminal dropdown con `` Cmd+` `` (aparece desde arriba como una cortina)
- Atajos para controlar Claude Code sin tocar el mouse

**No tenes que hacer nada con Ghostty**, solo abrirla. Todo lo demas pasa adentro.

---

## tmux - El Multiplicador de Pantallas

**Que es:** Imaginate que tu terminal es una TV. tmux te deja dividir esa TV en varias pantallas mas chiquitas, cada una haciendo algo distinto. Como tener 4 TVs en una.

**Para que lo usamos:** Para tener VARIOS Claude Code trabajando al mismo tiempo. Uno escribe codigo, otro hace tests, otro revisa seguridad. Todos en la misma pantalla.

**Ejemplo visual:**
```
┌─────────────────┬─────────────────┐
│                  │                  │
│   Claude Code    │   Claude Code    │
│   "main"         │   "tests"        │
│   Escribiendo    │   Corriendo      │
│   el login       │   los tests      │
│                  │                  │
├─────────────────┼─────────────────┤
│                  │                  │
│   Claude Code    │   Claude Code    │
│   "docs"         │   "security"     │
│   Actualizando   │   Revisando      │
│   la docu        │   vulnerabilidades│
│                  │                  │
└─────────────────┴─────────────────┘
```

**Como se usa:**
1. Abris Ghostty
2. Escribis `cc` → se abre Claude Code
3. Tocas `Cmd+N` → aparece OTRO Claude Code al lado
4. Tocas `Cmd+N` de nuevo → aparece un tercero
5. Se acomodan solos en grilla

**Como te moves entre ellos:** `Option+Ctrl+flechas` o simplemente clickeas con el mouse.

**Como los renombras:** `Cmd+Ctrl+R` y escribis el nombre (ej: "backend", "frontend").

---

## Los 4 Comandos de Inicio

Estos se escriben en la terminal para arrancar Claude Code:

### `cc` - Abrir / Reconectar

El mas comun. Si ya tenias algo abierto, te reconecta. Si no, crea uno nuevo.

**Cuando usarlo:** Cada vez que abris Ghostty para trabajar.

```
> cc
# Se abre tmux con Claude Code listo para hablarle
```

### `ccnew` - Empezar de Cero

Borra todo lo anterior y arranca limpio. Claude no recuerda nada de la sesion pasada.

**Cuando usarlo:** Empezas un proyecto nuevo o queres borron y cuenta nueva.

```
> ccnew
# Claude Code arranca sin memoria de conversaciones anteriores
```

### `ccresume` - Continuar Donde Dejaste

Abre Claude Code y le dice "segui donde estabamos". Retoma tu ultima conversacion.

**Cuando usarlo:** Cerraste todo ayer y hoy queres seguir con lo mismo.

```
> ccresume
# Claude Code: "Ah si, estabamos trabajando en el login. Sigo?"
```

### `ccpick` - Elegir una Conversacion Pasada

Te muestra una lista de todas tus conversaciones anteriores para que elijas cual retomar.

**Cuando usarlo:** Queres volver a un proyecto especifico de hace dias.

```
> ccpick
# Te aparece una lista:
# 1. Hace 2 horas - Proyecto login
# 2. Ayer - API de pagos
# 3. Hace 3 dias - Landing page
# Elegis cual retomar
```

---

## Las Reglas Globales (everything-claude-code)

**Que son:** Son instrucciones escritas que Claude Code lee SIEMPRE, en cualquier proyecto. Hacen que Claude sea mas inteligente y profesional automaticamente.

**Analogia:** Es como darle a un empleado nuevo un manual de la empresa. No le tenes que explicar cada vez "escribi tests", "no pongas passwords en el codigo" - ya lo sabe.

### Que reglas se instalan:

| Regla | Que le dice a Claude |
|-------|---------------------|
| **coding-style** | "Escribi codigo limpio, archivos chicos, no modifiques datos existentes - crea copias" |
| **testing** | "Siempre escribi tests primero, despues el codigo. Minimo 80% de cobertura" |
| **security** | "Nunca pongas passwords o claves en el codigo. Valida todo lo que entra" |
| **git-workflow** | "Usa mensajes de commit claros: feat: para features, fix: para bugs" |
| **development-workflow** | "Antes de codear, investiga si ya existe algo hecho. Planifica primero" |
| **performance** | "Usa el modelo correcto para cada tarea. No desperdicies recursos" |
| **patterns** | "Usa patrones conocidos como Repository Pattern para acceso a datos" |
| **agents** | "Cuando la tarea es compleja, usa agentes en paralelo" |
| **hooks** | "Usa la lista de tareas para trackear progreso" |

**Ejemplo practico:** Sin reglas, le decis a Claude "hace un login" y te hace algo basico. CON reglas:
- Primero investiga si hay algo hecho que pueda reusar
- Escribe los tests del login
- Despues escribe el login
- Valida que no haya vulnerabilidades
- Hace commit con mensaje "feat: add user login with email/password"

---

## Agent Teams + Worktrees (lo mas importante)

Esta es la feature mas poderosa de todo el setup. Merece su propia seccion.

**Que es:** La capacidad de que UN solo Claude cree automaticamente VARIOS Claudes, les reparta tareas, y cada uno trabaje en su propia copia aislada del proyecto sin pisarse.

**Analogia:** Sos el dueño de una empresa. Tenes un gerente general (Claude lider) al que le decis "necesito que se hagan estas 3 cosas". El gerente llama a 3 empleados, le da a cada uno su tarea y su propia oficina (worktree), y cuando terminan el gerente junta todo en un solo entregable.

**Como se usa:** Le hablas a UN solo Claude Code y le decis algo como:

```
"Quiero que hagas la API de login, los tests, y la documentacion.
Hacelo en paralelo con worktrees."
```

Claude automaticamente:
1. Crea 3 agentes
2. Cada uno trabaja en su propia copia del proyecto (worktree)
3. No se pueden pisar entre ellos
4. Cuando terminan, Claude mergea todo
5. Te da el resultado final

**Requisito:** Tu carpeta de proyecto tiene que ser un repositorio de Git. Si no lo es, simplemente corres `git init` y listo. No necesitas GitHub ni internet.

**Para la guia completa con ejemplos:** Lee [Agent Teams + Worktrees Guide](agent-teams-guide.md)

---

## Agentes Personalizados (tus especialistas reutilizables)

**Que es:** Son "manuales de procedimiento" que le das a Claude Code para tareas especificas. Cuando Claude detecta que la tarea encaja con un agente, lo activa automaticamente y sigue las instrucciones al pie de la letra.

**Analogia:** Imaginate que tenes una cadena de restaurantes. En vez de explicarle a cada cocinero nuevo como hacer la pizza, le das una receta escrita con pasos exactos: ingredientes, tiempos, temperatura. El agente es esa receta: instrucciones fijas que se aplican siempre que se necesite esa tarea.

**Ejemplo concreto:** Sin agente, le decis "revisame el codigo" y Claude revisa lo que le parece. CON el agente `code-reviewer`, Claude sigue un checklist de 8 puntos (legibilidad, manejo de errores, seguridad, etc.), clasifica cada hallazgo por severidad (CRITICAL/HIGH/MEDIUM/LOW), y te da un reporte consistente. Siempre igual, siempre completo.

**Cuando usarlo:** Cada vez que tengas una tarea que haces seguido y queres que siempre se haga de la misma manera profesional:
- Code review → agente `code-reviewer`
- Auditoria de seguridad → agente `security-reviewer`
- Escribir tests → agente `tdd-guide`
- Planificar una feature → agente `planner`

**Donde estan:** `~/.claude/agents/` (se instalan automaticamente con este setup)

**Como crear uno nuevo:** Pedile a Claude Code: "Creame un agente que haga [tarea]. Guardalo en `~/.claude/agents/`"

**Para la guia completa:** Lee [Agentes Personalizados - Guia Completa](custom-agents-guide.md)

---

## Herramientas Multi-Agente (externas)

Estas son herramientas de terceros mas avanzadas para cuando queres que multiples Claudes trabajen de manera coordinada automaticamente (no manual con tmux panels).

### Claude Swarm

**Que es:** Un director de orquesta para agentes de IA.

**Analogia:** Imaginate que tenes un equipo de trabajo. El director (Swarm) le dice a cada uno que hacer, como comunicarse entre ellos, y coordina todo.

**Como funciona:** Escribis un archivo que describe tu "equipo":

```
Equipo "e-commerce":
  - Arquitecto: diseña la estructura general
  - Backend: hace la API y base de datos
  - Frontend: hace la interfaz visual
  - Tester: prueba que todo funcione
```

Swarm crea un Claude para cada rol y los pone a trabajar juntos.

**Cuando usarlo:** Proyectos grandes donde necesitas varios especialistas trabajando coordinados. Por ejemplo: construir una app entera de cero.

**Donde esta:** `~/claude-tools/claude-swarm`

---

### Zerg

**Que es:** Un lanzador masivo de agentes.

**Analogia:** Si Claude Swarm es un director de orquesta (ordenado, roles definidos), Zerg es mas como un general que manda muchos soldados a resolver un problema. Rapido y en masa.

**Como funciona:** Le decis "necesito 5 agentes trabajando en esto" y Zerg los crea, les da la tarea, y junta los resultados.

**Cuando usarlo:** Cuando tenes muchas tareas independientes que se pueden hacer en paralelo. Por ejemplo: "Revisame estos 10 archivos en busca de bugs" - Zerg manda un agente por archivo.

**Donde esta:** `~/claude-tools/zerg`

---

### Overstory

**Que es:** Un panel de control visual para ver que estan haciendo tus agentes.

**Analogia:** Es como el panel de control de un aeropuerto. Cada avion (agente) aparece en la pantalla con su estado: "despegando", "en vuelo", "aterrizado". Asi ves en tiempo real que esta haciendo cada Claude.

**Como funciona:** Abre una pagina web en tu navegador donde podes ver:
- Cuantos agentes estan activos
- Que esta haciendo cada uno
- Si alguno tiene un error
- El progreso general

**Cuando usarlo:** Cuando tenes varios agentes corriendo y queres monitorear sin ir panel por panel.

**Donde esta:** `~/claude-tools/overstory`

**Como abrirlo:**
```
cd ~/claude-tools/overstory
bun run dev
# Abre la URL que te muestra en el navegador
```

---

### ccswarm

**Que es:** Un coordinador de Claude Codes hecho para ser ultra rapido.

**Analogia:** Mismo concepto que Claude Swarm, pero hecho en Rust (un lenguaje de programacion muy rapido). Es como cambiar el motor de un auto por uno de competicion.

**Cuando usarlo:** Cuando trabajas con muchos agentes y necesitas que la coordinacion sea lo mas rapida posible.

**Donde esta:** `~/claude-tools/ccswarm`

---

### Ruflo

**Que es:** Un automatizador de flujos de trabajo.

**Analogia:** Imaginate una linea de produccion en una fabrica. Paso 1: diseñar. Paso 2: construir. Paso 3: probar. Paso 4: empaquetar. Ruflo define esos pasos y los ejecuta en orden, usando Claude Code en cada paso.

**Como funciona:** Definir un "workflow" (flujo de trabajo):

```
Workflow "deploy mi app":
  Paso 1: Correr todos los tests
  Paso 2: Si pasan, construir la app
  Paso 3: Si construye bien, subir a produccion
  Paso 4: Notificar al equipo
```

Ruflo ejecuta cada paso automaticamente. Si uno falla, se detiene y te avisa.

**Cuando usarlo:** Tareas repetitivas que siempre siguen los mismos pasos. Deploy, releases, CI/CD.

**Donde esta:** Instalado globalmente (se ejecuta con `ruflo` desde cualquier directorio)

---

## Repos de Referencia

Estos no son herramientas que se "ejecutan". Son repositorios con informacion, ejemplos y listas de recursos.

### awesome-claude-code

**Que es:** Una lista curada de tips, trucos, herramientas y recursos para Claude Code. Mantenida por la comunidad.

**Para que sirve:** Cuando queres saber "que mas puedo hacer con Claude Code?", abris esto y te inspiras.

**Donde esta:** `~/claude-tools/awesome-claude-code`

### agents-reference

**Que es:** Ejemplos de como crear agentes personalizados para Claude Code.

**Para que sirve:** Cuando queres crear tu propio agente especializado (por ejemplo: un agente que solo haga reviews de seguridad).

**Donde esta:** `~/claude-tools/agents-reference`

### mcp-servers (MCP = Model Context Protocol)

**Que es:** Servidores oficiales de Anthropic que le dan a Claude Code la capacidad de conectarse con herramientas externas: bases de datos, APIs, servicios web, etc.

**Analogia:** Si Claude Code es un empleado, los MCP servers son como darle acceso a mas herramientas: una calculadora, un buscador web, acceso a una base de datos.

**Donde esta:** `~/claude-tools/mcp-servers`

### awesome-mcp-servers

**Que es:** Lista de MCP servers creados por la comunidad. Hay de todo: para Google Drive, Slack, GitHub, bases de datos, y mas.

**Para que sirve:** Cuando queres que Claude Code se conecte con algun servicio externo, buscas aca si alguien ya hizo el conector.

**Donde esta:** `~/claude-tools/awesome-mcp-servers`

---

## tmux Plugins (se instalan automaticamente)

Estos son "mejoras" para tmux que se instalan solos. No tenes que hacer nada.

| Plugin | Que hace | Ejemplo |
|--------|----------|---------|
| **tmux-yank** | Copiar texto con el mouse se copia al clipboard | Seleccionas texto → ya esta copiado, podes pegar con Cmd+V |
| **tmux-better-mouse-mode** | Scroll con el mouse funciona en todos lados | Podes scrollear para ver output anterior |
| **tmux-resurrect** | Guarda tu sesion de tmux | Si se reinicia la compu, podes restaurar tus paneles |
| **tmux-continuum** | Guarda automaticamente cada 15 min | No perdes nada si algo falla |
| **tmux-sensible** | Configuraciones logicas por defecto | Todo funciona mejor out-of-the-box |
| **tmux-open** | Abrir URLs y archivos desde tmux | Ves una URL en el output? Click y la abre en el navegador |

---

## Resumen: Cuando Usar Que

| Situacion | Que usar | Dificultad |
|-----------|----------|------------|
| Trabajo normal del dia a dia | Un solo Claude (`cc`) | Facil |
| Quiero 2-3 Claudes que vea en pantalla | Paneles tmux (`Cmd+N`) | Facil |
| **Tarea repetitiva con pasos fijos** | **Agente personalizado** | **Facil (se activa solo)** |
| **Tareas paralelas que se pueden pisar** | **Agent Teams + Worktrees** | **Facil (le decis y listo)** |
| **Proyecto grande con muchas partes** | **Agent Teams + Worktrees** | **Facil (le decis y listo)** |
| **Comparar enfoques distintos** | **Agent Teams + Worktrees** | **Facil (le decis y listo)** |
| Quiero un equipo con roles definidos en YAML | Claude Swarm | Intermedio |
| Quiero muchos agentes en masa | Zerg | Intermedio |
| Quiero ver agentes en un dashboard | Overstory | Intermedio |
| Quiero automatizar pasos repetitivos | Ruflo | Intermedio |
| Quiero maximo rendimiento en coordinacion | ccswarm | Avanzado |
| Quiero conectar Claude con servicios externos | MCP Servers | Intermedio |
| Quiero aprender mas trucos | awesome-claude-code | - |

**Recomendacion:** Para la mayoria de la gente, **agentes personalizados + Agent Teams + Worktrees** es todo lo que necesitas. Los agentes te dan consistencia en tareas repetitivas, y los Agent Teams te dan velocidad en tareas grandes. Las herramientas externas (Swarm, Zerg, etc.) son para casos mas especificos.
