# Reglas ANDES (agentes)

Aplican al trabajar desde la raíz del meta-repo `andes/agent`.

## Alcance

- Leer y editar código bajo `repos/` según la tarea del usuario.
- Preferir cambios mínimos y alineados con el estilo del repo afectado.
- Consultar `AGENTS.md` para entender dependencias entre repos.

## Prohibido sin pedido explícito

- Push o cambios en remotos distintos al que el usuario indicó.
- Commits masivos que mezclen varios repos en un solo mensaje confuso.
- Subir secretos, `.env`, `config.private.ts`, dumps de Mongo, o datos de pacientes.
- Instalar dependencias globales sin necesidad.

## Datos sensibles

ANDES es un sistema de salud. Tratar cualquier dato clínico o credencial como confidencial. Usar solo fixtures anonimizados o entornos locales documentados.

## Multi-repo

- Rutas: `repos/<name>/...` (ver `repos.yaml`).
- Si un cambio requiere otro repo (ej. API + app), enumerar ambos y el orden de despliegue/prueba.
- Si falta un repo en el workspace, sugerir `./bin/init` o ampliar `repos.yaml`.

## Pruebas

Seguir scripts de test del repo tocado (`npm test`, `ng test`, etc.). Si no hay tests, describir verificación manual acorde al README.