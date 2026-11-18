# ANDES — mapa para agentes

Este archivo es la fuente de verdad para **contexto de producto** al trabajar desde el meta-repo [`andes/agents`](https://github.com/andes/agents). El código vive en `repos/*` (clones locales). **No modificar otros repos remotos** salvo que el usuario lo pida explícitamente.

## Qué es ANDES

ANDES es la plataforma de Historia Clínica Electrónica y gestión sanitaria desarrollada por **Red TICs** (Ministerio de Salud de Neuquén, Argentina). El ecosistema está repartido en muchos repositorios GitHub; `andes/agents` los agrupa para desarrollo y asistencia con IA.

**TODO:** Enlace oficial a documentación institucional / wiki si existe fuera de estos repos.

## Arquitectura (vista rápida)

```text
                    ┌─────────────────┐
                    │  repos/app      │  Angular (HCE web)
                    │  @andes/plex    │
                    │  @andes/shared  │
                    │  @andes/auth    │
                    └────────┬────────┘
                             │ HTTP / APIs
                    ┌────────▼────────┐
                    │  repos/api      │  Node/Express, MongoDB
                    │  @andes/* npm   │◄── repos/andes-api-tools (Lerna)
                    └────────┬────────┘
         ┌───────────────────┼───────────────────┐
         ▼                   ▼                   ▼
 repos/andesMicroservices   repos/fhir      repos/andes-fhir-server
 (integraciones, CDA, SMS…)  (@andes/fhir)   (servidor FHIR R4)
```

### Núcleo

| Repo (`repos/…`) | Rol |
| ------------------|-----|
| `api` | API principal ANDES. Publica paquetes consumidos vía `@andes/*`. Entorno dev con Docker documentado en su README (`npm run docker:up`, `docker:seed`). |
| `app` | Frontend Angular principal. Depende de `@andes/plex`, `@andes/shared`, etc. |
| `auth` | Módulo Angular de autenticación/autorización (`@andes/auth`). |
| `shared` | Código compartido frontend (`@andes/shared`). |
| `plex` | Biblioteca de componentes UI (`@andes/plex`). |
| `log` | Logging Node (`@andes/log`). |
| `fhir` | Utilidades FHIR (`@andes/fhir`). |
| `andes-api-tools` | Monorepo Lerna: `core`, `event-bus`, `etl`, `georeference`, etc. Publica paquetes que usa `api`. |

### Aplicaciones satélite (Angular / móvil)

| Repo | Rol |
| ------|-----|
| `matriculaciones` | App de matriculaciones profesionales. |
| `monitoreo-app` | Monitoreo ANDES. |
| `turneroApp` | Visualización de llamado de turnos (`ng serve --port 4201`). |
| `mobile-app` | App móvil (Cordova/Android; README con requisitos de SDK). |
| `sala-de-situacion` | Workspace Nx (sala de situación). |
| `andes-analytics` | Analytics (API + app; remoto en `liquid36/andes-analytics`). |

### Integración e interoperabilidad

| Repo | Rol |
| ------|-----|
| `andesMicroservices` | Colección de microservicios Node (CDA, validadores, facturación, SMS, federador, etc.). Cada carpeta es un servicio. |
| `andes-fhir-server` | Facade FHIR sobre `@asymmetrik/node-fhir-server-core`. |
| `snomed-cie10` | Importa mapping SNOMED-CT → CIE-10 a Mongo. |
| `hl7-pacs` | Microservicio HL7 PACS (`hospitalneuquen`). |
| `documentacion-andes-ris` | Documentación proyecto migración RIS/imágenes (org `hospitalneuquen`). |

### Operaciones

| Repo | Rol |
| ------|-----|
| `andes-status-health` | Script de monitoreo (logs webhook en Mongo → Slack). Repo muy chico. |

**TODO:** Documentar URLs de ambientes (dev/demo/prod), puertos estándar y dependencias entre microservicios (más allá de lo visible en `package.json`).

## Cómo levantar (solo lo documentado en READMEs)

No inventar pasos no documentados. Referencias:

- **API:** `repos/api/README.md` — `npm install`, `config.private.ts`, `npm start`; dev con `npm run docker:up` / `docker:seed`.
- **App:** `repos/app/README.md` — versiones fijas de Angular CLI; `npm install`, `ng serve`.
- **FHIR server:** `repos/andes-fhir-server/README.md` — `npm install`, `npm run start` o Docker Compose.
- **Mobile:** `repos/mobile-app/README.md` — Android SDK, JDK 8, Cordova.

Para otros repos, seguir el README de cada carpeta bajo `repos/`.

## Convenciones para agentes

1. **Workspace:** Trabajar desde la raíz del clone de `andes/agents`. Rutas de código: `repos/<nombre>/…`.
2. **Manifiesto:** Nuevos repos → entrada en `repos.yaml` + `./bin/init` + actualizar este archivo.
3. **Paquetes `@andes/*`:** Muchos vienen de npm publicado o de `andes-api-tools`; al cambiar APIs compartidas, revisar consumidores en `api` y `app`.
4. **Secretos:** Nunca commitear `.env`, `config.private.ts`, claves ni datos de pacientes. Usar `*.example` cuando existan.
5. **Ramas:** La mayoría usa `master`; `documentacion-andes-ris` usa `main` (ver `repos.yaml`).
6. **Repos ajenos a org `andes`:** `andes-analytics` (liquid36), `documentacion-andes-ris` y `hl7-pacs` (hospitalneuquen) — requieren permisos de esas orgs.

## Carpetas de conocimiento en este repo

- `rules/andes.md` — reglas de conducta y límites (también en `.cursor/rules/` vía symlink).
- `docs/` — notas ampliadas.
- `prompts/` — plantillas.
- `skills/` — procedimientos reutilizables.

## Comandos útiles del meta-repo

```bash
./bin/status    # estado de todos los clones
./bin/sync      # actualizar sin pisar cambios locales
./bin/doctor    # prerequisitos
```