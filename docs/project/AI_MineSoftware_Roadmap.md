Este roadmap permitirá que cualquier sesión del Project Office conozca inmediatamente el avance de la metodología y del proyecto, sin tener que reconstruir el contexto a partir de múltiples conversaciones. Es un documento de gobernanza, no del producto, y creo que aportará claridad conforme AI MineSoftware siga creciendo.

| Fase                  | Especialista | Estado      |
| --------------------- | ------------ | ----------- |
| Product Discovery     | PD-001       | ✅ Cerrada   |
| Business Analysis     | BA-001       | ✅ Cerrada   |
| Solution Architecture | SA-001       | ⏳ Pendiente |
| UX                    | UX-001       | ⏳ Pendiente |
| Data Architecture     | DA-001       | ⏳ Pendiente |
| Development           | DEV-001      | ⏳ Pendiente |
| QA                    | QA-001       | ⏳ Pendiente |


Roadmap del Project Office
Phase 01 — Product Discovery
Especialista

PD-001 — Product Discovery Expert

Objetivo

Definir la identidad estratégica del producto antes de iniciar cualquier análisis, diseño o implementación.

Responsabilidades del Product Discovery
Comprender el problema de negocio.
Definir la Product Vision.
Identificar usuarios objetivo.
Definir objetivos del producto.
Delimitar el MVP.
Identificar principios estratégicos.
Identificar decisiones abiertas.
Responsabilidades del Project Office
Diseñar y aprobar el prompt PD-001.
Revisar la Product Vision.
Solicitar ajustes cuando sea necesario.
Aprobar la versión oficial de la Product Vision.
Aprobar el Decision Log inicial.
Verificar la consistencia metodológica.
Crear Phase_01_Closure.md.
Aprobar el cierre de la Phase 01.
Supervisar el commit y el push a GitHub.
Phase 02 — Business Analysis
Especialista

BA-001 — Business Analysis Expert

Objetivo

Transformar la Product Vision aprobada en una especificación completa de negocio.

Responsabilidades del Business Analysis
Definir el Business Domain.
Definir Business Processes.
Definir Business Rules.
Definir Functional Capability Model.
Definir Functional Requirements.
Definir Non-Functional Requirements.
Mantener trazabilidad.
Identificar Open Questions.
Consumir únicamente documentos aprobados.
Responsabilidades del Project Office
Diseñar y aprobar el prompt BA-001.
Resolver decisiones de gobernanza elevadas por Business Analysis.
Aprobar nuevos conceptos del dominio cuando correspondan.
Revisar la Business Analysis Specification.
Revisar el Business Domain Specification.
Aprobar los artefactos de negocio.
Incorporar mejoras metodológicas justificadas.
Actualizar la documentación de gobernanza cuando corresponda.
Crear Phase_02_Closure.md.
Aprobar el cierre de la Phase 02.
Supervisar el commit y el push a GitHub.
Phase 03 — Solution Architecture
Especialista

SA-001 — Solution Architecture Expert

Objetivo

Transformar el análisis de negocio aprobado en una arquitectura técnica implementable.

Responsabilidades del Solution Architecture

Definir la Arquitectura de Solución.
Definir la arquitectura lógica.
Identificar los Componentes Arquitectónicos.
Definir las responsabilidades de los Componentes Arquitectónicos.
Definir las relaciones entre los Componentes Arquitectónicos.
Establecer los Principios Arquitectónicos.
Establecer los Drivers Arquitectónicos.
Definir las Restricciones Arquitectónicas.
Mantener la trazabilidad con Business Analysis.
Generar la línea base arquitectónica.
Responsabilidades del Project Office
Diseñar y aprobar el prompt SA-001.
Revisar la Solution Architecture Specification.
Validar consistencia con Product Vision y Business Analysis.
Aprobar la arquitectura oficial.
Crear Phase_03_Closure.md.
Aprobar el cierre de la Phase 03.
Supervisar el commit y el push a GitHub.
Phase 04 — UX Design
Especialista

UX-001 — UX Expert

Objetivo

Diseñar la experiencia de usuario alineada con el modelo de negocio y la arquitectura aprobados.

Responsabilidades del Project Office
Diseñar y aprobar el prompt UX-001.
Revisar la UX Specification.
Validar consistencia con Business Analysis y Architecture.
Aprobar los entregables UX.
Crear Phase_04_Closure.md.
Aprobar el cierre de la fase.
Supervisar el commit y el push a GitHub.
Phase 05 — Development
Especialista

DEV-001 — Development Expert

Objetivo

Construir el producto conforme a la arquitectura aprobada.

Responsabilidades del Project Office
Diseñar y aprobar el prompt DEV-001.
Revisar la estrategia de desarrollo.
Validar que no existan desviaciones respecto a la arquitectura.
Aprobar la línea base de implementación.
Crear Phase_05_Closure.md.
Aprobar el cierre de la fase.
Supervisar el commit y el push a GitHub.
Phase 06 — Quality Assurance
Especialista

QA-001 — Quality Assurance Expert

Objetivo

Verificar que el producto cumpla los requisitos funcionales y no funcionales aprobados.

Responsabilidades del Project Office
Diseñar y aprobar el prompt QA-001.
Revisar la estrategia de pruebas.
Validar la cobertura de los requisitos.
Aprobar la documentación de calidad.
Crear Phase_06_Closure.md.
Aprobar el cierre de la fase.
Supervisar el commit y el push a GitHub.

Flujo oficial de trabajo

A partir de este punto, todas las fases seguirán exactamente el mismo ciclo:

1. Project Office
   ↓
   Diseña y aprueba el prompt del especialista

2. Especialista
   ↓
   Produce los artefactos de la fase

3. Project Office
   ↓
   Revisa, solicita ajustes y aprueba

4. Cierre de fase
   ↓
   Phase_XX_Closure.md

5. Git
   ↓
   git status
   git add
   git commit
   git push

6. Project Office
   ↓
   Entrega el prompt oficial de transición para la siguiente fase

   -------------------------------------------------

Arquitectura de especialistas dentro de AI MineSoftware.
Por ejemplo:
•	PO-001 — Project Office 
•	PD-001 — Product Discovery Expert 
•	BA-001 — Business Analysis Expert 
•	SA-001 — Solution Architecture Expert 
•	TA-001 — Technical Architecture Expert 
•	DB-001 — Database Design Expert 
•	BE-001 — Backend Development Expert 
•	FE-001 — Frontend Development Expert 
•	QA-001 — Quality Assurance Expert

# Flujo
Project Office
        │
        ▼
PD-001
(Product Discovery)
        │
        ▼
Product Vision
        │
──────────────
        │
        ▼
BA-001
(Business Analysis)
        │
        ▼
Business Analysis
Business Domain
        │
──────────────
        │
        ▼
SA-001
(Solution Architecture)
        │
        ▼
Solution Architecture
        │
──────────────
        │
        ▼
TA-001
(Technical Architecture)
        │
        ▼
Technical Architecture
        │
──────────────
        │
        ▼
DB-001
(Database Design)
        │
        ▼
Database Design
        │
──────────────
        │
        ▼
BE-001
(Backend Development)
        │
        ▼
Backend
        │
──────────────
        │
        ▼
FE-001
(Frontend Development)
        │
        ▼
Frontend
        │
──────────────
        │
        ▼
QA-001
(Quality Assurance)