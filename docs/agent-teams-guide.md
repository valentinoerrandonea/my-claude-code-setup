# Agent Teams + Worktrees: Multiples Claudes Trabajando Juntos

## La idea en 30 segundos

Le hablas a UN solo Claude Code. Le decis algo como:

> "Necesito que hagas la API de usuarios, los tests, y la documentacion. Hacelo en paralelo."

Ese Claude (el **lider**) crea automaticamente otros Claudes (los **agentes**), le da a cada uno su tarea, cada uno trabaja en su propia copia aislada del proyecto, y cuando terminan el lider junta todo.

Vos hablas con uno solo. El hace el resto.

---

## Como funciona (sin tecnicismos)

Imaginate que sos el jefe de una oficina. Tenes un proyecto grande y necesitas que se hagan 3 cosas al mismo tiempo.

**Sin Agent Teams:**
Vos tenes un solo empleado (Claude). Le decis "hace A", esperas, "hace B", esperas, "hace C". Todo secuencial. Lento.

**Con Agent Teams:**
Vos le decis a tu empleado principal (el lider): "Necesito que se hagan A, B y C al mismo tiempo". El lider llama a 3 compañeros, le da a cada uno una tarea, y los 3 trabajan en simultaneo. Cuando terminan, el lider junta todo y te entrega el resultado.

### Y los Worktrees?

El problema de que 3 personas trabajen al mismo tiempo en el mismo proyecto es que se pueden pisar. Uno modifica un archivo, el otro lo modifica tambien, y se rompe.

Los **worktrees** resuelven esto. Cada agente trabaja en su **propia copia del proyecto**. Es como si cada empleado tuviera su propia copia del documento en su escritorio. Cuando terminan, el lider junta las copias en una sola version final.

```
Tu proyecto (original)
    │
    ├── Copia 1 → Agente "backend"  → trabaja aca, aislado
    ├── Copia 2 → Agente "tests"    → trabaja aca, aislado
    └── Copia 3 → Agente "docs"     → trabaja aca, aislado

Cuando terminan → el lider mergea todo en el original
```

**No necesitas GitHub.** Solo necesitas que tu carpeta sea un repositorio de Git (`git init`). Todo pasa en tu computadora.

---

## Como usarlo

### Paso 1: Tu proyecto tiene que ser un repo de Git

Si tu proyecto ya tiene Git, salteate esto. Si no:

```bash
cd tu-proyecto
git init
git add -A
git commit -m "initial commit"
```

### Paso 2: Abri Claude Code

```bash
cc
```

### Paso 3: Pedile que trabaje en paralelo

Ejemplos de cosas que podes decir:

> "Quiero que hagas estas 3 cosas en paralelo usando worktrees:
> 1. Implementar la API de login
> 2. Escribir los tests para la API
> 3. Actualizar el README con la documentacion"

> "Dividi este refactor en partes y hacelo en paralelo con agentes separados"

> "Necesito que revises la seguridad, el performance, y la calidad del codigo al mismo tiempo"

Claude va a:
1. Crear un equipo de agentes
2. Asignar cada tarea a un agente
3. Cada agente trabaja en su propio worktree (copia aislada)
4. Cuando terminan, Claude mergea los cambios
5. Si hay conflictos, los resuelve
6. Te muestra el resultado final

### Paso 4: Esperar y revisar

Mientras los agentes trabajan, el lider te va contando que esta pasando:

```
Lider: "Cree 3 agentes. El de backend esta implementando los endpoints,
        el de tests esta escribiendo los test cases, el de docs esta
        actualizando el README. Te aviso cuando terminen."

... (pasan unos minutos) ...

Lider: "El agente de docs termino. El de tests termino. El de backend
        esta terminando... Listo. Mergee todo. Cero conflictos.
        Aca tenes el resumen de lo que se hizo."
```

---

## Que pasa por detras (para los curiosos)

No necesitas saber esto para usarlo, pero si te interesa:

1. **El lider** es el Claude Code al que vos le hablas
2. Cuando le pedis trabajo paralelo, el usa una herramienta interna llamada `Agent` con la opcion `isolation: "worktree"`
3. Eso crea un **git worktree**: una carpeta nueva que es una copia del repo pero en su propio branch
4. Cada agente trabaja en su worktree, en su branch: `agent-backend`, `agent-tests`, `agent-docs`
5. Cuando terminan, el lider hace `git merge` de cada branch al branch principal
6. Si dos agentes tocaron el mismo archivo, Git detecta el conflicto y el lider lo resuelve
7. Los worktrees temporales se limpian automaticamente

### Donde se crean los worktrees?

Dentro de tu proyecto, en una carpeta oculta:

```
tu-proyecto/
├── .claude/worktrees/
│   ├── agent-backend/    ← copia aislada para el agente backend
│   ├── agent-tests/      ← copia aislada para el agente tests
│   └── agent-docs/       ← copia aislada para el agente docs
├── src/
├── package.json
└── ...
```

Cuando terminan, las carpetas de worktrees se borran solas.

---

## Ejemplos concretos

### Ejemplo 1: Feature nueva con tests y docs

Lo que le decis a Claude:

> "Implementa un sistema de notificaciones por email. Quiero que en paralelo:
> 1. Un agente haga el backend (servicio de email, templates, queue)
> 2. Un agente haga los tests (unitarios e integracion)
> 3. Un agente actualice la documentacion
> Usa worktrees para que no se pisen."

### Ejemplo 2: Code review multiple

> "Revisame este proyecto en paralelo:
> 1. Un agente que revise seguridad (vulnerabilidades, secrets expuestos)
> 2. Un agente que revise performance (queries lentos, memory leaks)
> 3. Un agente que revise calidad de codigo (naming, estructura, patterns)
> Dame un reporte consolidado al final."

### Ejemplo 3: Refactor grande

> "Necesito refactorear el modulo de pagos. Dividilo en partes logicas
> y hacelo en paralelo con worktrees. Asegurate de que los tests sigan pasando."

### Ejemplo 4: Prototipo rapido

> "Haceme 3 versiones distintas de la landing page en paralelo usando worktrees.
> Una minimalista, una con muchas animaciones, y una corporativa.
> Despues comparalas y decime cual es mejor."

---

## Paneles tmux vs Agent Teams: Cuando usar cual

| Situacion | Que usar | Por que |
|-----------|----------|---------|
| Tareas simples del dia a dia | Un solo Claude (`cc`) | No necesitas mas |
| 2-3 tareas que queres ver en pantalla | Paneles tmux (`Cmd+N`) | Ves todo, control manual |
| Tareas paralelas que se pueden pisar | **Agent Teams + Worktrees** | Aislamiento automatico |
| Proyecto grande con muchas partes | **Agent Teams + Worktrees** | El lider coordina todo |
| Queres comparar enfoques distintos | **Agent Teams + Worktrees** | Cada agente prueba un approach |
| Queres monitorear agentes visualmente | Paneles tmux + Overstory | Lo mejor de ambos mundos |

### Se pueden combinar?

Si. Podes tener:
- **Panel 1**: Claude lider orquestando Agent Teams con worktrees
- **Panel 2**: Otro Claude haciendo algo completamente distinto
- **Panel 3**: Overstory mostrando el dashboard de agentes

Cada panel de tmux es independiente. Agent Teams corre dentro de UN panel.

---

## Preguntas frecuentes

### Necesito GitHub para esto?

**No.** Solo necesitas Git local (`git init`). Todo pasa en tu computadora.

### Cuantos agentes puedo crear?

No hay un limite estricto, pero en la practica 3-5 agentes es lo optimo. Mas de eso y tu computadora se va a poner lenta (cada agente consume CPU y memoria).

### Que pasa si dos agentes tocan el mismo archivo?

El lider detecta el conflicto de merge y lo resuelve. Git le muestra las diferencias y el lider decide cual version mantener o como combinarlas.

### Puedo hacer algo mientras los agentes trabajan?

Si. Podes abrir otro panel tmux (`Cmd+N`) y trabajar en otra cosa. Los agentes corren en background.

### Cuanto tardan?

Depende de la tarea. Tareas simples (docs, tests unitarios) tardan 1-3 minutos. Tareas complejas (implementar features enteras) pueden tardar 5-15 minutos.

### Esto consume mas de mi cuenta de Claude?

Si. Cada agente es una sesion independiente de Claude Code. 3 agentes = 3x el consumo. Tenelo en cuenta si tenes un plan con limites.

### Los worktrees ocupan mucho espacio en disco?

No mucho. Git es inteligente: los worktrees comparten la mayor parte de los datos con el repo original. Solo los archivos que cambian se duplican.
