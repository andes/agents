<<<<<<< HEAD
# agents

Meta-repo [`andes/agents`](https://github.com/andes/agents) — punto de entrada para desarrollar ANDES con agentes de código. No es un monorepo git: este repositorio trae **manifiesto, documentación compartida y scripts**, y clona el resto de los repos de ANDES en `repos/` (ignorados por git).

## Requisitos

- `git`
- `ruby` (stdlib, para leer `repos.yaml`)
- Acceso SSH a GitHub (`git@github.com`) para repos de la org `andes` y otros remotos del manifiesto

## Quickstart

```bash
git clone git@github.com:andes/agents.git
cd agents
./bin/init          # clona los repos según repos.yaml
./bin/doctor        # chequeos opcionales
```

Abrí **Cursor / Claude Code / Codex** en la raíz del clone de `andes/agents`, no dentro de un sub-repo suelto. Así el agente ve `AGENTS.md`, `rules/`, `skills/` y todo el código bajo `repos/`.

## Scripts

| Comando | Descripción |
| --------| -------------|
| `./bin/init` | Clona lo que falte; enlaza reglas/skills para agentes |
| `./bin/sync` | `git fetch` y `pull --ff-only` en cada repo (no pisa cambios locales) |
| `./bin/status` | Rama y estado dirty/clean de cada clone |
| `./bin/doctor` | Git, SSH, conteo de clones, herramientas opcionales |
| `./bin/link-agent-assets` | Regenera symlinks `.cursor/rules`, `.claude/skills`, `CLAUDE.md` |

## Agregar un repositorio

1. Editar `repos.yaml` (nueva entrada con `name`, `url`, `branch`, `path`, `description`).
2. Ejecutar `./bin/init`.
3. Actualizar `AGENTS.md` si el repo cambia el mapa del sistema.

## Conocimiento compartido

| Carpeta | Uso |
| --------|-----|
| `docs/` | Documentación humana / referencia |
| `rules/` | Reglas para agentes (fuente canónica) |
| `prompts/` | Plantillas de prompts reutilizables |
| `skills/` | Skills compartidos (Claude / compatibles) |
| `AGENTS.md` | Mapa del ecosistema (Codex, T3, otros) |

`./bin/init` enlaza `rules/` → `.cursor/rules/` y `skills/` → `.claude/skills/`.

## Seguridad

- No commitear secretos ni `config.private.ts`.
- Los clones en `repos/` pueden contener datos sensibles en entornos locales; no subirlos a este repo.
