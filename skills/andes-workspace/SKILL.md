---
name: andes-workspace
description: >-
  Orientación al trabajar en el meta-repo andes/agent: rutas bajo repos/,
  manifiesto repos.yaml, scripts bin/init sync status, y AGENTS.md.
---

# Skill — workspace ANDES

1. Confirmar que el usuario abrió el IDE en la **raíz del clone de andes/agent**.
2. Resolver rutas de código con `repos/<nombre>/` según `repos.yaml`.
3. Leer `AGENTS.md` antes de cambios que crucen API, app o microservicios.
4. Si falta un clone: `./bin/init`.
5. Estado global: `./bin/status`; actualizar: `./bin/sync` (no pisa cambios locales).
6. Reglas: `rules/andes.md`.