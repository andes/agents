# Ecosistema ANDES (notas)

Complemento de [AGENTS.md](../AGENTS.md). Detalle por repo: ver README de cada clone en `repos/`.

## Dependencias npm frecuentes (`@andes/*`)

- Frontend: `plex`, `shared`, `auth`, `icons`, `match` (versiones en `repos/app/package.json`).
- Backend: paquetes publicados desde `andes-api-tools` (`core`, `event-bus`, `etl`, `fuentes-autenticas`, etc.) referenciados en `repos/api/package.json`.

**TODO:** Matriz de versiones mínimas entre repos para releases coordinadas.

## Microservicios (`andesMicroservices`)

Carpetas observadas en el monorepo (cada una con su propio `package.json`):

`appGestion`, `bi-queries`, `bootstrap`, `bus-federador`, `cda-*`, `facturacion*`, `lamp`, `paciente_*`, `patient-validator`, `pdf-to-dicom`, `pecas-integration`, `profesional_*`, `sip-plus-perinatal`, `sms`, `sms-aws`.

**TODO:** Diagrama de flujo de integraciones (CDA, laboratorio, vacunas, etc.) a partir de documentación interna.