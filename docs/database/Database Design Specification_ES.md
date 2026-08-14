# 1. Información del Documento

## 1.1 Propósito

El presente documento define el **Database Design Specification** oficial de **BudgetKeep**.

Su propósito es establecer el diseño completo de la base de datos del producto, definiendo el Modelo Lógico de Datos, el Modelo Físico de Datos y las decisiones técnicas necesarias para implementar una solución de persistencia consistente, escalable, mantenible y alineada con la línea base oficial del proyecto.

Esta especificación constituye la referencia oficial para el diseño, implementación, validación, evolución y mantenimiento de la base de datos de BudgetKeep, proporcionando un marco común para todas las disciplinas que interactúan con la persistencia de la información.

Las decisiones contenidas en este documento servirán como base para la construcción física de la base de datos, la generación de scripts SQL, la implementación del Backend, la definición de pruebas, la configuración de la infraestructura y la evolución futura del modelo de datos.

---

## 1.2 Objetivo

El objetivo del **Database Design Specification** es definir una arquitectura de datos consistente con el Modelo de Dominio, la Arquitectura de Solución y la Arquitectura Técnica aprobadas, garantizando la integridad, disponibilidad, trazabilidad y escalabilidad de la información administrada por BudgetKeep.

Asimismo, esta especificación proporciona los lineamientos necesarios para que la implementación física de la base de datos pueda desarrollarse de manera uniforme, reutilizable y alineada con los principios establecidos por la metodología AI MineSoftware.

---

## 1.3 Alcance

El presente documento cubre el diseño completo de la base de datos de BudgetKeep.

Su alcance comprende la definición del Modelo Lógico de Datos, el Modelo Físico de Datos, las entidades persistentes, relaciones, claves primarias y foráneas, restricciones, índices, convenciones de diseño, reglas de integridad, estrategias de persistencia, auditoría, historial, rendimiento, escalabilidad y trazabilidad necesarias para implementar la base de datos oficial del producto.

Asimismo, este documento constituye la base para la generación de los artefactos técnicos derivados del diseño, incluyendo modelos de datos, diagramas, scripts SQL, diccionario de datos, catálogos y demás componentes necesarios para la implementación física en Azure SQL Database.

Quedan fuera del alcance de esta especificación las reglas de negocio, procesos de negocio, requisitos funcionales, arquitectura de solución, arquitectura técnica, componentes de software, infraestructura y la definición de mecanismos de seguridad y autenticación.

No obstante, esta especificación sí define las estructuras de persistencia, relaciones, restricciones y reglas de integridad necesarias para soportar la administración de usuarios, credenciales, autorización, estado de seguridad, auditoría y configuración relacionada con la seguridad de las cuentas.

La implementación de los mecanismos de seguridad y autenticación será responsabilidad de los componentes definidos por la Arquitectura Técnica y las disciplinas correspondientes, manteniendo trazabilidad con las estructuras de persistencia definidas en este documento.

---

## 1.4 Audiencia

El presente documento está dirigido a las disciplinas responsables del diseño, implementación, validación, despliegue y evolución de la base de datos de BudgetKeep.

Entre las principales disciplinas involucradas se encuentran:

- Project Office
- Business Analysis
- Solution Architecture
- Technical Architecture
- Database Design
- Backend Development
- Infrastructure
- Security
- DevOps
- Quality Assurance

Asimismo, podrá utilizarse como documento de referencia por cualquier disciplina que requiera comprender el modelo de datos o mantener la trazabilidad con los artefactos oficiales del proyecto.

---

## 1.5 Documentos de Referencia

El **Database Design Specification** se desarrolla utilizando como línea base oficial los siguientes documentos aprobados del proyecto:

- Product Vision v1.1
- Decision Log
- Business Analysis Specification v1.0 (BAS-001)
- Business Domain Specification v1.0 (BDS-001)
- Solution Architecture Specification v1.0 (SA-001)
- Technical Architecture Specification v1.1 (TA-001)
- Phase 01 Closure
- Phase 02 Closure
- Phase 03 Closure
- Phase 04 Closure

Todas las decisiones contenidas en esta especificación deberán mantener consistencia y trazabilidad con los documentos anteriores.

---

## 1.6 Relación con la Línea Base

El **Database Design Specification** implementa las decisiones aprobadas por las disciplinas precedentes de la metodología AI MineSoftware y constituye la línea base oficial para todas las decisiones relacionadas con el diseño e implementación de la base de datos del producto.

Este documento no modifica ni redefine decisiones de negocio, arquitectura, tecnología o infraestructura previamente aprobadas.

En caso de identificarse la necesidad de modificar alguna decisión perteneciente a la línea base oficial del proyecto, dicha modificación deberá gestionarse mediante el proceso formal de gobernanza definido por AI MineSoftware.

Las decisiones aprobadas en esta especificación servirán como referencia obligatoria para la implementación física de la base de datos, el desarrollo del Backend, la automatización de despliegues, la validación funcional y técnica del producto, así como para la evolución futura del modelo de datos.

# 2. Principios de Diseño de Base de Datos

Los principios definidos en esta sección establecen los lineamientos que gobernarán todas las decisiones relacionadas con el diseño de la base de datos de BudgetKeep.

Estos principios deberán aplicarse de manera consistente durante la elaboración del Modelo Lógico de Datos, el Modelo Físico de Datos y la implementación de los objetos de base de datos, preservando la trazabilidad con la línea base oficial del proyecto y garantizando la calidad, consistencia y evolución del modelo de información.

---

## 2.1 Alineación con el Modelo de Dominio

El Diseño de Base de Datos deberá preservar la consistencia con el Modelo de Dominio definido en el *Business Domain Specification*.

Los Conceptos del Dominio constituyen la referencia funcional para el diseño de la persistencia; sin embargo, no implican que cada concepto deba convertirse directamente en una entidad persistente.

La decisión de persistir, calcular, derivar o materializar un concepto será responsabilidad del Diseño de Base de Datos y deberá justificarse dentro de esta especificación.

---

## 2.2 Integridad de la Información

La base de datos deberá garantizar la integridad y consistencia de la información mediante la definición adecuada de claves primarias, claves foráneas, restricciones, reglas de integridad referencial y demás mecanismos propios del motor de base de datos.

La integridad de los datos tendrá prioridad sobre la simplificación del modelo.

---

## 2.3 Fuente Única de Verdad

Cada dato persistente deberá almacenarse una única vez dentro del modelo de datos.

La duplicidad de información únicamente será permitida cuando exista una justificación técnica relacionada con el rendimiento, la disponibilidad o la escalabilidad de la solución, debiendo documentarse expresamente dentro de esta especificación.

---

## 2.4 Normalización

El Modelo Lógico de Datos deberá diseñarse siguiendo principios de normalización que reduzcan la redundancia, eviten anomalías de actualización y favorezcan la consistencia de la información.

Las decisiones de desnormalización únicamente podrán adoptarse cuando exista una justificación técnica documentada y su impacto haya sido evaluado.

---

## 2.5 Persistencia Basada en Responsabilidades

La persistencia de la información deberá responder a responsabilidades claramente definidas dentro del producto.

No todos los conceptos del negocio requerirán almacenamiento permanente.

Durante el diseño, cada elemento será clasificado de acuerdo con su naturaleza como información persistente, calculada, derivada, temporal, histórica, de configuración o de catálogo.

---

## 2.6 Trazabilidad

Todas las entidades, relaciones y objetos definidos en la base de datos deberán mantener trazabilidad con el Modelo de Dominio, los Requerimientos Funcionales y las decisiones aprobadas en la línea base del proyecto.

La trazabilidad permitirá justificar el propósito de cada elemento del modelo de datos y facilitará su evolución durante el ciclo de vida del producto.

---

## 2.7 Escalabilidad

El modelo de datos deberá diseñarse considerando el crecimiento funcional del producto, evitando decisiones que limiten la incorporación futura de nuevas capacidades o requieran rediseños estructurales innecesarios.

Las decisiones de diseño deberán favorecer la mantenibilidad, extensibilidad y estabilidad del modelo de datos.

---

## 2.8 Consistencia

Todos los objetos de la base de datos deberán seguir las convenciones, estándares y lineamientos definidos en la presente especificación.

No se permitirán excepciones que comprometan la uniformidad del modelo de datos, la comprensión de su estructura o la mantenibilidad de la solución.

# 3. Arquitectura General de la Base de Datos

La Base de Datos constituye el componente responsable de la persistencia de la información del producto BudgetKeep.

Su diseño deberá proporcionar una estructura consistente para almacenar, proteger y mantener la información financiera del usuario, garantizando la integridad, disponibilidad y trazabilidad de los datos durante todo el ciclo de vida del producto.

La arquitectura de la base de datos se desarrolla como una especialización de la Arquitectura Técnica aprobada y deberá mantener consistencia con los principios arquitectónicos definidos para la solución.

---

## 3.1 Objetivo Arquitectónico

La arquitectura de la base de datos tiene como objetivo proporcionar una plataforma de persistencia robusta, consistente y escalable que permita soportar las capacidades funcionales del producto sin comprometer la calidad de la información.

Asimismo, deberá facilitar la evolución futura del modelo de datos mediante una organización estructurada y desacoplada de los elementos persistentes.

---

## 3.2 Responsabilidades

La Base de Datos será responsable de:

- Persistir la información requerida por el producto.
- Garantizar la integridad de los datos.
- Mantener la consistencia del modelo de información.
- Preservar la trazabilidad de la información.
- Soportar las operaciones de consulta y actualización requeridas por el sistema.
- Proporcionar mecanismos que faciliten la auditoría y el historial cuando corresponda.

Las reglas de negocio, los procesos de negocio, la lógica de aplicación y cualquier responsabilidad ajena a la persistencia permanecerán fuera del alcance de la base de datos.

---

## 3.3 Organización Arquitectónica

La arquitectura de la base de datos estará compuesta por un conjunto de entidades persistentes organizadas de manera consistente para representar la información administrada por BudgetKeep.

Cada entidad deberá poseer una responsabilidad claramente definida y mantener relaciones explícitas con el resto del modelo de datos cuando corresponda.

La organización física de la base de datos será desarrollada en las secciones posteriores de esta especificación.

---

## 3.4 Relación con la Arquitectura Técnica

La Base de Datos constituye uno de los componentes definidos por la Arquitectura Técnica y deberá implementarse respetando las decisiones arquitectónicas previamente aprobadas.

Toda decisión relacionada con tecnologías, infraestructura, mecanismos de acceso a datos, seguridad, despliegue o integración permanecerá bajo la responsabilidad de la Arquitectura Técnica y no será redefinida por esta especificación.

---

## 3.5 Evolución del Modelo de Datos

La arquitectura de la base de datos deberá permitir la incorporación de nuevas capacidades funcionales sin requerir rediseños estructurales innecesarios.

Las futuras ampliaciones del modelo deberán preservar la compatibilidad con las decisiones aprobadas, manteniendo la consistencia, integridad y trazabilidad del modelo de información.

# 4. Modelo Conceptual de Persistencia

El Modelo Conceptual de Persistencia constituye la transición entre el Modelo de Dominio definido por Business Analysis y el Modelo Lógico de Datos definido por la presente especificación.

Su propósito es identificar qué información requiere persistencia dentro del producto, independientemente de la estructura física que posteriormente será implementada en la base de datos.

Este modelo mantiene la trazabilidad con los Conceptos del Dominio, sin asumir que cada uno de ellos deba convertirse en una entidad persistente.

---

## 4.1 Relación con el Modelo de Dominio

El Modelo de Dominio representa los conceptos funcionales utilizados por BudgetKeep para describir la realidad financiera del usuario.

El Modelo Conceptual de Persistencia reutiliza dichos conceptos como punto de partida para identificar la información que deberá almacenarse de forma permanente, la información que podrá calcularse y aquella que será derivada durante la operación del sistema.

Esta transformación constituye una responsabilidad exclusiva del Diseño de Base de Datos.

---

## 4.2 Estrategia de Transformación

Cada Concepto del Dominio será analizado desde la perspectiva de persistencia para determinar su naturaleza dentro del modelo de datos.

Como resultado de este análisis, cada concepto será clasificado de acuerdo con una de las siguientes categorías:

- Entidad Persistente.
- Información Calculada.
- Información Derivada.
- Información Temporal.
- Información Histórica.
- Catálogo.
- Configuración.

La clasificación obtenida servirá como base para el desarrollo del Modelo Lógico de Datos.

---

## 4.3 Criterios de Persistencia

La decisión de persistir información deberá sustentarse en los siguientes criterios:

- La información representa un estado del negocio que debe conservarse.
- La información participa en procesos funcionales del producto.
- La información requiere mantener historial.
- La información debe garantizar trazabilidad.
- La información participa en relaciones con otras entidades persistentes.

Los conceptos que no cumplan dichos criterios podrán implementarse mediante cálculos, reglas de negocio o mecanismos derivados, evitando almacenamiento innecesario.

---

## 4.4 Independencia del Modelo Físico

El Modelo Conceptual de Persistencia permanecerá independiente de cualquier decisión relacionada con estructuras físicas, tipos de datos, índices, restricciones o mecanismos específicos del motor de base de datos.

Estas decisiones serán desarrolladas durante las etapas posteriores de diseño.

# 5. Modelo Lógico de Datos

El Modelo Lógico de Datos representa la organización estructurada de la información persistente requerida por BudgetKeep.

Su propósito es definir las entidades lógicas, sus atributos, relaciones y dependencias, independientemente de cualquier consideración relacionada con la implementación física de la base de datos.

El Modelo Lógico constituye la base para el desarrollo del Modelo Físico de Datos y mantiene la trazabilidad con el Modelo Conceptual de Persistencia definido en la sección anterior.

---

## 5.1 Objetivo

El Modelo Lógico de Datos tiene como objetivo representar la información persistente necesaria para soportar las capacidades funcionales del producto, garantizando consistencia, integridad, reutilización y escalabilidad.

Asimismo, proporciona una representación independiente de la tecnología que facilitará la implementación física de la base de datos y la evolución futura del modelo de información.

---

## 5.2 Componentes

El Modelo Lógico estará compuesto por los siguientes elementos:

- Entidades Lógicas.
- Atributos.
- Relaciones.
- Cardinalidades.
- Dependencias.
- Reglas de Integridad Lógica.

Cada uno de estos elementos será definido en las secciones posteriores de esta especificación.

---

## 5.3 Principios de Modelado

El Modelo Lógico deberá cumplir los siguientes principios:

- Representar únicamente información persistente.
- Evitar redundancia innecesaria.
- Favorecer la reutilización de la información.
- Mantener independencia respecto al motor de base de datos.
- Preservar la trazabilidad con el Modelo Conceptual de Persistencia.
- Facilitar la evolución funcional del producto.

---

## 5.4 Relación con el Modelo Físico

El Modelo Lógico constituye la base para la construcción del Modelo Físico de Datos.

Las decisiones relacionadas con nombres físicos, tipos de datos, índices, restricciones, objetos del motor y demás elementos propios de la implementación serán desarrolladas durante el diseño físico, manteniendo la correspondencia con las entidades lógicas definidas en esta especificación.

---

## 5.5 Evolución del Modelo

El Modelo Lógico deberá evolucionar preservando la compatibilidad con las decisiones aprobadas en la línea base del proyecto.

Toda modificación deberá mantener la consistencia del modelo, la integridad de la información y la trazabilidad entre los diferentes niveles de diseño definidos por la metodología AI MineSoftware.

# 6. Modelo Físico de Datos

El Modelo Físico de Datos representa la implementación del Modelo Lógico dentro del motor de base de datos definido por la Arquitectura Técnica.

Su propósito es transformar las entidades lógicas en estructuras físicas optimizadas para su almacenamiento, consulta y mantenimiento, preservando la integridad de la información y la trazabilidad con los niveles de diseño previamente definidos.

El Modelo Físico constituye la base para la construcción de la base de datos oficial de BudgetKeep en Azure SQL Database.

---

## 6.1 Objetivo

El Modelo Físico de Datos tiene como objetivo definir la estructura definitiva de la base de datos que será implementada en el entorno de producción.

Esta estructura deberá garantizar consistencia, rendimiento, mantenibilidad y capacidad de evolución, respetando las decisiones establecidas por el Modelo Lógico de Datos y la Arquitectura Técnica del proyecto.

---

## 6.2 Componentes

El Modelo Físico estará compuesto, entre otros, por los siguientes elementos:

- Esquemas de Base de Datos.
- Tablas.
- Columnas.
- Claves Primarias.
- Claves Foráneas.
- Restricciones.
- Índices.
- Objetos de soporte definidos por esta especificación.

Cada uno de estos componentes será desarrollado y documentado en las secciones posteriores.

---

## 6.3 Principios de Implementación

La implementación física deberá cumplir los siguientes principios:

- Mantener correspondencia con el Modelo Lógico de Datos.
- Garantizar la integridad referencial.
- Minimizar la redundancia de información.
- Favorecer el rendimiento de las operaciones transaccionales y de consulta.
- Facilitar la evolución futura del modelo.
- Mantener consistencia con las convenciones definidas en esta especificación.

---

## 6.4 Independencia de la Implementación

Las decisiones de implementación física deberán limitarse a aspectos propios del almacenamiento de información.

Las reglas de negocio, procesos funcionales, lógica de aplicación y demás responsabilidades definidas por otras disciplinas permanecerán fuera del alcance del Modelo Físico de Datos.

---

## 6.5 Preparación para la Implementación

Las secciones posteriores desarrollarán de manera detallada la organización física de la base de datos, incluyendo la definición de esquemas, tablas, relaciones, restricciones, índices y demás objetos necesarios para construir la base de datos oficial de BudgetKeep.

Cada uno de estos elementos será acompañado por los artefactos técnicos necesarios para su implementación y validación.

## 6.6 Decisiones Físicas Aprobadas

Las siguientes decisiones constituyen la línea base física aprobada hasta esta etapa del diseño de BudgetKeep. Estas decisiones deberán ser reutilizadas por el Modelo Físico, los scripts SQL, los scripts de Rollback, los scripts Seed, la implementación en Azure SQL Database y la validación del dominio.

### 6.6.1 Identificadores y esquema

* Los identificadores de las entidades con Primary Key simple utilizarán `BIGINT IDENTITY(1,1)`.
* Las entidades puente con Primary Key compuesta conservarán las claves compuestas definidas por el Modelo Lógico.
* Las entidades 1:1 que utilizan el identificador de su entidad propietaria conservarán dicho identificador como Primary Key y Foreign Key.
* Los identificadores persistentes son internos y no constituyen identificadores funcionales o públicos.
* El esquema físico inicial de BudgetKeep será `dbo`.

### 6.6.2 Tipos de datos físicos

* Identificadores: `BIGINT`.
* Valores booleanos: `BIT`.
* Fechas y horas: `DATETIME2(3)`.
* Códigos técnicos: `VARCHAR(50)`.
* Username: `VARCHAR(100)`.
* Email: `VARCHAR(254)`.
* SupportId: `VARCHAR(32)`.
* PhoneNumber: `VARCHAR(30)`.
* PasswordHash: `VARCHAR(255)`.
* FirstName: `NVARCHAR(100)`.
* LastName: `NVARCHAR(150)`.
* Name: `NVARCHAR(150)`.
* Description: `NVARCHAR(500)`.
* SystemConfiguration.Value: `NVARCHAR(500)`.
* No se utilizarán `VARCHAR(MAX)` o `NVARCHAR(MAX)` en este dominio sin una justificación técnica específica.

### 6.6.3 Identidad de usuario y SupportId

* `Username` representa el identificador de login del usuario de BudgetKeep y es independiente de las identidades administrativas utilizadas para acceder a Azure, Azure SQL u otros servicios de infraestructura.
* `Username` será obligatorio y único dentro del sistema.
* `SupportId` será obligatorio, único, estable durante la vida de la cuenta y no podrá reutilizarse para otro usuario.
* `SupportId` será un identificador opaco generado por el Backend y almacenado como `VARCHAR(32)`.
* La generación de `SupportId` no dependerá de `UserId` ni de un valor generado por `IDENTITY`.
* `SupportId` no constituye un mecanismo de autenticación ni de verificación de identidad.

### 6.6.4 Fechas, auditoría y UTC

* Los timestamps persistentes se almacenarán como `DATETIME2(3)` en UTC.
* `CreatedAt` será `NOT NULL` y utilizará `DEFAULT SYSUTCDATETIME()`.
* `UpdatedAt` será nullable y no tendrá default.
* `DeletedAt` será nullable y no tendrá default cuando la entidad implemente eliminación lógica.
* `CreatedBy`, `UpdatedBy` y `DeletedBy`, cuando estén presentes, serán `BIGINT NULL` y referenciarán `User.UserId`.
* Los campos de auditoría podrán ser `NULL` durante inicialización, migración o procesos técnicos sin usuario autenticado.
* El primer usuario podrá crearse con sus atributos de auditoría en `NULL`.
* No se utilizarán triggers para implementar la auditoría estándar. El Backend será responsable de proporcionar el contexto del usuario y actualizar `UpdatedAt`, `UpdatedBy`, `DeletedAt` y `DeletedBy` cuando corresponda.
* No se agregará `IsDeleted`; `DeletedAt` representa la eliminación lógica.
* `IsActive` y `DeletedAt` representan conceptos diferentes y permanecerán independientes.

### 6.6.5 Valores por defecto

Los defaults físicos aprobados son:

| Atributo / Familia    | Default            |
| --------------------- | ------------------ |
| `CreatedAt`           | `SYSUTCDATETIME()` |
| `IsActive`            | `1`                |
| `IsSystemRole`        | `0`                |
| `FailedLoginAttempts` | `0`                |
| `LockoutCount`        | `0`                |
| `RequiresSupport`     | `0`                |

Los atributos temporales de estado de seguridad, como `LockoutUntil`, `LockoutWindowStart`, `LastLoginDate` y `PasswordChangedDate`, permanecerán `NULL` hasta que exista un valor aplicable.

### 6.6.6 Constraints e integridad

* Las Primary Keys serán definidas en todas las entidades.
* Las restricciones `UNIQUE` se implementarán para `Username`, `Email`, `SupportId` y los `Code` definidos como únicos por el Modelo Lógico.
* Los contadores `FailedLoginAttempts` y `LockoutCount` tendrán restricciones `CHECK` que impidan valores menores que cero.
* `UserSecurity.RequiresSupport = 1` implicará físicamente `LockoutUntil IS NULL` mediante una restricción `CHECK`.
* No se implementarán mediante `CHECK` los límites dinámicos de la política de seguridad ni la lógica temporal de bloqueo.
* No se utilizarán `CHECK` para validar formatos de Email, Username, PhoneNumber u otros datos personales, salvo decisión física específica posterior.
* `SystemConfiguration.Value` no tendrá validación dinámica de tipo mediante `CHECK`; `ConfigurationDataTypeId` garantizará la referencia a un tipo válido y la interpretación del valor corresponderá a la aplicación.
* `IsActive` y `DeletedAt` no tendrán una relación física obligatoria entre sí.

### 6.6.7 Foreign Keys y comportamiento referencial

* Todas las Foreign Keys utilizarán `ON DELETE NO ACTION`.
* Todas las Foreign Keys utilizarán `ON UPDATE NO ACTION`.
* Los identificadores serán considerados estables y no se actualizarán durante la vida del registro.
* No se utilizará `CASCADE DELETE` en este dominio.
* Las relaciones `User → UserSecurity` y `User → UserPreference` no tendrán cascada.
* Las relaciones de autorización entre `Role`, `Module`, `Permission`, `ModulePermission`, `UserRole` y `RolePermission` no tendrán cascada.
* `ConfigurationDataType → SystemConfiguration` no tendrá cascada.
* `Language → UserPreference` y `TimeZone → UserPreference` no tendrán cascada.
* Las Foreign Keys de auditoría hacia `User.UserId` utilizarán `NO ACTION`.
* La relación 1:1 obligatoria entre `User` y `UserSecurity` se garantiza mediante la combinación de Primary Key/Foreign Key y el proceso transaccional de creación del usuario. La Foreign Key por sí sola no garantiza la existencia del registro dependiente para cada usuario.

### 6.6.8 Índices

* Las Primary Keys proporcionarán los índices correspondientes.
* Las restricciones `UNIQUE` proporcionarán los índices únicos necesarios.
* Se crearán los siguientes índices secundarios justificados por los patrones de acceso inverso de las relaciones N:N:

  * `IX_UserRole_RoleId` sobre `UserRole(RoleId)`.
  * `IX_ModulePermission_PermissionId` sobre `ModulePermission(PermissionId)`.
  * `IX_RolePermission_ModulePermission` sobre `RolePermission(ModuleId, PermissionId)`.
* No se crearán índices adicionales sobre atributos de seguridad, auditoría, preferencias o configuración sin una necesidad funcional o de rendimiento justificada.
* La estrategia de índices podrá evolucionar posteriormente con evidencia de consultas reales y validación de rendimiento.

### 6.6.9 Convención de nombres de constraints

Las restricciones físicas utilizarán las siguientes convenciones:

* Primary Key: `PK_<Table>`.
* Foreign Key: `FK_<Table>_<ReferencedTable>`.
* Unique: `UQ_<Table>_<Column>`.
* Check: `CK_<Table>_<Column>`.
* Default: `DF_<Table>_<Column>`.

### 6.6.10 Orden de creación del esquema

Para permitir una construcción reproducible desde una base limpia y evitar deshabilitar integridad referencial, el orden base de creación será:

1. `User`
2. `Role`
3. `Module`
4. `Permission`
5. `ConfigurationDataType`
6. `Language`
7. `TimeZone`
8. `UserSecurity`
9. `UserPreference`
10. `SystemConfiguration`
11. `ModulePermission`
12. `UserRole`
13. `RolePermission`

La tabla `User` se creará inicialmente con sus columnas de auditoría, pero las Foreign Keys autorreferenciadas `CreatedBy`, `UpdatedBy` y `DeletedBy` se agregarán posteriormente mediante `ALTER TABLE`.

No se deshabilitarán constraints durante la creación normal del esquema.

Las Foreign Keys que dependan de tablas ya creadas se agregarán una vez disponibles sus objetos referenciados. Los índices secundarios se crearán después de disponer de las tablas y relaciones correspondientes.

### 6.6.11 Secuencia de ejecución de scripts

La implementación física del dominio deberá seguir una secuencia reproducible y explícita.

El orden lógico de ejecución será:

1. Preparación de schema y prerrequisitos de base de datos, cuando sean necesarios.
2. Creación de tablas.
3. Creación de Primary Keys, restricciones `UNIQUE`, `CHECK` y `DEFAULT` que formen parte de la estructura de cada tabla.
4. Creación de Foreign Keys, incluyendo las Foreign Keys autorreferenciadas de `User` mediante `ALTER TABLE` cuando corresponda.
5. Creación de índices secundarios.
6. Ejecución de Seed Data.
7. Ejecución de validaciones estructurales y de integridad.
8. Validación de reproducibilidad desde una base limpia.

La secuencia de ejecución de scripts deberá respetar las dependencias establecidas en el Modelo Físico y no deberá depender de ejecuciones manuales intermedias.

La estructura definitiva de archivos y directorios de scripts se definirá durante la etapa de implementación y deberá reflejar esta secuencia lógica.

### 6.6.12 Seed y Rollback

* El Seed se ejecutará después de completar la estructura física y sus constraints.
* Los datos de Seed se cargarán respetando sus dependencias referenciales.
* Los scripts Seed no dependerán de valores concretos generados por `IDENTITY`; utilizarán Codes u otras claves estables aprobadas para localizar registros y recuperar sus identificadores.
* La definición concreta de los registros Seed de Identity & Security se documentará antes de su implementación.
* El Rollback seguirá el orden inverso de las dependencias de creación.
* El Rollback no utilizará `CASCADE` como mecanismo de simplificación.

### 6.6.13 Secuencia lógica de Rollback

La reversión del dominio deberá ejecutarse en orden inverso a la creación y respetando las dependencias referenciales.

El orden lógico será:

1. Eliminación controlada de los datos Seed, cuando corresponda.
2. Eliminación de índices secundarios.
3. Eliminación de Foreign Keys.
4. Eliminación de tablas en orden inverso a sus dependencias.
5. Eliminación de objetos de schema adicionales, cuando hayan sido creados específicamente para el dominio.

El Rollback deberá ser reproducible y no deberá depender de `CASCADE DELETE`.

### 6.6.14 Trazabilidad de las decisiones físicas

Las decisiones de esta sección constituyen la línea base física aprobada para el dominio Identity & Security y deberán reutilizarse sin reinterpretación en:

* el Modelo Físico de Datos;
* los scripts SQL de creación;
* los scripts de Rollback;
* los scripts Seed, cuando aplique;
* la implementación en Azure SQL Database;
* las pruebas y validaciones de estructura e integridad.

Cualquier modificación posterior a estas decisiones deberá identificarse como una nueva decisión de diseño, analizar su impacto sobre los artefactos relacionados y ser aprobada antes de incorporarse al Modelo Físico o a los scripts de implementación.

### 6.6.15 Implementación y Validación del Dominio Identity & Security

El dominio Identity & Security ha sido implementado en Azure SQL Database conforme al Modelo Físico de Datos y a los scripts SQL definidos para el dominio.

La implementación comprende:

- Creación de las 13 tablas del dominio.
- Creación de las Primary Keys.
- Creación de las restricciones UNIQUE.
- Creación de las restricciones CHECK.
- Creación de los valores DEFAULT.
- Creación de las Foreign Keys.
- Creación de los índices secundarios aprobados.
- Ejecución del Seed Data definido.
- Validación de la estructura física.
- Validación de las relaciones y restricciones.
- Validación de los índices.
- Validación de los datos Seed.
- Validación de integridad referencial.

Los scripts utilizados para la implementación se encuentran bajo:

`docs/database/scripts/`

La secuencia de implementación utilizada fue:

1. `create/001_CreateTables.sql`
2. `create/002_CreateForeignKeys.sql`
3. `create/003_CreateIndexes.sql`
4. `seed/004_Seed.sql`
5. `validation/900_Validation.sql`

La implementación fue ejecutada directamente sobre la base de datos Azure SQL Database de BudgetKeep y posteriormente verificada mediante consultas de validación en SQL Server Management Studio (SSMS).

El script de validación finalizó correctamente y no reportó errores.

El dominio Identity & Security cumple con los criterios de implementación y validación definidos por esta especificación.

## 6.7 Decisiones Físicas — Catalogs

El dominio Catalogs utiliza las decisiones físicas generales aprobadas
en la sección 6.6 y define las siguientes decisiones específicas para
sus entidades persistentes.

### 6.7.1 Language

- `LanguageId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `Code` utilizará `VARCHAR(50)` y será `NOT NULL`.
- `Name` utilizará `NVARCHAR(150)` y será `NOT NULL`.
- `IsActive` utilizará `BIT` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL` y referenciará `User.UserId`.
- `UpdatedAt` utilizará `DATETIME2(3) NULL`.
- `UpdatedBy` utilizará `BIGINT NULL` y referenciará `User.UserId`.
- `Code` tendrá una restricción `UNIQUE`.
- Las Foreign Keys de auditoría utilizarán `ON DELETE NO ACTION`
  y `ON UPDATE NO ACTION`.

### 6.7.2 TimeZone

- `TimeZoneId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `Code` utilizará `VARCHAR(50)` y será `NOT NULL`.
- `Name` utilizará `NVARCHAR(150)` y será `NOT NULL`.
- `IsActive` utilizará `BIT` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL` y referenciará `User.UserId`.
- `UpdatedAt` utilizará `DATETIME2(3) NULL`.
- `UpdatedBy` utilizará `BIGINT NULL` y referenciará `User.UserId`.
- `Code` tendrá una restricción `UNIQUE`.
- Las Foreign Keys de auditoría utilizarán `ON DELETE NO ACTION`
  y `ON UPDATE NO ACTION`.

### 6.7.3 Seed

Los registros iniciales aprobados para Catalogs son:

#### Language

| Code | Name | IsActive |
|------|------|----------|
| en | English | 1 |
| es | Español | 1 |

#### TimeZone

| Code | Name | IsActive |
|------|------|----------|
| America/Mexico_City | Mexico City | 1 |
| UTC | Coordinated Universal Time | 1 |

El Seed utilizará los códigos estables de los catálogos y no dependerá
de valores específicos generados por IDENTITY.

## 6.8 Decisiones Físicas — Financial Resources

El dominio Financial Resources utiliza las decisiones físicas generales
aprobadas en la sección 6.6 y define las siguientes decisiones específicas
para sus entidades persistentes.

### 6.8.1 Currency

- `CurrencyId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `Code` utilizará `VARCHAR(50)` y será `NOT NULL`.
- `Name` utilizará `NVARCHAR(150)` y será `NOT NULL`.
- `Symbol` utilizará `NVARCHAR(10)` y será `NOT NULL`.
- `IsActive` utilizará `BIT` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`, con default `SYSUTCDATETIME()`.
- `CreatedBy` utilizará `BIGINT NULL` y referenciará `User.UserId`.
- `UpdatedAt` utilizará `DATETIME2(3) NULL`.
- `UpdatedBy` utilizará `BIGINT NULL` y referenciará `User.UserId`.
- `Code` tendrá una restricción `UNIQUE`.
- Las Foreign Keys de auditoría utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.
- `Currency` no implementará eliminación lógica mediante `DeletedAt` y `DeletedBy`.
- La desactivación de una moneda se realizará mediante `IsActive = 0`.

### 6.8.2 FinancialResource

- `FinancialResourceId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `UserId` utilizará `BIGINT` y será `NOT NULL`.
- `Name` utilizará `NVARCHAR(150)` y será `NOT NULL`.
- `ResourceType` utilizará `VARCHAR(50)` y será `NOT NULL`.
- `CurrencyId` utilizará `BIGINT` y será `NOT NULL`.
- `AvailableAmount` utilizará `DECIMAL(19,4)` y será `NOT NULL`.
- `IsActive` utilizará `BIT` y será `NOT NULL`, con default `1`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`, con default `SYSUTCDATETIME()`.
- `CreatedBy` utilizará `BIGINT NULL` y referenciará `User.UserId`.
- `UpdatedAt` utilizará `DATETIME2(3) NULL`.
- `UpdatedBy` utilizará `BIGINT NULL` y referenciará `User.UserId`.
- `DeletedAt` utilizará `DATETIME2(3) NULL`.
- `DeletedBy` utilizará `BIGINT NULL` y referenciará `User.UserId`.
- Las Foreign Keys utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

### 6.8.3 Restricciones e índices

- `PK_Currency` será la Primary Key de `Currency`.
- `PK_FinancialResource` será la Primary Key de `FinancialResource`.
- `UQ_Currency_Code` será la restricción `UNIQUE` de `Currency.Code`.
- `IX_FinancialResource_UserId` se creará sobre `FinancialResource(UserId)`.
- `IX_FinancialResource_CurrencyId` se creará sobre `FinancialResource(CurrencyId)`.
- No se crearán índices adicionales sobre `IsActive`, `ResourceType`, auditoría o `Name` sin evidencia de consultas o necesidad de rendimiento.

### 6.8.4 Foreign Keys

- `FinancialResource.UserId` → `User.UserId`.
- `FinancialResource.CurrencyId` → `Currency.CurrencyId`.
- `Currency.CreatedBy` → `User.UserId`.
- `Currency.UpdatedBy` → `User.UserId`.
- `FinancialResource.CreatedBy` → `User.UserId`.
- `FinancialResource.UpdatedBy` → `User.UserId`.
- `FinancialResource.DeletedBy` → `User.UserId`.

Todas las Foreign Keys utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

### 6.8.5 Defaults

- `Currency.CreatedAt` → `SYSUTCDATETIME()`.
- `Currency.IsActive` → `1`.
- `FinancialResource.CreatedAt` → `SYSUTCDATETIME()`.
- `FinancialResource.IsActive` → `1`.

### 6.8.6 Seed

Los registros iniciales aprobados para `Currency` son:

| Code | Name | Symbol | IsActive |
|------|------|--------|----------|
| MXN | Peso mexicano | $ | 1 |
| USD | US Dollar | $ | 1 |
| EUR | Euro | € | 1 |

El Seed utilizará `Code` como clave estable y no dependerá de valores específicos generados por `IDENTITY`.

`FinancialResource` no tendrá Seed porque sus registros pertenecen a usuarios y deben ser creados mediante la operación funcional correspondiente.

## 6.9 Decisiones de Diseño — Financial Events

Las siguientes decisiones establecen la línea base de diseño para el dominio
Financial Events.

Estas decisiones definen la separación entre las configuraciones financieras
del Usuario, las reglas de recurrencia y las ocurrencias financieras
persistentes.

El diseño deberá mantener consistencia con el Modelo de Dominio, el Modelo
Lógico de Datos y los principios generales definidos en esta especificación,
particularmente con los principios de integridad, fuente única de verdad,
normalización, trazabilidad y persistencia basada en responsabilidades.

### 6.9.1 Separación entre definición y ocurrencia

`Income` y `Expense` representan definiciones financieras configuradas por el
Usuario.

`StandAlone` representa un evento financiero registrado directamente por el
Usuario, sin una definición previa de Income o Expense y sin recurrencia.

`Income`, `Expense` y `StandAlone` constituyen las tres posibles fuentes de
un `Financial Event`.

`Financial Event` representa una ocurrencia financiera concreta.

Una misma definición de `Income` o `Expense` podrá generar múltiples
`Financial Event` a lo largo del tiempo.

Por ejemplo:

- `Income 1` = Salario.
- `Financial Event 1` = Salario correspondiente al 15 de agosto.
- `Financial Event 2` = Salario correspondiente al último día de agosto.
- `Financial Event 3` = Salario correspondiente al 15 de septiembre.

De forma equivalente:

- `Expense 1` = Renta de casa.
- `Financial Event 10` = Renta correspondiente a agosto.
- `Financial Event 11` = Renta correspondiente a septiembre.
- `Financial Event 12` = Renta correspondiente a octubre.

Esta separación evita duplicar la configuración del concepto financiero en
cada ocurrencia y permite conservar el historial de cada evento.

### 6.9.2 Income como definición de ingreso

`Income` representará una definición de ingreso perteneciente a un Usuario.

La entidad permitirá registrar conceptos como:

- Salario.
- Salario secundario.
- Freelance.
- Ingreso por inversiones.
- Otros ingresos definidos por el Usuario.

Un `Income` podrá tener una configuración de recurrencia, pero la recurrencia
no será obligatoria.

Un `Income` podrá generar múltiples `Financial Event`.

El importe definido para un `Income`, cuando exista, representará el importe
esperado o de referencia para sus futuras ocurrencias y no sustituirá el
importe registrado en cada `Financial Event`.

### 6.9.3 Expense como definición de gasto

`Expense` representará una definición de gasto perteneciente a un Usuario.

La entidad permitirá registrar conceptos como:

- Renta de casa.
- Servicios.
- Supermercado.
- Transporte.
- Otros gastos definidos por el Usuario.

Un `Expense` podrá clasificarse como gasto fijo o variable de acuerdo con
las necesidades funcionales del producto.

Un `Expense` podrá tener una configuración de recurrencia, pero la recurrencia
no será obligatoria.

Un `Expense` podrá generar múltiples `Financial Event`.

El importe definido para un `Expense`, cuando exista, representará el importe
esperado o de referencia para sus futuras ocurrencias y no sustituirá el
importe registrado en cada `Financial Event`.

### 6.9.4 Financial Event como ocurrencia financiera

`Financial Event` representará una ocurrencia financiera concreta asociada
a un `Income` o `Expense`.

Cada `Financial Event` conservará la información correspondiente a su propia
ocurrencia, incluyendo el importe y la fecha aplicables a dicha ocurrencia.

Un `Financial Event` podrá existir sin una configuración de recurrencia.

Esto permitirá registrar eventos:

- únicos;
- no recurrentes;
- cuya fecha no siga un patrón;
- cuya recurrencia no sea conocida;
- que simplemente ya ocurrieron y fueron registrados por el Usuario.

### 6.9.5 RecurrenceConfiguration como configuración opcional

`RecurrenceConfiguration` representará la configuración utilizada para
determinar las futuras ocurrencias esperadas de un `Income` o `Expense`.

La relación será opcional:

- Un `Income` podrá tener cero o una `RecurrenceConfiguration`.
- Un `Expense` podrá tener cero o una `RecurrenceConfiguration`.

Una `RecurrenceConfiguration` deberá pertenecer a un único `Income` o a un
único `Expense`.

La configuración de recurrencia no representará por sí misma una ocurrencia
financiera.

### 6.9.6 RecurrenceType como catálogo de reglas de calendario

`RecurrenceType` representará el catálogo de reglas de calendario soportadas
por BudgetKeep.

El catálogo no deberá interpretar la recurrencia únicamente como la suma
de una cantidad fija de días.

Las reglas deberán representar patrones de calendario financieros.

Entre los patrones soportados se contemplan:

- Mensual en día específico.
- Quincenal: día 15 y último día del mes.
- Semanal en un día específico de la semana.
- Catorcenal: un día específico de la semana cada dos semanas, utilizando
  una fecha de referencia para determinar la secuencia.
- Anual en una fecha específica.

La lista definitiva de valores del catálogo y sus parámetros requeridos se
definirá durante el diseño lógico y físico de la entidad.

### 6.9.7 Interpretación de la recurrencia

La recurrencia deberá representar el patrón de calendario que el Usuario
pretende utilizar y no deberá interpretarse automáticamente como una
cantidad fija de días entre ocurrencias.

Por ejemplo:

`Quincenal` significará:

- día 15 del mes; y
- último día del mes.

No significará sumar exactamente 15 días a la ocurrencia anterior.

En cambio, una recurrencia `Catorcenal` podrá representar un día específico
de la semana cada dos semanas.

Por ejemplo:

- viernes 7 de agosto;
- viernes 21 de agosto;
- viernes 4 de septiembre;
- viernes 18 de septiembre.

La configuración deberá proporcionar la información necesaria para calcular
las fechas futuras sin requerir que el Usuario capture cada fecha
manualmente.

### 6.9.8 Generación de ocurrencias futuras

Cuando un `Income` o `Expense` tenga una `RecurrenceConfiguration` activa,
BudgetKeep deberá utilizar dicha configuración para generar o mantener las
ocurrencias futuras esperadas.

El Usuario deberá realizar la configuración inicial una sola vez y no deberá
registrar manualmente cada ocurrencia recurrente.

La generación de una ocurrencia futura tendrá como propósito ayudar al
Usuario a organizarse y recordar sus compromisos financieros.

La generación automática de una ocurrencia no implicará que la operación
financiera haya ocurrido.

### 6.9.9 Estado Expected

Las ocurrencias generadas automáticamente deberán iniciar como `EXPECTED`.

`EXPECTED` representa una ocurrencia financiera esperada de acuerdo con la
configuración registrada por el Usuario.

Un `Financial Event` en estado `EXPECTED` no representará por sí mismo una
operación financiera confirmada.

La existencia de un `Financial Event` `EXPECTED` permitirá que BudgetKeep
muestre al Usuario lo que se espera que ocurra durante el periodo consultado.

### 6.9.10 Confirmación como fuente de verdad

La confirmación explícita del Usuario constituirá la fuente de verdad para
determinar que una ocurrencia financiera realmente ocurrió.

Cuando el Usuario confirme un `Financial Event`, éste podrá pasar de
`EXPECTED` a `CONFIRMED`.

BudgetKeep no deberá inferir que un evento ocurrió únicamente porque haya
llegado o pasado su fecha esperada.

El transcurso del tiempo no deberá modificar automáticamente el estado del
evento.

Un evento `EXPECTED` que no haya sido confirmado deberá permanecer como
`EXPECTED`, independientemente de que su fecha esperada haya pasado.

### 6.9.11 Realidad Financiera

Para efectos de la Realidad Financiera:

- `EXPECTED` representa una expectativa o planificación.
- `CONFIRMED` representa una ocurrencia confirmada por el Usuario.

Un `Financial Event` `EXPECTED` no deberá considerarse automáticamente como
dinero recibido, dinero gastado, pago realizado o movimiento financiero
confirmado.

La Realidad Financiera deberá utilizar únicamente la información persistente
que corresponda de acuerdo con las reglas de negocio definidas para los
eventos confirmados.

Esta decisión mantiene la Realidad Financiera como un concepto derivado y
evita inferir información financiera a partir del simple transcurso del
tiempo.

### 6.9.12 Fecha esperada y fecha real

Un `Financial Event` generado a partir de una recurrencia deberá conservar
la fecha esperada calculada por BudgetKeep.

Cuando el Usuario confirme que la ocurrencia sucedió en una fecha diferente,
deberá conservarse la fecha real proporcionada por el Usuario.

Ejemplo:

- Fecha esperada: 15 de agosto.
- Fecha real: 17 de agosto.
- Estado: `CONFIRMED`.

La fecha esperada no deberá modificarse para ocultar la diferencia entre lo
planificado y lo ocurrido.

La información de fecha deberá permitir posteriormente analizar
desviaciones entre la fecha esperada y la fecha real.

### 6.9.13 Importe esperado e importe real

Cuando un `Income` o `Expense` defina un importe esperado o de referencia,
dicho importe podrá utilizarse para generar las ocurrencias futuras.

Cada `Financial Event` deberá conservar el importe correspondiente a su
propia ocurrencia.

El importe real de una ocurrencia podrá diferir del importe esperado o de
referencia definido en `Income` o `Expense`.

Por ejemplo:

- Expense = Luz.
- Importe esperado = $800.
- Financial Event de agosto = $780.
- Financial Event de octubre = $920.

La modificación del importe esperado o de referencia no deberá modificar
automáticamente los eventos históricos ya registrados.

### 6.9.14 Eventos sin recurrencia

BudgetKeep deberá permitir registrar eventos financieros sin
`RecurrenceConfiguration`.

Un Usuario podrá registrar directamente un evento cuando:

- conozca una fecha específica;
- el evento sea único;
- no exista un patrón recurrente;
- la fecha no pueda determinarse mediante una regla recurrente;
- el evento ya haya ocurrido.

Un evento registrado directamente como ocurrido podrá quedar `CONFIRMED`
desde su creación, conforme a la información proporcionada por el Usuario.

### 6.9.15 Consulta mensual

BudgetKeep deberá permitir consultar los `Financial Event` correspondientes
a un periodo mensual.

La consulta deberá mostrar tanto:

- eventos `EXPECTED`; como
- eventos `CONFIRMED`.

La vista mensual deberá proporcionar al Usuario una visión de los eventos
financieros que espera que ocurran y de aquellos que ya confirmó.

La consulta mensual no deberá ocultar automáticamente eventos `EXPECTED`
cuya fecha esperada ya haya pasado.

### 6.9.16 Independencia del historial

Las modificaciones realizadas sobre una `RecurrenceConfiguration` deberán
afectar únicamente las futuras ocurrencias que todavía dependan de dicha
configuración.

Las modificaciones posteriores no deberán alterar la información histórica
de los `Financial Event` previamente registrados o confirmados.

Las ocurrencias históricas deberán conservar la información que correspondía
al momento en que fueron registradas o confirmadas.

### 6.9.17 Interacción mínima del Usuario

El diseño deberá minimizar el esfuerzo necesario para mantener actualizada
la Realidad Financiera.

Después de la configuración inicial de un `Income` o `Expense` recurrente,
el Usuario no deberá capturar manualmente las fechas de cada ocurrencia.

BudgetKeep deberá presentar las ocurrencias esperadas correspondientes al
periodo consultado.

La acción normal del Usuario deberá consistir en revisar las ocurrencias y
confirmar aquellas que efectivamente hayan ocurrido.

La confirmación deberá poder realizarse mediante una interacción simple
definida por la aplicación, sin requerir que el Usuario vuelva a capturar
toda la información del evento.

### 6.9.18 Relaciones principales del dominio

Las relaciones conceptuales principales serán:

- User 1:N Income.
- User 1:N Expense.
- User 1:N StandAlone.
- User 1:N Financial Event.
- Income 1:N Financial Event.
- Expense 1:N Financial Event.
- StandAlone 1:N Financial Event.
- Income 1:0..1 RecurrenceConfiguration.
- Expense 1:0..1 RecurrenceConfiguration.
- RecurrenceType 1:N RecurrenceConfiguration.

Un Financial Event deberá estar asociado exactamente a una de las siguientes
fuentes:

- Income.
- Expense.
- StandAlone.

Las relaciones específicas de `Financial Event` con otros dominios se
definirán cuando dichos dominios sean diseñados.

No se implementará una relación polimórfica genérica mediante
`ConceptType + ConceptId` para sustituir las Foreign Keys específicas.

### 6.9.19 Integridad y trazabilidad

Las relaciones entre `Financial Event` y las entidades que lo originan
deberán implementarse mediante relaciones explícitas que permitan mantener
integridad referencial.

Todo `Financial Event` deberá poder trazarse hasta exactamente una de sus
tres posibles fuentes:

- `Income`;
- `Expense`;
- `StandAlone`.

Los eventos generados a partir de `Income` o `Expense` deberán conservar la
trazabilidad con la definición que los originó.

Los eventos registrados directamente por el Usuario mediante `StandAlone`
deberán conservar la trazabilidad con el `StandAlone` que los originó.

La existencia de una configuración de recurrencia no deberá eliminar ni
modificar automáticamente las ocurrencias históricas.

Los cambios posteriores realizados sobre `Income`, `Expense`, `StandAlone` o
`RecurrenceConfiguration` no deberán modificar los `Financial Event`
históricos.

### 6.9.20 Alcance de la lógica de recurrencia

La presente sección establece la estructura persistente necesaria para
soportar la recurrencia y las ocurrencias financieras.

La lógica de aplicación responsable de:

- calcular las fechas futuras;
- generar las ocurrencias;
- evitar duplicados;
- determinar el horizonte de generación;
- presentar recordatorios;
- procesar la confirmación del Usuario;
- actualizar el estado del evento;

será definida por las disciplinas correspondientes de Backend y
Requerimientos Funcionales, manteniendo consistencia con las decisiones
establecidas en esta sección.

La base de datos deberá proporcionar las estructuras y restricciones
necesarias para soportar dicha lógica sin asumir responsabilidades propias
de la capa de aplicación.

### 6.9.21 Trazabilidad de las decisiones

Las decisiones de esta sección constituyen la línea base de diseño para
Financial Events y deberán reutilizarse sin reinterpretación en:

- el Modelo Lógico de Datos;
- el Modelo Físico de Datos;
- el Entity Relationship Diagram;
- los scripts SQL de creación;
- los scripts de Rollback;
- los scripts Seed, cuando aplique;
- la implementación del Backend;
- las pruebas funcionales y técnicas;
- la implementación en Azure SQL Database;
- las futuras decisiones de los dominios que se relacionen con Financial
  Events.

Cualquier modificación posterior deberá identificarse como una nueva
decisión de diseño, evaluar su impacto sobre los artefactos relacionados y
obtener la aprobación correspondiente antes de incorporarse a la
implementación.

### 6.9.22 Moneda histórica de Financial Event

Financial Event deberá conservar CurrencyId como parte de la información
histórica de la ocurrencia.

CurrencyId identificará la moneda en la que se expresa el importe del
Financial Event.

La Currency histórica del Financial Event no deberá modificarse como
consecuencia de cambios en:

- la Currency de preferencia del Usuario;
- la Base Currency del Usuario;
- las tasas de cambio de referencia posteriores.

Cuando un Financial Event se utilice como parte de un Payment, la Currency
del Financial Event deberá corresponder a la Currency de la Financial
Obligation atendida.

El Exchange Rate utilizado para financiar el Payment no se almacenará en
Financial Event.

## 6.10 Decisiones Físicas — Financial Events

El dominio Financial Events utilizará las decisiones físicas generales
aprobadas en la sección 6.6 y define las siguientes decisiones específicas
para sus entidades persistentes.

Las entidades físicas del dominio serán implementadas inicialmente en el
esquema `dbo`.

El dominio está compuesto por tres posibles fuentes de Financial Event:

- `Income`: definición de ingreso que podrá generar múltiples ocurrencias.
- `Expense`: definición de gasto que podrá generar múltiples ocurrencias.
- `StandAlone`: evento financiero registrado directamente por el Usuario,
  sin definición previa de Income o Expense y sin recurrencia.

`FinancialEvent` será la entidad central que persistirá las ocurrencias
financieras.

Las Foreign Keys utilizarán:

- `ON DELETE NO ACTION`.
- `ON UPDATE NO ACTION`.

La lógica para calcular recurrencias y generar ocurrencias futuras pertenece
a la capa de aplicación. La base de datos será responsable de preservar la
integridad estructural de la información generada.

### 6.10.1 Income

La tabla `Income` representa una definición persistente de ingreso
perteneciente a un User.

#### 6.10.1.1 Columnas

- `IncomeId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `UserId` utilizará `BIGINT` y será `NOT NULL`.
- `Name` utilizará `NVARCHAR(150)` y será `NOT NULL`.
- `IncomeTypeId` utilizará `BIGINT` y será `NOT NULL`.
- `CurrencyId` utilizará `BIGINT` y será `NOT NULL`.
- `ExpectedAmount` utilizará `DECIMAL(19,4)` y será `NULL`.
- `IsActive` utilizará `BIT` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT` y será `NULL`.
- `UpdatedAt` utilizará `DATETIME2(3)` y será `NULL`.
- `UpdatedBy` utilizará `BIGINT` y será `NULL`.
- `DeletedAt` utilizará `DATETIME2(3)` y será `NULL`.
- `DeletedBy` utilizará `BIGINT` y será `NULL`.

#### 6.10.1.2 Primary Key

- `PK_Income` será la Primary Key de `Income` sobre `IncomeId`.

#### 6.10.1.3 Foreign Keys

- `FK_Income_User`:
  `Income.UserId` → `User.UserId`.
- `FK_Income_IncomeType`:
  `Income.IncomeTypeId` → `IncomeType.IncomeTypeId`.
- `FK_Income_Currency`:
  `Income.CurrencyId` → `Currency.CurrencyId`.
- `FK_Income_CreatedBy`:
  `Income.CreatedBy` → `User.UserId`.
- `FK_Income_UpdatedBy`:
  `Income.UpdatedBy` → `User.UserId`.
- `FK_Income_DeletedBy`:
  `Income.DeletedBy` → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### 6.10.1.4 Defaults

- `DF_Income_IsActive` → `1`.
- `DF_Income_CreatedAt` → `SYSUTCDATETIME()`.

No se establecerá un valor por defecto para `ExpectedAmount`.

#### 6.10.1.5 Unique Constraints

No se establecerá una restricción `UNIQUE` sobre `Name`.

Un User podrá tener más de una definición de Income con el mismo nombre.

#### 6.10.1.6 Check Constraints

No se requiere un `CHECK` adicional para `Income` en esta etapa.

Las reglas estructurales de recurrencia serán implementadas mediante
`RecurrenceConfiguration`.

#### 6.10.1.7 Índices

Se crearán:

- `IX_Income_UserId` sobre `Income(UserId)`.
- `IX_Income_IncomeTypeId` sobre `Income(IncomeTypeId)`.
- `IX_Income_CurrencyId` sobre `Income(CurrencyId)`.

No se crearán índices adicionales sobre `Name`, `ExpectedAmount`,
`IsActive` o columnas de auditoría sin evidencia de un patrón de consulta
que lo justifique.

#### 6.10.1.8 Reglas de Persistencia

- Una definición de Income podrá existir sin Financial Event.
- Una definición de Income podrá generar múltiples Financial Event.
- Una definición de Income podrá tener como máximo una
  RecurrenceConfiguration.
- `ExpectedAmount` representa un importe esperado o de referencia.
- La modificación de Income no deberá modificar Financial Event históricos.
- Un cambio de moneda no deberá utilizarse para modificar el significado
  monetario de una definición existente.
- Si el Usuario necesita representar el mismo concepto en otra moneda,
  deberá crearse una nueva definición de Income.
- La eliminación funcional utilizará eliminación lógica mediante
  `DeletedAt` y `DeletedBy`.

---

### 6.10.2 Expense

La tabla `Expense` representa una definición persistente de gasto
perteneciente a un User.

#### 6.10.2.1 Columnas

- `ExpenseId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `UserId` utilizará `BIGINT` y será `NOT NULL`.
- `Name` utilizará `NVARCHAR(150)` y será `NOT NULL`.
- `ExpenseCategoryId` utilizará `BIGINT` y será `NOT NULL`.
- `ExpenseType` utilizará `VARCHAR(50)` y será `NOT NULL`.
- `CurrencyId` utilizará `BIGINT` y será `NOT NULL`.
- `ExpectedAmount` utilizará `DECIMAL(19,4)` y será `NULL`.
- `IsActive` utilizará `BIT` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT` y será `NULL`.
- `UpdatedAt` utilizará `DATETIME2(3)` y será `NULL`.
- `UpdatedBy` utilizará `BIGINT` y será `NULL`.
- `DeletedAt` utilizará `DATETIME2(3)` y será `NULL`.
- `DeletedBy` utilizará `BIGINT` y será `NULL`.

#### 6.10.2.2 Primary Key

- `PK_Expense` será la Primary Key de `Expense` sobre `ExpenseId`.

#### 6.10.2.3 Foreign Keys

- `FK_Expense_User`:
  `Expense.UserId` → `User.UserId`.
- `FK_Expense_ExpenseCategory`:
  `Expense.ExpenseCategoryId` → `ExpenseCategory.ExpenseCategoryId`.
- `FK_Expense_Currency`:
  `Expense.CurrencyId` → `Currency.CurrencyId`.
- `FK_Expense_CreatedBy`:
  `Expense.CreatedBy` → `User.UserId`.
- `FK_Expense_UpdatedBy`:
  `Expense.UpdatedBy` → `User.UserId`.
- `FK_Expense_DeletedBy`:
  `Expense.DeletedBy` → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### 6.10.2.4 Defaults

- `DF_Expense_IsActive` → `1`.
- `DF_Expense_CreatedAt` → `SYSUTCDATETIME()`.

No se establecerá un valor por defecto para `ExpectedAmount`.

#### 6.10.2.5 Check Constraints

- `CK_Expense_ExpenseType` deberá limitar `ExpenseType` a los valores
  funcionales aprobados:
  - `FIXED`
  - `VARIABLE`

#### 6.10.2.6 Índices

Se crearán:

- `IX_Expense_UserId` sobre `Expense(UserId)`.
- `IX_Expense_ExpenseCategoryId` sobre `Expense(ExpenseCategoryId)`.
- `IX_Expense_CurrencyId` sobre `Expense(CurrencyId)`.

No se crearán índices adicionales sobre `Name`, `ExpectedAmount`,
`IsActive` o columnas de auditoría sin evidencia de un patrón de consulta
que lo justifique.

#### 6.10.2.7 Reglas de Persistencia

- Una definición de Expense podrá existir sin Financial Event.
- Una definición de Expense podrá generar múltiples Financial Event.
- Una definición de Expense podrá tener como máximo una
  RecurrenceConfiguration.
- `ExpectedAmount` representa un importe esperado o de referencia.
- La modificación de Expense no deberá modificar Financial Event históricos.
- Un cambio de moneda no deberá utilizarse para modificar el significado
  monetario de una definición existente.
- Si el Usuario necesita representar el mismo concepto en otra moneda,
  deberá crearse una nueva definición de Expense.
- La eliminación funcional utilizará eliminación lógica mediante
  `DeletedAt` y `DeletedBy`.

---

### 6.10.3 StandAlone

La tabla `StandAlone` representa un evento financiero registrado
directamente por el Usuario que no proviene de una definición previa de
Income o Expense y no utiliza recurrencia.

Un StandAlone podrá originar múltiples Financial Event.

#### 6.10.3.1 Columnas

- `StandAloneId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `UserId` utilizará `BIGINT` y será `NOT NULL`.
- `EventType` utilizará `VARCHAR(20)` y será `NOT NULL`.
- `Description` utilizará `NVARCHAR(500)` y será `NOT NULL`.
- `CurrencyId` utilizará `BIGINT` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT` y será `NULL`.
- `UpdatedAt` utilizará `DATETIME2(3)` y será `NULL`.
- `UpdatedBy` utilizará `BIGINT` y será `NULL`.
- `DeletedAt` utilizará `DATETIME2(3)` y será `NULL`.
- `DeletedBy` utilizará `BIGINT` y será `NULL`.

#### 6.10.3.2 Primary Key

- `PK_StandAlone` será la Primary Key de `StandAlone` sobre `StandAloneId`.

#### 6.10.3.3 Foreign Keys

- `FK_StandAlone_User`:
  `StandAlone.UserId` → `User.UserId`.
- `FK_StandAlone_Currency`:
  `StandAlone.CurrencyId` → `Currency.CurrencyId`.
- `FK_StandAlone_CreatedBy`:
  `StandAlone.CreatedBy` → `User.UserId`.
- `FK_StandAlone_UpdatedBy`:
  `StandAlone.UpdatedBy` → `User.UserId`.
- `FK_StandAlone_DeletedBy`:
  `StandAlone.DeletedBy` → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### 6.10.3.4 Defaults

- `DF_StandAlone_CreatedAt` → `SYSUTCDATETIME()`.

#### 6.10.3.5 Check Constraints

- `CK_StandAlone_EventType` deberá limitar `EventType` a:
  - `INCOME`
  - `EXPENSE`

#### 6.10.3.6 Índices

Se crearán:

- `IX_StandAlone_UserId` sobre `StandAlone(UserId)`.
- `IX_StandAlone_CurrencyId` sobre `StandAlone(CurrencyId)`.

No se crearán índices adicionales sobre `Description` o columnas de
auditoría sin evidencia de un patrón de consulta que lo justifique.

#### 6.10.3.7 Reglas de Persistencia

- StandAlone no tendrá RecurrenceConfiguration.
- Un StandAlone podrá originar múltiples Financial Event.
- StandAlone no generará automáticamente nuevas ocurrencias mediante una
  configuración de recurrencia.
- Una nueva ocurrencia del mismo evento podrá registrarse utilizando el mismo
  StandAlone como fuente.
- StandAlone representa una fuente no recurrente.
- `EventType` determinará si el evento corresponde a INCOME o EXPENSE.
- La moneda pertenece al StandAlone.
- Si el Usuario necesita registrar el mismo concepto en otra moneda,
  deberá crearse un nuevo StandAlone.
- La eliminación funcional utilizará eliminación lógica mediante
  `DeletedAt` y `DeletedBy`.

---

### 6.10.4 FinancialEvent

`FinancialEvent` será la entidad central que persistirá las ocurrencias
financieras.

Cada Financial Event deberá tener exactamente una fuente:

- Income;
- Expense;
- StandAlone.

#### 6.10.4.1 Columnas

- `FinancialEventId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `UserId` utilizará `BIGINT` y será `NOT NULL`.
- `EventType` utilizará `VARCHAR(20)` y será `NOT NULL`.
- `IncomeId` utilizará `BIGINT` y será `NULL`.
- `ExpenseId` utilizará `BIGINT` y será `NULL`.
- `StandAloneId` utilizará `BIGINT` y será `NULL`.
- `CurrencyId` utilizará `BIGINT` y será `NOT NULL`.
- `RelatedEntityId` utilizará `BIGINT` y será `NULL`.
- `ExpectedDate` utilizará `DATE` y será `NOT NULL`.
- `ActualDate` utilizará `DATE` y será `NULL`.
- `ExpectedAmount` utilizará `DECIMAL(19,4)` y será `NULL`.
- `ActualAmount` utilizará `DECIMAL(19,4)` y será `NULL`.
- `EventStatus` utilizará `VARCHAR(20)` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT` y será `NULL`.
- `UpdatedAt` utilizará `DATETIME2(3)` y será `NULL`.
- `UpdatedBy` utilizará `BIGINT` y será `NULL`.
- `DeletedAt` utilizará `DATETIME2(3)` y será `NULL`.
- `DeletedBy` utilizará `BIGINT` y será `NULL`.

#### 6.10.4.2 Primary Key

- `PK_FinancialEvent` será la Primary Key de `FinancialEvent` sobre
  `FinancialEventId`.

#### 6.10.4.3 Foreign Keys

- `FK_FinancialEvent_User`:
  `FinancialEvent.UserId` → `User.UserId`.
- `FK_FinancialEvent_Income`:
  `FinancialEvent.IncomeId` → `Income.IncomeId`.
- `FK_FinancialEvent_Expense`:
  `FinancialEvent.ExpenseId` → `Expense.ExpenseId`.
- `FK_FinancialEvent_StandAlone`:
  `FinancialEvent.StandAloneId` → `StandAlone.StandAloneId`.
- `FK_FinancialEvent_Currency`:
  `FinancialEvent.CurrencyId` → `Currency.CurrencyId`.
- `FK_FinancialEvent_RelatedEntity`:
  `FinancialEvent.RelatedEntityId` → `RelatedEntity.RelatedEntityId`.
- `FK_FinancialEvent_CreatedBy`:
  `FinancialEvent.CreatedBy` → `User.UserId`.
- `FK_FinancialEvent_UpdatedBy`:
  `FinancialEvent.UpdatedBy` → `User.UserId`.
- `FK_FinancialEvent_DeletedBy`:
  `FinancialEvent.DeletedBy` → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### 6.10.4.4 Check Constraints

`CK_FinancialEvent_Source` deberá garantizar que exactamente una fuente
esté informada y que `EventType` sea consistente con la fuente: ```text
(
    EventType = 'INCOME'
    AND IncomeId IS NOT NULL
    AND ExpenseId IS NULL
    AND StandAloneId IS NULL
)
OR
(
    EventType = 'EXPENSE'
    AND IncomeId IS NULL
    AND ExpenseId IS NOT NULL
    AND StandAloneId IS NULL
)
OR
(
    StandAloneId IS NOT NULL
    AND IncomeId IS NULL
    AND ExpenseId IS NULL
)

`CK_FinancialEvent_Status` deberá garantizar:

- `EXPECTED`:
  - `ActualDate IS NULL`
  - `ActualAmount IS NULL`

- `CONFIRMED`:
  - `ActualDate IS NOT NULL`
  - `ActualAmount IS NOT NULL`

#### 6.10.4.5 Defaults

- `DF_FinancialEvent_CreatedAt` → `SYSUTCDATETIME()`.

#### 6.10.4.6 Índices

Se crearán:

- `IX_FinancialEvent_UserId` sobre `FinancialEvent(UserId)`.
- `IX_FinancialEvent_IncomeId` sobre `FinancialEvent(IncomeId)`.
- `IX_FinancialEvent_ExpenseId` sobre `FinancialEvent(ExpenseId)`.
- `IX_FinancialEvent_StandAloneId` sobre `FinancialEvent(StandAloneId)`.
- `IX_FinancialEvent_CurrencyId` sobre `FinancialEvent(CurrencyId)`.
- `IX_FinancialEvent_RelatedEntityId` sobre `FinancialEvent(RelatedEntityId)`.

## 6.11 Decisiones Físicas — Financial Planning

El dominio Financial Planning utilizará las decisiones físicas generales
aprobadas en la sección 6.6 y las decisiones de auditoría e historial
definidas en las secciones generales de esta especificación.

Las entidades físicas del dominio serán implementadas inicialmente en el
esquema `dbo`.

Las Foreign Keys utilizarán:

- `ON DELETE NO ACTION`.
- `ON UPDATE NO ACTION`.

Financial Strategy será tratada como una recomendación generada por
BudgetKeep y deberá conservarse como información histórica.

Financial Plan será tratado como información perteneciente al Usuario y
deberá conservar los Planes FINALIZED para consultas históricas.

Las entidades asociativas utilizarán Primary Keys compuestas cuando no
requieran identidad propia.

Los valores calculados relacionados con el avance del Plan no serán
persistidos. El avance deberá obtenerse mediante consultas y agregaciones
sobre Financial Plan Item Event y Financial Event.

### 6.11.1 FinancialStrategy

#### Columnas

- `FinancialStrategyId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `UserId` utilizará `BIGINT` y será `NOT NULL`.
- `Name` utilizará `NVARCHAR(150)` y será `NOT NULL`.
- `Objective` utilizará `NVARCHAR(500)` y será `NOT NULL`.
- `Description` utilizará `NVARCHAR(500)` y será `NOT NULL`.
- `RecommendedPriority` utilizará `INT` y será `NULL`.
- `ExpectedBenefits` utilizará `NVARCHAR(500)` y será `NULL`.
- `Considerations` utilizará `NVARCHAR(500)` y será `NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL`.

#### Primary Key

- `PK_FinancialStrategy` sobre `FinancialStrategyId`.

#### Foreign Keys

- `FinancialStrategy.UserId` → `User.UserId`.
- `FinancialStrategy.CreatedBy` → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### Defaults

- `CreatedAt` → `SYSUTCDATETIME()`.

### 6.11.2 FinancialStrategyItem

#### Columnas

- `FinancialStrategyItemId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `FinancialStrategyId` utilizará `BIGINT` y será `NOT NULL`.
- `SequenceNumber` utilizará `INT` y será `NOT NULL`.
- `Description` utilizará `NVARCHAR(500)` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL`.

#### Primary Key

- `PK_FinancialStrategyItem` sobre `FinancialStrategyItemId`.

#### Foreign Keys

- `FinancialStrategyItem.FinancialStrategyId`
  → `FinancialStrategy.FinancialStrategyId`.
- `FinancialStrategyItem.CreatedBy`
  → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### Defaults

- `CreatedAt` → `SYSUTCDATETIME()`.

#### Constraints

- `SequenceNumber` deberá ser mayor que cero.
- La combinación `FinancialStrategyId + SequenceNumber` deberá ser única.

### 6.11.3 FinancialPlan

#### Columnas

- `FinancialPlanId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `UserId` utilizará `BIGINT` y será `NOT NULL`.
- `Name` utilizará `NVARCHAR(150)` y será `NOT NULL`.
- `Objective` utilizará `NVARCHAR(500)` y será `NOT NULL`.
- `StartDate` utilizará `DATE` y será `NOT NULL`.
- `ReviewDate` utilizará `DATE` y será `NULL`.
- `LifecycleStatus` utilizará `VARCHAR(20)` y será `NOT NULL`.
- `UserNotes` utilizará `NVARCHAR(500)` y será `NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL`.
- `UpdatedAt` utilizará `DATETIME2(3) NULL`.
- `UpdatedBy` utilizará `BIGINT NULL`.

#### Primary Key

- `PK_FinancialPlan` sobre `FinancialPlanId`.

#### Foreign Keys

- `FinancialPlan.UserId` → `User.UserId`.
- `FinancialPlan.CreatedBy` → `User.UserId`.
- `FinancialPlan.UpdatedBy` → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### Defaults

- `CreatedAt` → `SYSUTCDATETIME()`.

#### Constraints

- `LifecycleStatus` deberá admitir únicamente `ACTIVE` o `FINALIZED`.
- `ReviewDate`, cuando exista, no deberá ser anterior a `StartDate`.

### 6.11.4 FinancialPlanItem

#### Columnas

- `FinancialPlanItemId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `FinancialPlanId` utilizará `BIGINT` y será `NOT NULL`.
- `SequenceNumber` utilizará `INT` y será `NOT NULL`.
- `Description` utilizará `NVARCHAR(500)` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL`.
- `UpdatedAt` utilizará `DATETIME2(3) NULL`.
- `UpdatedBy` utilizará `BIGINT NULL`.
- `DeletedAt` utilizará `DATETIME2(3) NULL`.
- `DeletedBy` utilizará `BIGINT NULL`.

#### Primary Key

- `PK_FinancialPlanItem` sobre `FinancialPlanItemId`.

#### Foreign Keys

- `FinancialPlanItem.FinancialPlanId`
  → `FinancialPlan.FinancialPlanId`.
- `FinancialPlanItem.CreatedBy`
  → `User.UserId`.
- `FinancialPlanItem.UpdatedBy`
  → `User.UserId`.
- `FinancialPlanItem.DeletedBy`
  → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### Defaults

- `CreatedAt` → `SYSUTCDATETIME()`.

#### Constraints

- `SequenceNumber` deberá ser mayor que cero.
- La combinación `FinancialPlanId + SequenceNumber` deberá ser única
  entre los registros activos.

### 6.11.5 FinancialPlanStrategy

#### Columnas

- `FinancialPlanId` utilizará `BIGINT` y será `NOT NULL`.
- `FinancialStrategyId` utilizará `BIGINT` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL`.

#### Primary Key

- La combinación `FinancialPlanId + FinancialStrategyId`.

#### Foreign Keys

- `FinancialPlanStrategy.FinancialPlanId`
  → `FinancialPlan.FinancialPlanId`.
- `FinancialPlanStrategy.FinancialStrategyId`
  → `FinancialStrategy.FinancialStrategyId`.
- `FinancialPlanStrategy.CreatedBy`
  → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### Defaults

- `CreatedAt` → `SYSUTCDATETIME()`.

### 6.11.6 FinancialPlanResource

#### Columnas

- `FinancialPlanId` utilizará `BIGINT` y será `NOT NULL`.
- `FinancialResourceId` utilizará `BIGINT` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL`.

#### Primary Key

- La combinación `FinancialPlanId + FinancialResourceId`.

#### Foreign Keys

- `FinancialPlanResource.FinancialPlanId`
  → `FinancialPlan.FinancialPlanId`.
- `FinancialPlanResource.FinancialResourceId`
  → `FinancialResource.FinancialResourceId`.
- `FinancialPlanResource.CreatedBy`
  → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### Defaults

- `CreatedAt` → `SYSUTCDATETIME()`.

### 6.11.7 FinancialPlanItemEvent

#### Columnas

- `FinancialPlanItemId` utilizará `BIGINT` y será `NOT NULL`.
- `FinancialEventId` utilizará `BIGINT` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL`.

#### Primary Key

- La combinación `FinancialPlanItemId + FinancialEventId`.

#### Foreign Keys

- `FinancialPlanItemEvent.FinancialPlanItemId`
  → `FinancialPlanItem.FinancialPlanItemId`.
- `FinancialPlanItemEvent.FinancialEventId`
  → `FinancialEvent.FinancialEventId`.
- `FinancialPlanItemEvent.CreatedBy`
  → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### Defaults

- `CreatedAt` → `SYSUTCDATETIME()`.

### 6.11.8 Índices

Se deberán crear índices secundarios sobre:

- `FinancialStrategy.UserId`.
- `FinancialStrategyItem.FinancialStrategyId`.
- `FinancialPlan.UserId`.
- `FinancialPlan.LifecycleStatus`.
- `FinancialPlanItem.FinancialPlanId`.
- `FinancialPlanStrategy.FinancialStrategyId`.
- `FinancialPlanResource.FinancialResourceId`.
- `FinancialPlanItemEvent.FinancialEventId`.

Las combinaciones utilizadas como Primary Key deberán proporcionar
la cobertura necesaria para las consultas por clave compuesta.

### 6.11.9 Reglas de propiedad del Usuario

La aplicación deberá garantizar que los registros relacionados dentro de
Financial Planning pertenezcan al mismo User.

La base de datos deberá preservar las Foreign Keys directas de cada entidad.

La validación de consistencia entre propietarios a través de entidades
asociativas será reforzada mediante la lógica de aplicación y validaciones
de integridad definidas para el dominio.

### 6.11.10 Historial de Financial Plan

Financial Plan no será eliminado físicamente como consecuencia de su
finalización.

El estado `FINALIZED` conservará el Plan y sus relaciones históricas.

El avance del Plan no se almacenará como un valor persistente independiente.

Deberá calcularse a partir de Financial Plan Item y Financial Plan Item Event.

### 6.11.11 Trazabilidad de las decisiones

Las decisiones de esta sección constituyen la línea base física para
Financial Planning y deberán reutilizarse sin reinterpretación en:

- el Modelo Físico de Datos;
- el Entity Relationship Diagram;
- los scripts SQL;
- los scripts de Rollback;
- los scripts Seed, cuando aplique;
- la implementación Backend;
- las validaciones;
- la implementación en Azure SQL Database.

Cualquier modificación posterior deberá identificarse como una nueva
decisión de diseño y seguir el proceso de gobernanza correspondiente.

## 6.12 Decisiones Físicas — Financial Obligations

El dominio Financial Obligations utilizará las decisiones físicas generales
aprobadas en la presente especificación y las decisiones de auditoría e
historial definidas en las secciones generales correspondientes.

Las entidades físicas del dominio serán implementadas inicialmente en el
esquema `dbo`.

Las Foreign Keys utilizarán:

- `ON DELETE NO ACTION`.
- `ON UPDATE NO ACTION`.

Los importes monetarios utilizarán `DECIMAL(19,4)`.

Las fechas de negocio que representen únicamente una fecha de calendario
utilizarán `DATE`.

Los atributos de auditoría utilizarán las convenciones generales definidas
para el modelo.

### 6.12.1 Financial Obligation

`FinancialObligation` se implementará como una tabla física en el esquema
`dbo`.

#### 6.12.1.1 Columnas

- `FinancialObligationId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `UserId` utilizará `BIGINT` y será `NOT NULL`.
- `Name` utilizará `NVARCHAR(150)` y será `NOT NULL`.
- `FinancialObligationTypeId` utilizará `BIGINT` y será `NOT NULL`.
- `DebtId` utilizará `BIGINT` y será `NULL`.
- `Amount` utilizará `DECIMAL(19,4)` y será `NOT NULL`.
- `CurrencyId` utilizará `BIGINT` y será `NOT NULL`.
- `FinancialPriorityId` utilizará `BIGINT` y será `NULL`.
- `DueDate` utilizará `DATE` y será `NULL`.
- `LifecycleStatus` utilizará `VARCHAR(20)` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL`.
- `UpdatedAt` utilizará `DATETIME2(3) NULL`.
- `UpdatedBy` utilizará `BIGINT NULL`.
- `DeletedAt` utilizará `DATETIME2(3) NULL`.
- `DeletedBy` utilizará `BIGINT NULL`.

#### 6.12.1.2 Primary Key

- `PK_FinancialObligation` será la Primary Key de
  `FinancialObligation(FinancialObligationId)`.

#### 6.12.1.3 Foreign Keys

- `FK_FinancialObligation_User`:
  `FinancialObligation.UserId` → `User.UserId`.
- `FK_FinancialObligation_Type`:
  `FinancialObligation.FinancialObligationTypeId`
  → `FinancialObligationType.FinancialObligationTypeId`.
- `FK_FinancialObligation_Debt`:
  `FinancialObligation.DebtId` → `Debt.DebtId`.
- `FK_FinancialObligation_Currency`:
  `FinancialObligation.CurrencyId` → `Currency.CurrencyId`.
- `FK_FinancialObligation_Priority`:
  `FinancialObligation.FinancialPriorityId`
  → `FinancialPriority.FinancialPriorityId`.
- `FK_FinancialObligation_CreatedBy`:
  `FinancialObligation.CreatedBy` → `User.UserId`.
- `FK_FinancialObligation_UpdatedBy`:
  `FinancialObligation.UpdatedBy` → `User.UserId`.
- `FK_FinancialObligation_DeletedBy`:
  `FinancialObligation.DeletedBy` → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### 6.12.1.4 Defaults

- `DF_FinancialObligation_CreatedAt` → `SYSUTCDATETIME()`.

#### 6.12.1.5 Check Constraints

- `CK_FinancialObligation_Amount` deberá garantizar que `Amount >= 0`.

#### 6.12.1.6 Índices

Se crearán:

- `IX_FinancialObligation_UserId` sobre
  `FinancialObligation(UserId)`.
- `IX_FinancialObligation_DebtId` sobre
  `FinancialObligation(DebtId)`.
- `IX_FinancialObligation_CurrencyId` sobre
  `FinancialObligation(CurrencyId)`.
- `IX_FinancialObligation_FinancialPriorityId` sobre
  `FinancialObligation(FinancialPriorityId)`.
- `IX_FinancialObligation_DueDate` sobre
  `FinancialObligation(DueDate)`.
- `IX_FinancialObligation_LifecycleStatus` sobre
  `FinancialObligation(LifecycleStatus)`.

#### 6.12.1.7 Reglas de Persistencia

- El importe comprometido de la obligación no será reemplazado por Payments.
- La Currency original de la obligación será histórica.
- Una Financial Obligation podrá existir sin Debt.
- Una Financial Obligation podrá recibir múltiples Payments.
- El estado financiero no se almacenará como una copia independiente.

### 6.12.2 Payment

`Payment` se implementará como una tabla física en el esquema `dbo`.

#### 6.12.2.1 Columnas

- `PaymentId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `UserId` utilizará `BIGINT` y será `NOT NULL`.
- `FinancialObligationId` utilizará `BIGINT` y será `NOT NULL`.
- `FinancialEventId` utilizará `BIGINT` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL`.
- `UpdatedAt` utilizará `DATETIME2(3) NULL`.
- `UpdatedBy` utilizará `BIGINT NULL`.
- `DeletedAt` utilizará `DATETIME2(3) NULL`.
- `DeletedBy` utilizará `BIGINT NULL`.

Payment no almacenará importe, fecha ni Currency.

Estos valores se obtendrán del Financial Event asociado.

#### 6.12.2.2 Primary Key

- `PK_Payment` será la Primary Key de `Payment(PaymentId)`.

#### 6.12.2.3 Foreign Keys

- `FK_Payment_User`:
  `Payment.UserId` → `User.UserId`.
- `FK_Payment_FinancialObligation`:
  `Payment.FinancialObligationId`
  → `FinancialObligation.FinancialObligationId`.
- `FK_Payment_FinancialEvent`:
  `Payment.FinancialEventId` → `FinancialEvent.FinancialEventId`.
- `FK_Payment_CreatedBy`:
  `Payment.CreatedBy` → `User.UserId`.
- `FK_Payment_UpdatedBy`:
  `Payment.UpdatedBy` → `User.UserId`.
- `FK_Payment_DeletedBy`:
  `Payment.DeletedBy` → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### 6.12.2.4 Defaults

- `DF_Payment_CreatedAt` → `SYSUTCDATETIME()`.

#### 6.12.2.5 Índices

Se crearán:

- `IX_Payment_UserId` sobre `Payment(UserId)`.
- `IX_Payment_FinancialObligationId` sobre
  `Payment(FinancialObligationId)`.
- `UX_Payment_FinancialEventId` sobre
  `Payment(FinancialEventId)`.

`FinancialEventId` será único porque un Financial Event podrá estar asociado
como máximo a un Payment.

#### 6.12.2.6 Reglas de Persistencia

- Cada Payment deberá atender exactamente una Financial Obligation.
- Una Financial Obligation podrá recibir múltiples Payments.
- Un Payment podrá representar un pago total o parcial.
- Payment no será una proyección.
- El Financial Event asociado deberá estar CONFIRMED.
- El Financial Event asociado deberá tener `EventType = EXPENSE`.
- No existirá `PaymentObligation`.
- Si una operación atiende múltiples Financial Obligations, se registrará un
  Payment independiente para cada obligación.

### 6.12.3 Financial Event

Financial Event ya se encuentra físicamente definido y validado dentro del
dominio Financial Events.

Financial Obligations utilizará `FinancialEvent.FinancialEventId` como
referencia desde Payment.

No se duplicarán en Payment:

- ActualDate;
- ActualAmount;
- CurrencyId.

El Payment utilizará el Financial Event confirmado como fuente de la
realidad financiera de la operación.

La Foreign Key será:

- `Payment.FinancialEventId` → `FinancialEvent.FinancialEventId`.

La relación será única del lado de Payment mediante un índice UNIQUE sobre
`Payment.FinancialEventId`.

### 6.12.4 Financial Resource

Financial Resource ya se encuentra físicamente definido y validado dentro
del dominio Financial Resources.

Payment Resource utilizará `FinancialResource.FinancialResourceId` como
referencia al recurso utilizado para financiar un Payment.

No se modificará la estructura física de Financial Resource como parte de
Financial Obligations.

La Currency utilizada por `AmountUsed` será la Currency del
Financial Resource relacionado.

### 6.12.5 Related Entity

`RelatedEntity` se implementará como una tabla física en el esquema `dbo`.

#### 6.12.5.1 Columnas

- `RelatedEntityId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `UserId` utilizará `BIGINT` y será `NOT NULL`.
- `Name` utilizará `NVARCHAR(150)` y será `NOT NULL`.
- `RelatedEntityTypeId` utilizará `BIGINT` y será `NOT NULL`.
- `LifecycleStatus` utilizará `VARCHAR(20)` y será `NOT NULL`.
- `Notes` utilizará `NVARCHAR(500)` y será `NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL`.
- `UpdatedAt` utilizará `DATETIME2(3) NULL`.
- `UpdatedBy` utilizará `BIGINT NULL`.
- `DeletedAt` utilizará `DATETIME2(3) NULL`.
- `DeletedBy` utilizará `BIGINT NULL`.

#### 6.12.5.2 Primary Key

- `PK_RelatedEntity` será la Primary Key de
  `RelatedEntity(RelatedEntityId)`.

#### 6.12.5.3 Foreign Keys

- `FK_RelatedEntity_User`:
  `RelatedEntity.UserId` → `User.UserId`.
- `FK_RelatedEntity_Type`:
  `RelatedEntity.RelatedEntityTypeId`
  → `RelatedEntityType.RelatedEntityTypeId`.
- `FK_RelatedEntity_CreatedBy`:
  `RelatedEntity.CreatedBy` → `User.UserId`.
- `FK_RelatedEntity_UpdatedBy`:
  `RelatedEntity.UpdatedBy` → `User.UserId`.
- `FK_RelatedEntity_DeletedBy`:
  `RelatedEntity.DeletedBy` → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### 6.12.5.4 Defaults

- `DF_RelatedEntity_CreatedAt` → `SYSUTCDATETIME()`.

#### 6.12.5.5 Índices

Se crearán:

- `IX_RelatedEntity_UserId` sobre `RelatedEntity(UserId)`.
- `IX_RelatedEntity_RelatedEntityTypeId` sobre
  `RelatedEntity(RelatedEntityTypeId)`.

#### 6.12.5.6 Reglas de Persistencia

- Related Entity pertenecerá a un único User.
- Related Entity podrá asociarse a múltiples Financial Events.
- Related Entity podrá asociarse a múltiples Debts.
- Related Entity no se asociará directamente a Payment.
- Related Entity no se asociará directamente a Financial Obligation.
- La eliminación funcional utilizará `DeletedAt` y `DeletedBy`.

### 6.12.6 Recurrence

`FinancialObligationRecurrenceConfiguration` se implementará como una tabla
física en el esquema `dbo`.

#### 6.12.6.1 Columnas

- `FinancialObligationRecurrenceConfigurationId` utilizará
  `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `FinancialObligationId` utilizará `BIGINT` y será `NOT NULL`.
- `RecurrenceTypeId` utilizará `BIGINT` y será `NOT NULL`.
- `StartDate` utilizará `DATE` y será `NOT NULL`.
- `EndDate` utilizará `DATE` y será `NULL`.
- `DayOfMonth` utilizará `INT` y será `NULL`.
- `DayOfWeek` utilizará `INT` y será `NULL`.
- `AnchorDate` utilizará `DATE` y será `NULL`.
- `IsActive` utilizará `BIT` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL`.
- `UpdatedAt` utilizará `DATETIME2(3) NULL`.
- `UpdatedBy` utilizará `BIGINT NULL`.
- `DeletedAt` utilizará `DATETIME2(3) NULL`.
- `DeletedBy` utilizará `BIGINT NULL`.

#### 6.12.6.2 Primary Key

- `PK_FinancialObligationRecurrenceConfiguration` será la Primary Key de
  `FinancialObligationRecurrenceConfiguration
  (FinancialObligationRecurrenceConfigurationId)`.

#### 6.12.6.3 Foreign Keys

- `FK_FinancialObligationRecurrenceConfiguration_Obligation`:
  `FinancialObligationRecurrenceConfiguration.FinancialObligationId`
  → `FinancialObligation.FinancialObligationId`.
- `FK_FinancialObligationRecurrenceConfiguration_RecurrenceType`:
  `FinancialObligationRecurrenceConfiguration.RecurrenceTypeId`
  → `RecurrenceType.RecurrenceTypeId`.
- `FK_FinancialObligationRecurrenceConfiguration_CreatedBy`:
  `CreatedBy` → `User.UserId`.
- `FK_FinancialObligationRecurrenceConfiguration_UpdatedBy`:
  `UpdatedBy` → `User.UserId`.
- `FK_FinancialObligationRecurrenceConfiguration_DeletedBy`:
  `DeletedBy` → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### 6.12.6.4 Defaults

- `DF_FinancialObligationRecurrenceConfiguration_CreatedAt`
  → `SYSUTCDATETIME()`.

#### 6.12.6.5 Check Constraints

- `CK_FinancialObligationRecurrenceConfiguration_DateRange` deberá
  garantizar que, cuando `EndDate` esté informado,
  `EndDate >= StartDate`.

#### 6.12.6.6 Índices

Se crearán:

- `IX_FinancialObligationRecurrenceConfiguration_FinancialObligationId`
  sobre `FinancialObligationRecurrenceConfiguration(FinancialObligationId)`.
- `IX_FinancialObligationRecurrenceConfiguration_RecurrenceTypeId`
  sobre `FinancialObligationRecurrenceConfiguration(RecurrenceTypeId)`.

Se creará una restricción UNIQUE sobre
`FinancialObligationId` para garantizar como máximo una configuración
persistente por Financial Obligation.

#### 6.12.6.7 Reglas de Persistencia

- Una Financial Obligation podrá tener como máximo una configuración.
- La configuración será independiente de RecurrenceConfiguration de
  Financial Events.
- La modificación de la configuración no modificará obligaciones históricas.
- Los parámetros de recurrencia se validarán de acuerdo con el
  RecurrenceType seleccionado.

### 6.12.7 Payment Resource

`PaymentResource` se implementará como una tabla física en el esquema `dbo`.

#### 6.12.7.1 Columnas

- `PaymentResourceId` utilizará `BIGINT IDENTITY(1,1)` y será `NOT NULL`.
- `PaymentId` utilizará `BIGINT` y será `NOT NULL`.
- `FinancialResourceId` utilizará `BIGINT` y será `NOT NULL`.
- `AmountUsed` utilizará `DECIMAL(19,4)` y será `NOT NULL`.
- `ExchangeRate` utilizará `DECIMAL(19,8)` y será `NOT NULL`.
- `AppliedAmount` utilizará `DECIMAL(19,4)` y será `NOT NULL`.
- `CreatedAt` utilizará `DATETIME2(3)` y será `NOT NULL`.
- `CreatedBy` utilizará `BIGINT NULL`.

#### 6.12.7.2 Primary Key

- `PK_PaymentResource` será la Primary Key de
  `PaymentResource(PaymentResourceId)`.

#### 6.12.7.3 Foreign Keys

- `FK_PaymentResource_Payment`:
  `PaymentResource.PaymentId` → `Payment.PaymentId`.
- `FK_PaymentResource_FinancialResource`:
  `PaymentResource.FinancialResourceId`
  → `FinancialResource.FinancialResourceId`.
- `FK_PaymentResource_CreatedBy`:
  `PaymentResource.CreatedBy` → `User.UserId`.

Todas utilizarán `ON DELETE NO ACTION` y `ON UPDATE NO ACTION`.

#### 6.12.7.4 Defaults

- `DF_PaymentResource_CreatedAt` → `SYSUTCDATETIME()`.

#### 6.12.7.5 Check Constraints

- `CK_PaymentResource_AmountUsed` deberá garantizar
  `AmountUsed > 0`.
- `CK_PaymentResource_ExchangeRate` deberá garantizar
  `ExchangeRate > 0`.
- `CK_PaymentResource_AppliedAmount` deberá garantizar
  `AppliedAmount > 0`.

#### 6.12.7.6 Índices

Se crearán:

- `IX_PaymentResource_PaymentId` sobre
  `PaymentResource(PaymentId)`.
- `IX_PaymentResource_FinancialResourceId` sobre
  `PaymentResource(FinancialResourceId)`.

#### 6.12.7.7 Reglas de Persistencia

- Payment Resource representa la utilización de un Financial Resource
  dentro de un Payment.
- Un Payment podrá tener múltiples Payment Resources.
- Un Financial Resource podrá participar en múltiples Payments.
- `AmountUsed` estará expresado en la Currency del Financial Resource.
- `AppliedAmount` estará expresado en la Currency de la Financial Obligation.
- `ExchangeRate` conservará la tasa realmente aplicada.
- El Exchange Rate histórico no se recalculará por cambios posteriores de
  Base Currency.
- La suma de `AppliedAmount` de los Payment Resources de un Payment deberá
  corresponder al importe aplicado por el Payment a la Financial Obligation.

### 6.12.8 Entidades asociativas

Financial Obligations no utilizará una entidad asociativa entre
Payment y Financial Obligation.

La relación N:M entre Payment y Financial Resource será implementada mediante
Payment Resource.

Payment Resource tendrá identidad propia porque conserva información
adicional de la aplicación del recurso:

- AmountUsed;
- ExchangeRate;
- AppliedAmount.

Por lo tanto, Payment Resource utilizará una Primary Key propia
`PaymentResourceId` y no una Primary Key compuesta.

### 6.12.9 Catálogos

`Financial Obligation Type`, `Debt Type` y `Related Entity Type` serán
estructuras de soporte para valores controlados.

Los tres catálogos utilizarán el mismo patrón físico:

- identificador `BIGINT IDENTITY(1,1)`;
- `OwnerUserId BIGINT NULL`;
- `Code VARCHAR(50) NOT NULL`;
- `Name NVARCHAR(150) NOT NULL`;
- `Description NVARCHAR(500) NULL`;
- `IsActive BIT NOT NULL`;
- atributos de auditoría.

`OwnerUserId = NULL` representará un valor proporcionado por el producto.

`OwnerUserId` informado representará un valor definido por un Usuario.

No se implementará Seed para estos catálogos en esta fase.

Los catálogos deberán conservar su historial mediante eliminación lógica
cuando aplique.

La unicidad de `Code` se establecerá por ámbito de propietario mediante
índices únicos sobre `OwnerUserId + Code`.

#### 6.12.9.1 FinancialObligationType

Se implementará con:

- `FinancialObligationTypeId BIGINT IDENTITY(1,1) NOT NULL`.
- `OwnerUserId BIGINT NULL`.
- `Code VARCHAR(50) NOT NULL`.
- `Name NVARCHAR(150) NOT NULL`.
- `Description NVARCHAR(500) NULL`.
- `IsActive BIT NOT NULL`.
- `CreatedAt DATETIME2(3) NOT NULL`.
- `CreatedBy BIGINT NULL`.
- `UpdatedAt DATETIME2(3) NULL`.
- `UpdatedBy BIGINT NULL`.
- `DeletedAt DATETIME2(3) NULL`.
- `DeletedBy BIGINT NULL`.

Foreign Keys:

- `OwnerUserId` → `User.UserId`.
- `CreatedBy` → `User.UserId`.
- `UpdatedBy` → `User.UserId`.
- `DeletedBy` → `User.UserId`.

Default:

- `CreatedAt` → `SYSUTCDATETIME()`.

Índices:

- índice único sobre `(OwnerUserId, Code)`.
- índice sobre `OwnerUserId`.

#### 6.12.9.2 DebtType

Se implementará con la misma estructura física de
`FinancialObligationType`.

Foreign Keys:

- `OwnerUserId` → `User.UserId`.
- `CreatedBy` → `User.UserId`.
- `UpdatedBy` → `User.UserId`.
- `DeletedBy` → `User.UserId`.

Default:

- `CreatedAt` → `SYSUTCDATETIME()`.

Índices:

- índice único sobre `(OwnerUserId, Code)`.
- índice sobre `OwnerUserId`.

#### 6.12.9.3 RelatedEntityType

Se implementará con la misma estructura física de
`FinancialObligationType`.

Foreign Keys:

- `OwnerUserId` → `User.UserId`.
- `CreatedBy` → `User.UserId`.
- `UpdatedBy` → `User.UserId`.
- `DeletedBy` → `User.UserId`.

Default:

- `CreatedAt` → `SYSUTCDATETIME()`.

Índices:

- índice único sobre `(OwnerUserId, Code)`.
- índice sobre `OwnerUserId`.

### 6.12.10 Moneda Base del Usuario

La Base Currency del Usuario es una preferencia de configuración utilizada
para presentación y análisis.

La modificación de la Base Currency no deberá modificar ninguna Currency
histórica almacenada en Financial Event, Financial Obligation, Debt,
Financial Resource o Payment Resource.

La aplicación podrá convertir valores históricos para presentación utilizando
las reglas y Exchange Rates de referencia correspondientes.

La conversión de presentación no deberá sobrescribir los valores monetarios
históricos.

### 6.12.11 Exchange Rate de referencia

BudgetKeep deberá disponer posteriormente de una estructura persistente
para conservar Exchange Rates de referencia por fecha y par de monedas.

Esta estructura tendrá como finalidad soportar:

- Budget;
- Forecast;
- proyecciones;
- estimaciones;
- conversiones de presentación cuando corresponda.

Los Exchange Rates de referencia no representan necesariamente el tipo de
cambio aplicado por una entidad financiera a una operación real.

El Exchange Rate realmente aplicado a un Payment Resource deberá conservarse
directamente en Payment Resource y tendrá prioridad como información
histórica de la operación.

La estructura física de Exchange Rate de referencia será definida en el
dominio que requiera su persistencia funcional, inicialmente Financial
Planning / Budget, y no se implementará como parte de Financial Obligations
en esta etapa.

# 7. Convenciones de Diseño

Las convenciones definidas en esta sección establecen el estándar oficial para la construcción de todos los objetos de la base de datos de BudgetKeep.

Su propósito es garantizar consistencia, legibilidad, mantenibilidad y uniformidad durante el desarrollo, evolución y administración del modelo físico de datos.

Todas las disciplinas que interactúen con la base de datos deberán respetar las convenciones aquí definidas.

---

## 7.1 Convenciones de Nombres

Los nombres de los objetos deberán ser descriptivos, consistentes y representar claramente su propósito dentro del modelo de datos.

Se utilizará el idioma inglés como estándar para todos los objetos físicos de la base de datos.

No se permitirá el uso de abreviaturas ambiguas, caracteres especiales, espacios ni nombres dependientes del contexto funcional.

---

## 7.2 Convenciones para Tablas

Las tablas deberán representar una única responsabilidad dentro del modelo de datos.

Sus nombres deberán utilizar sustantivos en singular y reflejar el concepto persistente que representan.

Cada tabla deberá poseer una clave primaria y una definición explícita de su propósito dentro del modelo físico.

---

## 7.3 Convenciones para Columnas

Los nombres de las columnas deberán describir claramente la información almacenada.

Las columnas que representen claves primarias y foráneas deberán mantener una nomenclatura uniforme en toda la base de datos.

Las columnas utilizadas para auditoría, control, estado o trazabilidad deberán conservar la misma estructura y significado en todas las entidades donde existan.

---

## 7.4 Convenciones para Claves

Todas las entidades persistentes deberán contar con una clave primaria que garantice la identificación única de cada registro.

Las claves foráneas deberán mantener consistencia con las claves primarias referenciadas y preservar la integridad referencial del modelo.

La estrategia específica de generación de claves será definida en la sección correspondiente.

---

## 7.5 Convenciones para Restricciones

Las restricciones deberán nombrarse de forma consistente para facilitar su identificación y mantenimiento.

Cada restricción deberá reflejar claramente el tipo de validación que implementa y el objeto sobre el cual actúa.

Las convenciones específicas de nomenclatura serán definidas antes de la implementación física del modelo.

---

## 7.6 Convenciones para Índices

Los índices deberán diseñarse de acuerdo con las necesidades funcionales y de rendimiento del producto.

Su definición deberá evitar redundancias innecesarias y priorizar la eficiencia de las operaciones de consulta y actualización.

La creación de índices responderá a criterios técnicos documentados y no únicamente a decisiones de implementación.

---

## 7.7 Consistencia del Modelo

Todas las entidades, relaciones y objetos definidos durante la implementación deberán respetar las convenciones establecidas en esta especificación.

No se permitirán excepciones que comprometan la uniformidad del modelo físico, la mantenibilidad del sistema o la trazabilidad de las decisiones de diseño.

# 8. Estándares de Datos

Los estándares definidos en esta sección establecen los lineamientos para la utilización uniforme de los tipos de datos dentro del Modelo Físico de Datos.

Su propósito es garantizar consistencia, interoperabilidad, mantenibilidad y calidad en la definición de los atributos persistentes de BudgetKeep.

Las decisiones aquí establecidas deberán aplicarse a todas las entidades y objetos definidos en esta especificación.

---

## 8.1 Principios Generales

La selección de los tipos de datos deberá realizarse considerando la naturaleza de la información, los requerimientos funcionales del producto y las capacidades del motor de base de datos definido por la Arquitectura Técnica.

En todos los casos se privilegiará la precisión, integridad y consistencia de la información sobre la optimización prematura del almacenamiento.

---

## 8.2 Criterios de Selección

Los tipos de datos deberán seleccionarse considerando, entre otros, los siguientes criterios:

- Naturaleza de la información.
- Precisión requerida.
- Rango esperado de valores.
- Reglas de negocio aplicables.
- Frecuencia de actualización.
- Impacto sobre el rendimiento.
- Requerimientos de trazabilidad.

---

## 8.3 Consistencia

Un mismo tipo de información deberá utilizar el mismo tipo de dato en toda la base de datos.

No se permitirá que atributos equivalentes utilicen definiciones diferentes sin una justificación técnica documentada.

Esta regla aplica igualmente para identificadores, importes monetarios, porcentajes, fechas, indicadores lógicos, estados y cualquier otro atributo compartido entre entidades.

---

## 8.4 Valores por Defecto

Los valores por defecto deberán definirse únicamente cuando representen un comportamiento consistente con el dominio del negocio y no generen ambigüedad en la interpretación de la información.

No deberán utilizarse valores por defecto para ocultar información faltante ni para sustituir validaciones funcionales que correspondan a otros componentes de la solución.

---

## 8.5 Valores Nulos

La utilización de valores nulos deberá limitarse exclusivamente a los atributos cuya ausencia de información represente un estado válido dentro del dominio del negocio.

Los atributos obligatorios deberán definirse como no nulos para preservar la integridad del modelo de datos.

---

## 8.6 Estandarización

La definición definitiva de los tipos de datos físicos será desarrollada durante el diseño detallado de las entidades persistentes.

Todas las entidades deberán reutilizar los estándares definidos por esta especificación con el propósito de mantener uniformidad en la implementación física de la base de datos.

# 9. Estrategia de Integridad

La Estrategia de Integridad define el conjunto de lineamientos destinados a garantizar la consistencia, confiabilidad y calidad de la información almacenada en la base de datos de BudgetKeep.

Su objetivo es asegurar que todas las entidades persistentes mantengan relaciones válidas, preserven las reglas estructurales del modelo y eviten la generación de información inconsistente o huérfana.

Las decisiones establecidas en esta sección deberán aplicarse de forma uniforme durante la implementación física de la base de datos.

---

## 9.1 Claves Primarias

Toda entidad persistente deberá contar con una clave primaria que permita identificar de manera única cada registro.

Las claves primarias deberán permanecer estables durante todo el ciclo de vida del registro y no deberán contener información con significado funcional o de negocio.

La estrategia de generación de identificadores será definida antes de la implementación física de las entidades.

---

## 9.2 Claves Foráneas

Las claves foráneas deberán establecer explícitamente las relaciones entre entidades persistentes.

Toda relación definida mediante una clave foránea deberá preservar la integridad referencial del modelo y mantener consistencia con las cardinalidades establecidas durante el diseño lógico.

No se permitirán relaciones implícitas ni dependencias que no se encuentren documentadas dentro del modelo de datos.

---

## 9.3 Restricciones de Integridad

Las restricciones deberán implementarse para garantizar la validez estructural de la información almacenada.

Su utilización deberá impedir la incorporación de datos inconsistentes, duplicados o incompatibles con las reglas establecidas por el modelo de datos.

Las restricciones específicas serán definidas durante el diseño detallado de cada entidad persistente.

---

## 9.4 Integridad Referencial

La integridad referencial deberá garantizar que todas las relaciones entre entidades permanezcan consistentes durante las operaciones de inserción, actualización y eliminación.

Toda operación que pueda afectar la consistencia de una relación deberá encontrarse controlada mediante las restricciones correspondientes.

Las estrategias de actualización y eliminación en cascada serán definidas únicamente cuando exista una justificación funcional y técnica debidamente documentada.

---

## 9.5 Integridad de Dominio

Cada atributo deberá almacenar únicamente valores compatibles con el dominio de información que representa.

La validación del dominio deberá realizarse mediante restricciones estructurales, tipos de datos adecuados y mecanismos de validación definidos durante el diseño físico.

Las validaciones propias de las reglas de negocio permanecerán bajo la responsabilidad de las capas correspondientes de la aplicación.

---

## 9.6 Consistencia Global

La integridad de la información deberá preservarse durante toda la evolución del producto.

Toda modificación al modelo de datos deberá mantener la consistencia estructural de la base de datos, evitando afectar la información existente o comprometer la trazabilidad de las decisiones aprobadas en la presente especificación.

# 10. Estrategia de Normalización

La Estrategia de Normalización define los principios que regirán la organización de la información persistente dentro de la base de datos de BudgetKeep.

Su propósito es reducir la redundancia de datos, preservar la integridad de la información y facilitar el mantenimiento del modelo de datos durante la evolución del producto.

Las decisiones establecidas en esta sección deberán aplicarse durante el diseño del Modelo Lógico y del Modelo Físico de Datos.

---

## 10.1 Objetivo

La normalización tiene como objetivo estructurar la información de manera que cada dato se almacene una única vez, evitando inconsistencias derivadas de duplicidad o dependencia inadecuada entre atributos.

La aplicación de este principio permitirá mantener un modelo consistente, flexible y preparado para evolucionar conforme crezcan las capacidades funcionales del producto.

---

## 10.2 Aplicación de la Normalización

El Modelo Lógico de Datos deberá diseñarse siguiendo los principios de normalización generalmente aceptados para bases de datos relacionales.

Las entidades deberán organizarse de forma que cada una represente una única responsabilidad dentro del dominio de persistencia y que sus atributos dependan únicamente de la clave primaria correspondiente.

La organización del modelo deberá minimizar redundancias y eliminar dependencias innecesarias entre entidades.

---

## 10.3 Desnormalización Controlada

La desnormalización únicamente podrá aplicarse cuando exista una justificación técnica documentada relacionada con el rendimiento, la escalabilidad o la optimización de consultas.

Toda decisión de desnormalización deberá evaluar su impacto sobre la consistencia de la información, la mantenibilidad del modelo y la complejidad de las operaciones de actualización.

Las estructuras desnormalizadas deberán mantenerse sincronizadas mediante mecanismos controlados y documentados.

---

## 10.4 Reutilización de la Información

La información común deberá reutilizarse mediante relaciones entre entidades y no mediante duplicación de datos.

Las entidades compartidas deberán actuar como fuente única de verdad para la información que representan, permitiendo que diferentes componentes del modelo reutilicen la misma información persistente.

---

## 10.5 Evolución del Modelo

La estrategia de normalización deberá facilitar la incorporación de nuevas capacidades funcionales sin requerir modificaciones estructurales significativas.

Toda evolución del modelo deberá preservar la integridad, consistencia y trazabilidad de la información almacenada, manteniendo compatibilidad con las decisiones previamente aprobadas en esta especificación.

# 11. Estrategia de Persistencia

La Estrategia de Persistencia define los criterios que determinarán qué información deberá almacenarse de forma permanente dentro de la base de datos de BudgetKeep y cómo será administrada durante su ciclo de vida.

Su propósito es garantizar que la información persistida represente de manera consistente el estado financiero del usuario, evitando el almacenamiento innecesario de datos derivados o temporales.

Las decisiones establecidas en esta sección deberán aplicarse durante el diseño de todas las entidades persistentes del modelo de datos.

---

## 11.1 Información Persistente

Se considerará información persistente aquella cuyo estado deba conservarse para soportar la operación normal del producto, mantener la trazabilidad de la información o preservar el historial requerido por las capacidades funcionales de BudgetKeep.

Toda información persistente deberá formar parte de una entidad claramente identificada dentro del Modelo Lógico y del Modelo Físico de Datos.

---

## 11.2 Información Derivada

La información derivada corresponde a datos cuyo valor puede obtenerse a partir de información persistente existente.

Siempre que sea técnicamente viable, este tipo de información deberá calcularse durante la ejecución de la aplicación, evitando duplicidad y reduciendo el riesgo de inconsistencias.

Su persistencia únicamente será permitida cuando exista una justificación técnica documentada.

---

## 11.3 Información Calculada

La información calculada representa resultados obtenidos mediante operaciones matemáticas, financieras o de agregación realizadas sobre información persistente.

Como principio general, estos resultados no deberán almacenarse permanentemente, salvo que existan requerimientos de rendimiento, auditoría o trazabilidad que justifiquen su persistencia.

---

## 11.4 Información Temporal

La información temporal corresponde a datos cuya vigencia está limitada a una operación, proceso o contexto específico.

Este tipo de información no formará parte del modelo permanente de persistencia, salvo que exista un requerimiento funcional explícito que justifique su conservación.

---

## 11.5 Información Histórica

La información histórica permitirá conservar la evolución de los datos cuando resulte necesario para mantener la trazabilidad del producto o representar adecuadamente la evolución de la realidad financiera del usuario.

La estrategia específica para el manejo del historial será definida en la sección correspondiente de esta especificación.

---

## 11.6 Información de Configuración

La información de configuración comprende los parámetros utilizados para controlar el comportamiento del producto y personalizar su funcionamiento.

Estos datos deberán almacenarse de forma estructurada, manteniendo independencia respecto a la información transaccional y permitiendo su evolución sin afectar la integridad del modelo de datos.

---

## 11.7 Consistencia de la Persistencia

Toda decisión relacionada con la persistencia de información deberá mantener consistencia con el Modelo de Dominio, el Modelo Lógico de Datos y las decisiones aprobadas en la línea base del proyecto.

No se permitirá almacenar información cuya persistencia no pueda justificarse desde una perspectiva funcional o técnica.

# 12. Estrategia de Auditoría e Historial

La Estrategia de Auditoría e Historial establece los lineamientos para registrar, conservar y rastrear la evolución de la información persistente administrada por BudgetKeep.

Su propósito es garantizar la trazabilidad de los datos, facilitar el análisis de cambios, apoyar los procesos de diagnóstico y preservar la integridad histórica de la información cuando sea requerido por las capacidades funcionales del producto.

Las decisiones definidas en esta sección deberán aplicarse de manera uniforme a todas las entidades persistentes del modelo de datos.

---

## 12.1 Auditoría

La auditoría permitirá identificar el origen y la evolución de la información almacenada en la base de datos.

Toda entidad que requiera trazabilidad deberá incorporar los mecanismos necesarios para registrar la creación, modificación y, cuando corresponda, la desactivación de la información persistente.

La definición específica de los atributos de auditoría será desarrollada durante el diseño detallado de las entidades.

---

## 12.2 Historial

La estrategia de historial permitirá conservar la evolución de la información cuando ésta represente un requerimiento funcional o de trazabilidad.

La conservación del historial deberá evitar la pérdida de información relevante y permitir reconstruir el estado de los datos en un momento determinado cuando sea necesario.

Los criterios específicos para mantener versiones históricas serán definidos durante el diseño de las entidades correspondientes.

---

## 12.3 Eliminación Lógica

Como principio general, la información persistente no deberá eliminarse físicamente cuando ello comprometa la trazabilidad o la consistencia del modelo de datos.

Cuando la naturaleza funcional del producto lo permita, se privilegiará la utilización de mecanismos de eliminación lógica que permitan conservar la información sin mantenerla disponible para la operación normal del sistema.

Las excepciones a este principio deberán justificarse técnicamente.

---

## 12.4 Concurrencia

La base de datos deberá proporcionar mecanismos que permitan preservar la consistencia de la información cuando múltiples procesos interactúen simultáneamente con los mismos datos.

La estrategia específica para el control de concurrencia será implementada de acuerdo con las capacidades del motor de base de datos y las decisiones establecidas por la Arquitectura Técnica.

---

## 12.5 Conservación de la Información

La conservación de la información deberá responder a las necesidades funcionales del producto y mantener la trazabilidad requerida para representar adecuadamente la evolución de la realidad financiera del usuario.

Toda decisión relacionada con la retención o eliminación definitiva de información deberá preservar la integridad del modelo y respetar las políticas definidas por la línea base del proyecto.

---

## 12.6 Aplicación de la Estrategia

Las reglas de auditoría e historial definidas en esta sección deberán aplicarse de manera uniforme durante el diseño e implementación de todas las entidades persistentes.

Las entidades que requieran un tratamiento diferente deberán documentar explícitamente la justificación técnica correspondiente dentro de esta especificación.

---

# 13. Modelo de Persistencia y Entidades

## 13.1 Matriz de Transformación del Modelo de Dominio

La presente matriz documenta la transformación oficial entre los Conceptos del Dominio definidos en el *Business Domain Specification* y el Modelo de Persistencia definido por el *Database Design Specification*.

Su propósito es mantener la trazabilidad entre ambas disciplinas y justificar las decisiones tomadas durante el diseño de la base de datos.

La existencia de un Concepto del Dominio no implica necesariamente la existencia de una entidad persistente. Cada concepto ha sido analizado desde la perspectiva de persistencia para determinar la forma en que será representado dentro del modelo de datos.

| ID | Concepto del Dominio | Clasificación | Entidad Persistente | Observaciones |
|:---|:---------------------|:--------------|:--------------------|:--------------|
| DC-001 | User | Persistente | User | Entidad raíz del modelo. |
| DC-002 | Financial Reality | Derivado | — | Se obtiene mediante la agregación de información persistente. |
| DC-003 | Financial Obligation | Persistente | Financial Obligation | Representa compromisos financieros del usuario. |
| DC-004 | Payment | Persistente | Payment | Representa el acto mediante el cual el Usuario atiende total o parcialmente una única Obligación Financiera. |
| DC-005 | Financial Event | Persistente | Financial Event | Representa eventos financieros relevantes del usuario. |
| DC-006 | Income | Persistente | Income | Registra ingresos del usuario. |
| DC-007 | Expense | Persistente | Expense | Registra egresos del usuario. |
| DC-008 | Debt | Persistente | Debt | Representa obligaciones financieras con saldo pendiente. |
| DC-009 | Financial Availability | Calculado | — | Se obtiene a partir de recursos, obligaciones y eventos financieros. |
| DC-010 | Related Entity | Persistente | Related Entity | Catálogo de personas, empresas u organizaciones relacionadas. |
| DC-011 | Currency | Persistente | Currency | Catálogo oficial de monedas del sistema. |
| DC-012 | Exchange Rate | Persistente | Exchange Rate | Soporta la operación multimoneda del producto. |
| DC-013 | Financial Priority | Persistente | Financial Priority | Permite priorizar obligaciones y objetivos financieros. |
| DC-014 | Financial Resource | Persistente | Financial Resource | Representa cuentas, efectivo, tarjetas y demás recursos financieros. |
| DC-015 | Financial Strategy | Persistente | Financial Strategy | Conserva las estrategias propuestas y adoptadas por el usuario. |
| DC-016 | Financial Plan | Persistente | Financial Plan | Representa la planificación financiera vigente del usuario. |

Como resultado del análisis realizado, el Modelo de Persistencia estará conformado por las entidades persistentes identificadas en la matriz anterior.

Los conceptos clasificados como **Derivados** o **Calculados** no serán implementados como entidades independientes dentro de la base de datos. Su información será obtenida mediante consultas, reglas de negocio o procesos de cálculo definidos por las disciplinas correspondientes.

Las entidades de catálogo funcional o de soporte reutilizable podrán formar parte del Modelo Lógico de Datos cuando sean necesarias para representar valores controlados, referencias compartidas o estructuras de soporte requeridas por las entidades persistentes. Estas entidades deberán mantener trazabilidad con la necesidad funcional, técnica o de persistencia que justifique su incorporación. Las entidades puramente técnicas, cuyo propósito corresponda exclusivamente a mecanismos internos de implementación, control o soporte del motor de base de datos, serán definidas durante el diseño del Modelo Físico de Datos.

---

## 13.2 Modelo General de Entidades

El Modelo General de Entidades define el conjunto de entidades persistentes que conformarán la base de datos de BudgetKeep.

Las entidades se organizan por dominios funcionales con el propósito de facilitar su construcción, mantenimiento y evolución, preservando la trazabilidad con el Modelo de Dominio y la Arquitectura Técnica del proyecto.

La implementación se realizará de forma incremental, completando cada dominio antes de iniciar el siguiente. Cada dominio se considerará concluido únicamente cuando se hayan actualizado los siguientes artefactos:

- Database Design Specification (DDS).
- Entity Relationship Diagram (ERD).
- Scripts de Structured Query Language (SQL).
- Scripts de Rollback.
- Scripts Seed (cuando aplique).
- Implementación y validación en Azure SQL Database.

Los dominios funcionales definidos para BudgetKeep son:

| Dominio | Estado |
|----------|--------|
| Identity & Security | CLOSED |
| Catalogs | CLOSED
| Financial Resources | CLOSED |
| Financial Events | CLOSED |
| Financial Planning | CLOSED |
| Financial Obligations | CLOSED |
| Audit | Pendiente |


### Entidades definidas de Catalogs

Las entidades de Catalogs definidas hasta este momento son:

- Language
- TimeZone

### Entidades definidas de Financial Resources

Las entidades de Financial Resources definidas para esta etapa son:

- Financial Resource
- Currency

### Entidades definidas de Financial Events

Las entidades de Financial Events definidas para esta etapa son:

- Income
- Expense
- StandAlone
- Financial Event
- RecurrenceType
- RecurrenceConfiguration

### Entidades definidas de Financial Planning

Las entidades persistentes del dominio Financial Planning serán:

- Financial Strategy
- Financial Strategy Item
- Financial Plan
- Financial Plan Item
- Financial Plan Strategy
- Financial Plan Resource
- Financial Plan Item Event

### Entidades definidas de Financial Obligations

Las entidades persistentes del dominio Financial Obligations serán:

- Financial Obligation
- Debt
- Financial Priority
- Payment
- Related Entity

Las entidades de soporte del dominio serán:

- Financial Obligation Type
- Debt Type
- Related Entity Type
- Financial Obligation Recurrence Configuration

---

## 13.3 Diseño de Entidades

La presente sección define el diseño detallado de las entidades persistentes que conforman la base de datos de BudgetKeep.

Cada entidad será documentada de forma independiente, incluyendo su propósito, responsabilidades, relaciones, atributos, reglas de integridad y los artefactos necesarios para su implementación física.

Las entidades se desarrollarán siguiendo el orden de dependencias definido para cada dominio funcional.

Al concluir el diseño de un dominio, deberán actualizarse los siguientes artefactos:

- Database Design Specification (DDS).
- Entity Relationship Diagram (ERD).
- Scripts de Structured Query Language (SQL).
- Scripts de Rollback.
- Scripts Seed (cuando aplique).

---

### 13.3.1 Dominio: Identity & Security

Este dominio agrupa las entidades responsables de la administración de usuarios, autenticación, autorización, seguridad de cuentas y configuración personal del sistema.

Su objetivo es proporcionar la infraestructura necesaria para controlar el acceso a la aplicación y asociar toda la información financiera con un usuario propietario.

Las entidades que conforman este dominio son:

- User
- UserSecurity
- Role
- Module
- Permission
- ModulePermission
- UserRole
- RolePermission
- UserPreference
- SystemConfiguration
- ConfigurationDataType

#### 13.3.1.1 Reglas de Auditoría

Los atributos de auditoría CreatedBy, UpdatedBy y DeletedBy, cuando estén presentes en una entidad, deberán referenciar User.UserId.

Estas referencias representan al usuario responsable de la operación y constituyen relaciones técnicas de auditoría, no relaciones funcionales del dominio.

Los atributos podrán ser NULL cuando la operación sea ejecutada durante la inicialización, migración o por un proceso técnico que no cuente con un usuario autenticado, conforme a las reglas de auditoría definidas para el dominio.

El primer usuario del sistema constituirá una excepción controlada y podrá ser creado con CreatedBy, UpdatedBy y DeletedBy en NULL.

Una vez creado el primer usuario, cuando exista un usuario autenticado como responsable de la operación, la aplicación deberá registrar su UserId en el atributo de auditoría correspondiente.

Los procesos de inicialización, migración o ejecución técnica que no cuenten con un usuario autenticado podrán mantener estos atributos en NULL cuando corresponda.

---

### 13.3.2 Entity: User

#### 13.3.2.1 Objetivo

Representar a cada usuario registrado en BudgetKeep y establecer el propietario de toda la información financiera almacenada en el sistema.

La entidad User constituye la raíz del modelo de datos y será la referencia principal para la asociación de recursos financieros, eventos, planes, obligaciones y configuraciones personales.

---

#### 13.3.2.2 Responsabilidades

La entidad User es responsable de:

- Identificar de forma única a cada usuario del sistema.
- Mantener la información básica del perfil del usuario.
- Asociar toda la información financiera con un único propietario.
- Servir como entidad raíz para las relaciones funcionales del modelo.

---

#### 13.3.2.3 Fuera del Alcance

La entidad User no será responsable de:

- Autenticación.
- Autorización.
- Gestión de contraseñas.
- Tokens de acceso.
- Sesiones de usuario.
- Autenticación Multifactor (MFA).

La información persistente relacionada con credenciales y seguridad de la cuenta será almacenada en la entidad UserSecurity.

Estas responsabilidades corresponden a los componentes de seguridad definidos por la Arquitectura Técnica y a las entidades especializadas del dominio Identity & Security.

---

#### 13.3.2.4 Relaciones

La entidad User mantiene relaciones directas con las siguientes entidades:

- UserSecurity
- UserRole
- UserPreference
- FinancialResource
- FinancialEvent
- FinancialPlan
- FinancialObligation

---

#### 13.3.2.5 Observaciones de Diseño

Toda la información funcional del producto deberá pertenecer a un único usuario.

No existirán registros huérfanos sin propietario.

Las entidades compartidas entre usuarios únicamente podrán implementarse cuando exista una decisión arquitectónica aprobada que lo justifique.

- Username deberá ser único dentro del sistema.
- Email deberá ser único dentro del sistema.
- SupportId deberá ser único dentro del sistema.
- SupportId será generado por el sistema, será estable durante la vida de la cuenta y no deberá reutilizarse para otro usuario.
- Los atributos podrán ser NULL cuando la operación sea ejecutada durante la inicialización, migración o por un proceso técnico que no cuente con un usuario responsable de la operación, conforme a las reglas de auditoría definidas para el dominio.
- El primer usuario del sistema constituirá una excepción controlada y podrá ser creado con los atributos de auditoría correspondientes en NULL.
- Una vez creado el primer usuario, los procesos de aplicación deberán registrar el UserId del usuario responsable en los atributos de auditoría aplicables cuando exista un usuario autenticado como responsable de la operación.
- Los procesos de inicialización, migración o ejecución técnica que no cuenten con un usuario autenticado podrán mantener estos atributos en NULL cuando corresponda.

##### 13.3.2.5.1 Identificación y Soporte

Al completar el registro y activación de una cuenta, el sistema deberá enviar un correo de bienvenida al correo electrónico registrado del usuario.

El correo de bienvenida deberá incluir como mínimo:

- Nombre del usuario.
- Correo electrónico registrado.
- Número telefónico registrado.
- SupportId.
- Correo electrónico oficial del servicio de soporte.
- Información necesaria para contactar al servicio de soporte.

El correo deberá indicar claramente al usuario que deberá conservar esta información para futuras dudas, aclaraciones y solicitudes de soporte, y que estos datos serán utilizados para identificarlo ante el servicio de soporte.

El SupportId será utilizado como identificador de atención ante el servicio de soporte y no constituirá por sí mismo un mecanismo de autenticación o verificación de identidad.

Cuando una cuenta tenga RequiresSupport = true, el usuario deberá utilizar el canal oficial de soporte para solicitar atención.

#### 13.3.2.6 Atributos

La siguiente tabla define los atributos funcionales de la entidad **User**.

La información relacionada con credenciales y seguridad de la cuenta se mantiene separada en la entidad **UserSecurity**.

Las preferencias personales del usuario se mantienen separadas en la entidad **UserPreference**.

La definición de tipos de datos físicos, restricciones e índices será desarrollada durante el diseño físico de la entidad.

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| UserId | Identificador único del usuario. | Sí |
| SupportId | Identificador público y estable utilizado para identificar al usuario ante el servicio de soporte. | Sí |
| Username | Nombre de usuario utilizado para iniciar sesión. | Sí |
| Email | Correo electrónico principal del usuario. | Sí |
| FirstName | Nombre del usuario. | Sí |
| LastName | Apellidos del usuario. | Sí |
| PhoneNumber | Número telefónico registrado para fines de contacto y soporte. | Sí |
| IsActive | Indica si el usuario puede acceder al sistema. | Sí |
| CreatedAt | Fecha y hora de creación del registro. | Sí |
| CreatedBy | Usuario que creó el registro. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario que realizó la última modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario que realizó la eliminación lógica. | No |

---

### 13.3.3 Entity: UserSecurity

#### 13.3.3.1 Objetivo

Almacenar la información persistente relacionada con las credenciales y el estado de seguridad de la cuenta de un usuario.

La entidad UserSecurity mantiene una relación uno a uno con User y separa la información sensible de seguridad de la información funcional del perfil del usuario.

---

#### 13.3.3.2 Responsabilidades

La entidad UserSecurity es responsable de:

- Almacenar el hash de la contraseña.
- Mantener el estado de bloqueo de la cuenta.
- Registrar los intentos fallidos de autenticación.
- Registrar la cantidad de bloqueos acumulados dentro de la ventana de seguridad definida.
- Registrar la fecha y hora hasta la cual permanece activo un bloqueo.
- Registrar el último acceso exitoso.
- Registrar la fecha y hora del último cambio de contraseña.
- Registrar el inicio de la ventana vigente para contabilizar los bloqueos de seguridad.
- Indicar cuando una cuenta requiere intervención del servicio de soporte.

---

#### 13.3.3.3 Fuera del Alcance

La entidad UserSecurity no será responsable de:

- Ejecutar el proceso de autenticación.
- Validar directamente las credenciales.
- Generar tokens de acceso.
- Administrar sesiones.
- Ejecutar el proceso de recuperación de contraseña.
- Enviar correos electrónicos de recuperación.
- Implementar el algoritmo de hashing.

Estas responsabilidades corresponden a los componentes de seguridad definidos por la Arquitectura Técnica y la implementación del Backend.

El almacenamiento de contraseñas utilizará **Argon2id** como mecanismo de hashing de contraseñas.

El algoritmo deberá utilizar una configuración resistente a ataques de fuerza bruta y ajustada al entorno de ejecución de BudgetKeep.

Los parámetros específicos de implementación de Argon2id no forman parte del modelo lógico de datos y deberán definirse en la especificación técnica de seguridad y en la configuración de la aplicación.

PasswordHash almacenará el resultado del proceso de hashing y no deberá permitir recuperar la contraseña original.

---

#### 13.3.3.4 Relaciones

La entidad UserSecurity mantiene una relación uno a uno obligatoria con:

- User

La clave UserSecurity.UserId será simultáneamente Primary Key y Foreign Key hacia User.UserId.

Cada User deberá tener exactamente un registro UserSecurity.
Cada UserSecurity deberá pertenecer exactamente a un User.

---

#### 13.3.3.5 Reglas Generales

- Cada usuario deberá tener exactamente un registro en UserSecurity.
- UserSecurity no podrá existir sin un User correspondiente.
- La contraseña nunca será almacenada en texto plano.
- PasswordHash almacenará únicamente el resultado del hashing realizado mediante Argon2id.
- PasswordHash no deberá ser utilizado para recuperar la contraseña original.
- FailedLoginAttempts se utilizará para controlar los intentos fallidos de autenticación correspondientes al ciclo actual de autenticación.
- FailedLoginAttempts deberá incrementarse en cada intento fallido de autenticación.
- Cuando se produzca una autenticación exitosa, FailedLoginAttempts deberá establecerse en 0.
- Cuando FailedLoginAttempts alcance SECURITY_MAX_FAILED_LOGIN_ATTEMPTS, deberá generarse un bloqueo temporal, FailedLoginAttempts deberá establecerse en 0 y LockoutCount deberá incrementarse en 1.
- LockoutCount registrará la cantidad de bloqueos contabilizados dentro de la ventana de seguridad definida y no deberá reiniciarse como consecuencia de una autenticación exitosa.
- LockoutUntil indicará la fecha y hora hasta la cual permanece activo un bloqueo temporal.
- Un bloqueo temporal se considerará vigente mientras LockoutUntil sea posterior a la fecha y hora actual.
- El estado efectivo de bloqueo de la cuenta se determinará mediante RequiresSupport y LockoutUntil, sin utilizar un atributo persistente adicional para representar el estado de bloqueo temporal.
- Cuando RequiresSupport sea true, la cuenta se considerará bloqueada y requerirá intervención de soporte.
- Cuando RequiresSupport sea false y LockoutUntil sea posterior a la fecha y hora actual, la cuenta se considerará bloqueada temporalmente.
- Cuando RequiresSupport sea false y LockoutUntil sea NULL o igual o anterior a la fecha y hora actual, la cuenta no se considerará bloqueada por razones de seguridad.
- La aplicación deberá determinar el estado efectivo del bloqueo temporal mediante LockoutUntil al procesar un intento de autenticación.
- Cuando RequiresSupport sea true, LockoutUntil deberá ser NULL y la cuenta no podrá volver a autenticarse por la expiración de un bloqueo temporal.

- RequiresSupport indicará que la cuenta ha alcanzado el límite máximo de bloqueos permitido y requiere intervención del servicio de soporte.
- LockoutWindowStart deberá establecerse en la fecha y hora del primer bloqueo de una nueva ventana de seguridad.
- Mientras la ventana de seguridad permanezca vigente, LockoutCount deberá incrementarse en cada nuevo bloqueo y LockoutWindowStart no deberá modificarse.
- La vigencia de la ventana se determinará comparando la fecha y hora actual con LockoutWindowStart y SECURITY_LOCKOUT_COUNT_WINDOW_DAYS.
- Cuando se produzca un nuevo bloqueo y la ventana de seguridad anterior haya expirado, LockoutCount deberá reiniciarse en 0 y LockoutWindowStart deberá establecerse en la fecha y hora del nuevo bloqueo antes de contabilizarlo.
- El nuevo bloqueo deberá contabilizarse dentro de la nueva ventana, por lo que LockoutCount deberá quedar en 1 después de dicho bloqueo.
- La expiración de la ventana de seguridad no requerirá un proceso automático, tarea programada, trigger ni actualización previa de LockoutCount.
- Una cuenta con RequiresSupport = true no deberá reiniciar automáticamente su LockoutCount ni iniciar una nueva ventana de seguridad por el simple transcurso del tiempo.
- Cuando LockoutCount alcance SECURITY_MAX_LOCKOUT_COUNT dentro de la ventana vigente, la cuenta deberá establecerse en un estado de bloqueo que requiera intervención del servicio de soporte.
- En este estado, LockoutUntil deberá establecerse en NULL.
- En este estado, RequiresSupport deberá establecerse en true.
- FailedLoginAttempts deberá establecerse en 0 al registrar el bloqueo.
- Una cuenta con RequiresSupport = true no deberá permitir nuevos intentos de autenticación.
- Una cuenta con RequiresSupport = true no deberá desbloquearse automáticamente mediante la expiración de LockoutUntil.
- El transcurso de SECURITY_LOCKOUT_COUNT_WINDOW_DAYS no deberá desbloquear una cuenta cuyo RequiresSupport sea true.
- Una cuenta con RequiresSupport = true únicamente podrá ser rehabilitada mediante una acción explícita del proceso de soporte, posterior a la verificación de identidad.
- La rehabilitación de una cuenta deberá iniciar un nuevo ciclo de seguridad y establecer RequiresSupport en false, LockoutUntil en NULL, FailedLoginAttempts en 0, LockoutCount en 0 y LockoutWindowStart en NULL.
- El reinicio de LockoutCount y LockoutWindowStart como parte de la rehabilitación deberá realizarse únicamente mediante la acción explícita de soporte y no por el simple transcurso del tiempo.
- Las acciones de rehabilitación deberán quedar registradas mediante el mecanismo de auditoría correspondiente.
- Cuando RequiresSupport = true, LockoutUntil deberá permanecer NULL.
- Los valores de la política de bloqueo serán obtenidos desde SystemConfiguration.
- La lógica de autenticación y bloqueo será responsabilidad del componente de seguridad de la aplicación.
- UserSecurity representa el estado actual de seguridad de la cuenta y no constituye un historial de eventos de seguridad.
- Los eventos relevantes de autenticación y seguridad deberán registrarse mediante el mecanismo de auditoría definido por el dominio Audit.
- Los cambios en PasswordHash, LockoutCount y demás atributos de seguridad deberán poder ser trazables mediante el mecanismo de auditoría correspondiente.

---

#### 13.3.3.6 Atributos

La siguiente tabla define los atributos lógicos de la entidad **UserSecurity**.

La definición de tipos de datos físicos, restricciones e índices será desarrollada durante el diseño físico de la entidad.

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| UserId | Identificador del usuario al que pertenece la información de seguridad. | Sí |
| PasswordHash | Resultado del proceso de hashing Argon2id utilizado para almacenar de forma segura la contraseña. | Sí |
| FailedLoginAttempts | Número de intentos fallidos de autenticación registrados para la cuenta. | Sí |
| LockoutUntil | Fecha y hora hasta la cual permanece activo el bloqueo actual. | No |
| LockoutCount | Número de bloqueos contabilizados dentro de la ventana de seguridad definida. | Sí |
| LockoutWindowStart | Fecha y hora en que inició la ventana vigente de contabilización de bloqueos. Es NULL cuando la cuenta aún no ha iniciado una ventana de seguridad. | No |
| LastLoginDate | Fecha y hora del último acceso exitoso. | No |
| PasswordChangedDate | Fecha y hora del último cambio de contraseña. | No |
| RequiresSupport | Indica que la cuenta ha alcanzado el límite de bloqueos permitido y requiere intervención del servicio de soporte. | Sí |

### 13.3.4 Entity: Role

#### 13.3.4.1 Objetivo

Representar los roles funcionales disponibles dentro de BudgetKeep para controlar el acceso de los usuarios a las diferentes funcionalidades del sistema.

Un Role representa un conjunto lógico de permisos que puede ser asignado a uno o varios usuarios mediante la entidad UserRole.

---

#### 13.3.4.2 Responsabilidades

La entidad Role es responsable de:

- Identificar un perfil de autorización dentro del sistema.
- Agrupar permisos relacionados con las funcionalidades de BudgetKeep.
- Permitir la asignación de un conjunto de permisos a uno o varios usuarios.
- Facilitar la administración centralizada de los permisos mediante roles.

---

#### 13.3.4.3 Fuera del Alcance

La entidad Role no será responsable de:

- Autenticar usuarios.
- Validar contraseñas.
- Administrar sesiones.
- Ejecutar directamente las reglas de autorización.
- Almacenar permisos individuales asignados directamente a usuarios.

La asignación de roles a usuarios será gestionada mediante UserRole y la relación entre roles y permisos mediante RolePermission.

---

#### 13.3.4.4 Relaciones

La entidad Role mantiene relaciones con:

- UserRole
- RolePermission

Un Role podrá estar asociado con múltiples usuarios mediante UserRole.

Un Role podrá estar asociado con múltiples permisos mediante RolePermission.

---

#### 13.3.4.5 Reglas Generales

- Un Role podrá ser asignado a múltiples usuarios.
- Un usuario podrá tener múltiples roles.
- Un Role podrá contener múltiples permisos.
- Un mismo permiso podrá pertenecer a múltiples roles.
- No deberán existir dos roles con el mismo Code.
- Los roles inactivos no deberán utilizarse para nuevas asignaciones.
- La eliminación de un Role deberá respetar las relaciones existentes y las reglas de integridad referencial.
- Los roles del sistema se identificarán mediante IsSystemRole = true.
- Los roles con IsSystemRole = true estarán protegidos contra modificación o eliminación mediante las operaciones administrativas normales.
- IsSystemRole no determina los permisos del rol; los permisos se definirán mediante RolePermission.

---

#### 13.3.4.6 Atributos

La siguiente tabla define los atributos lógicos de la entidad **Role**.

La definición de tipos de datos físicos, restricciones e índices será desarrollada durante el diseño físico de la entidad.

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| RoleId | Identificador único del rol. | Sí |
| Code | Código único y estable que identifica el rol. | Sí |
| Name | Nombre descriptivo del rol. | Sí |
| Description | Descripción del propósito y alcance del rol. | No |
| IsSystemRole | Indica si el rol forma parte de la configuración protegida del sistema y no puede ser administrado mediante las operaciones administrativas normales. | Sí |
| IsActive | Indica si el rol se encuentra disponible para asignación. | Sí |
| CreatedAt | Fecha y hora de creación del registro. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación lógica. | No |

---

### 13.3.5 Entity: Module

#### 13.3.5.1 Objetivo

Representar las funcionalidades o áreas funcionales del sistema sobre las cuales se definirán permisos de acceso.

Un Module permite organizar los permisos de BudgetKeep de acuerdo con la funcionalidad a la que pertenecen.

---

#### 13.3.5.2 Responsabilidades

La entidad Module es responsable de:

- Identificar una funcionalidad o área funcional del sistema.
- Proporcionar una agrupación lógica para los permisos.
- Permitir que los permisos sean asociados a funcionalidades específicas mediante ModulePermission.
- Facilitar la administración y organización de la autorización del sistema.

---

#### 13.3.5.3 Fuera del Alcance

La entidad Module no será responsable de:

- Autenticar usuarios.
- Autorizar directamente una operación.
- Asignar módulos directamente a usuarios.
- Almacenar permisos individuales.
- Definir las reglas específicas de cada permiso.

La relación entre módulos y permisos será gestionada mediante ModulePermission.

---

#### 13.3.5.4 Relaciones

La entidad Module mantiene una relación con:

- ModulePermission

Un Module podrá estar asociado con múltiples permisos mediante ModulePermission.

---

#### 13.3.5.5 Reglas Generales

- Cada Module deberá tener un Code único.
- Code deberá ser estable y no depender del nombre mostrado al usuario.
- Un Module podrá tener múltiples permisos.
- Un permiso podrá estar asociado con múltiples módulos mediante ModulePermission.
- Los módulos inactivos no deberán utilizarse para nuevas configuraciones de permisos.
- La eliminación de un Module deberá respetar las relaciones existentes y las reglas de integridad referencial.

---

#### 13.3.5.6 Atributos

La siguiente tabla define los atributos lógicos de la entidad **Module**.

La definición de tipos de datos físicos, restricciones e índices será desarrollada durante el diseño físico de la entidad.

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| ModuleId | Identificador único del módulo. | Sí |
| Code | Código único y estable que identifica el módulo. | Sí |
| Name | Nombre descriptivo del módulo. | Sí |
| Description | Descripción funcional del módulo. | No |
| IsActive | Indica si el módulo se encuentra disponible para configuración y autorización. | Sí |
| CreatedAt | Fecha y hora de creación del registro. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación lógica. | No |

---

### 13.3.6 Entity: Permission

#### 13.3.6.1 Objetivo

Representar los tipos de operaciones o acciones de autorización que pueden aplicarse a las funcionalidades de BudgetKeep.

Un Permission representa una capacidad de operación reutilizable, como consultar, crear, modificar o eliminar información.

La asociación entre un Permission y una funcionalidad específica del sistema será definida mediante ModulePermission.

---

#### 13.3.6.2 Responsabilidades

La entidad Permission es responsable de:

- Identificar un tipo de operación de autorización.
- Proporcionar un catálogo reutilizable de operaciones.
- Permitir que una misma operación pueda utilizarse en diferentes módulos.
- Servir como elemento base para la construcción de permisos específicos mediante ModulePermission.

---

#### 13.3.6.3 Fuera del Alcance

La entidad Permission no será responsable de:

- Asignar permisos directamente a usuarios.
- Asignar permisos directamente a roles.
- Determinar por sí misma si un usuario puede ejecutar una operación.
- Contener reglas específicas de autorización de una funcionalidad.

La asociación entre permisos y módulos será gestionada mediante ModulePermission.

La asignación de permisos a roles será gestionada mediante RolePermission.

---

#### 13.3.6.4 Relaciones

La entidad Permission mantiene una relación con:

- ModulePermission

Un Permission podrá estar asociado con múltiples módulos mediante ModulePermission.

---

#### 13.3.6.5 Reglas Generales

- Cada Permission deberá tener un Code único.
- Code deberá ser estable y no depender del texto mostrado al usuario.
- Un Permission podrá utilizarse en múltiples módulos.
- Los permisos inactivos no deberán utilizarse para nuevas configuraciones de autorización.
- Los permisos no serán asignados directamente a usuarios.
- Los permisos no serán asociados directamente con roles; esta asociación se realizará mediante ModulePermission y RolePermission.
- La eliminación de un Permission deberá respetar las relaciones existentes y las reglas de integridad referencial.

---

#### 13.3.6.6 Atributos

La siguiente tabla define los atributos lógicos de la entidad **Permission**.

La definición de tipos de datos físicos, restricciones e índices será desarrollada durante el diseño físico de la entidad.

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| PermissionId | Identificador único del tipo de permiso. | Sí |
| Code | Código único y estable que identifica el permiso. | Sí |
| Name | Nombre descriptivo del permiso. | Sí |
| Description | Descripción del propósito y alcance del permiso. | No |
| IsActive | Indica si el permiso se encuentra disponible para configuración y autorización. | Sí |
| CreatedAt | Fecha y hora de creación del registro. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación lógica. | No |

---

### 13.3.7 Entity: ModulePermission

#### 13.3.7.1 Objetivo

Representar una combinación válida entre un Module y un Permission.

ModulePermission define una capacidad de operación concreta dentro de una funcionalidad específica de BudgetKeep.

Por ejemplo, la combinación de un módulo Payments con el permiso VIEW representa la capacidad de consultar información de Payments.

---

#### 13.3.7.2 Responsabilidades

La entidad ModulePermission es responsable de:

- Asociar un Module con un Permission.
- Definir las combinaciones válidas de módulo y operación.
- Servir como unidad de autorización reutilizable para los roles.
- Evitar que un Permission sea asignado a un Role fuera de un Module válido.

---

#### 13.3.7.3 Fuera del Alcance

La entidad ModulePermission no será responsable de:

- Asignar directamente permisos a usuarios.
- Asignar directamente permisos a roles.
- Determinar si un usuario puede ejecutar una operación.
- Ejecutar las reglas de autorización.

La asignación de una combinación ModulePermission a un Role será gestionada mediante RolePermission.

---

#### 13.3.7.4 Relaciones

La entidad ModulePermission mantiene relaciones con:

- Module
- Permission
- RolePermission

Un Module podrá tener múltiples combinaciones ModulePermission.

Un Permission podrá utilizarse en múltiples Modules.

Un ModulePermission podrá estar asociado con múltiples Roles mediante RolePermission.

---

#### 13.3.7.5 Reglas Generales

- La combinación `(ModuleId, PermissionId)` será única.
- La combinación `(ModuleId, PermissionId)` será la Primary Key de la entidad.
- ModuleId deberá referenciar un Module existente.
- PermissionId deberá referenciar un Permission existente.
- No deberán existir combinaciones duplicadas entre Module y Permission.
- Un ModulePermission inactivo no deberá utilizarse para nuevas configuraciones de autorización.
- La eliminación de un Module o Permission deberá respetar las relaciones existentes y las reglas de integridad referencial.

---

#### 13.3.7.6 Atributos

La siguiente tabla define los atributos lógicos de la entidad **ModulePermission**.

La definición de tipos de datos físicos, restricciones e índices será desarrollada durante el diseño físico de la entidad.

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| ModuleId | Identificador del módulo al que pertenece el permiso. | Sí |
| PermissionId | Identificador del tipo de permiso asociado al módulo. | Sí |
| IsActive | Indica si la combinación módulo-permiso se encuentra disponible para autorización. | Sí |
| CreatedAt | Fecha y hora de creación del registro. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación lógica. | No |

---

### 13.3.8 Entity: UserRole

#### 13.3.8.1 Objetivo

Representar la asignación de uno o varios roles a los usuarios de BudgetKeep.

UserRole es una entidad puente que implementa la relación muchos a muchos entre User y Role.

---

#### 13.3.8.2 Responsabilidades

La entidad UserRole es responsable de:

- Asociar un usuario con un rol.
- Permitir que un usuario tenga múltiples roles.
- Permitir que un rol sea asignado a múltiples usuarios.
- Evitar asignaciones duplicadas entre un mismo usuario y un mismo rol.

---

#### 13.3.8.3 Fuera del Alcance

La entidad UserRole no será responsable de:

- Autenticar usuarios.
- Definir los permisos de un rol.
- Ejecutar reglas de autorización.
- Almacenar información de credenciales.
- Definir permisos individuales.

Los permisos asociados a un rol serán gestionados mediante RolePermission.

---

#### 13.3.8.4 Relaciones

La entidad UserRole mantiene relaciones con:

- User
- Role

Un User podrá tener múltiples registros en UserRole.

Un Role podrá tener múltiples registros en UserRole.

---

#### 13.3.8.5 Reglas Generales

- La combinación `(UserId, RoleId)` será única.
- La combinación `(UserId, RoleId)` será la Primary Key de la entidad.
- UserId deberá referenciar un User existente.
- RoleId deberá referenciar un Role existente.
- No deberán existir asignaciones duplicadas entre un usuario y un rol.
- Una asignación deberá eliminarse o desactivarse de acuerdo con las reglas de autorización definidas por el sistema.
- La eliminación de un User o Role deberá respetar las relaciones existentes y las reglas de integridad referencial.

---

#### 13.3.8.6 Atributos

La siguiente tabla define los atributos lógicos de la entidad **UserRole**.

La definición de tipos de datos físicos, restricciones e índices será desarrollada durante el diseño físico de la entidad.

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| UserId | Identificador del usuario al que se asigna el rol. | Sí |
| RoleId | Identificador del rol asignado al usuario. | Sí |
| CreatedAt | Fecha y hora de creación de la asignación. | Sí |
| CreatedBy | Usuario responsable de la asignación. | No |
| UpdatedAt | Fecha y hora de la última modificación de la asignación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |

---

### 13.3.9 Entity: RolePermission

#### 13.3.9.1 Objetivo

Representar la asignación de una combinación ModulePermission a un Role.

RolePermission define qué operaciones puede realizar un Role dentro de una funcionalidad específica de BudgetKeep.

---

#### 13.3.9.2 Responsabilidades

La entidad RolePermission es responsable de:

- Asociar un Role con una combinación ModulePermission.
- Definir las capacidades de autorización disponibles para cada Role.
- Evitar asignaciones duplicadas de una misma combinación de módulo y permiso a un mismo Role.
- Servir como base para determinar las capacidades autorizadas de los usuarios a través de sus roles.

---

#### 13.3.9.3 Fuera del Alcance

La entidad RolePermission no será responsable de:

- Autenticar usuarios.
- Asignar roles a usuarios.
- Validar contraseñas.
- Ejecutar directamente las reglas de autorización.
- Definir permisos fuera de un Module válido.

La asignación de roles a usuarios será gestionada mediante UserRole.

---

#### 13.3.9.4 Relaciones

La entidad RolePermission mantiene relaciones con:

- Role
- ModulePermission

Un Role podrá tener múltiples registros en RolePermission.

Un ModulePermission podrá estar asociado con múltiples Roles.

La relación con ModulePermission utilizará las columnas:

- ModuleId
- PermissionId

como una Foreign Key compuesta.

---

#### 13.3.9.5 Reglas Generales

- La combinación `(RoleId, ModuleId, PermissionId)` será única.
- La combinación `(RoleId, ModuleId, PermissionId)` será la Primary Key de la entidad.
- RoleId deberá referenciar un Role existente.
- `(ModuleId, PermissionId)` deberá referenciar un ModulePermission existente.
- No deberán existir asignaciones duplicadas entre un Role y una combinación ModulePermission.
- Un RolePermission deberá representar únicamente una combinación ModulePermission válida.
- La eliminación de un Role o ModulePermission deberá respetar las relaciones existentes y las reglas de integridad referencial.

---

#### 13.3.9.6 Atributos

La siguiente tabla define los atributos lógicos de la entidad **RolePermission**.

La definición de tipos de datos físicos, restricciones e índices será desarrollada durante el diseño físico de la entidad.

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| RoleId | Identificador del rol al que se asigna la capacidad. | Sí |
| ModuleId | Identificador del módulo de la capacidad autorizada. | Sí |
| PermissionId | Identificador del permiso de la capacidad autorizada. | Sí |
| CreatedAt | Fecha y hora de creación de la asignación. | Sí |
| CreatedBy | Usuario responsable de la asignación. | No |
| UpdatedAt | Fecha y hora de la última modificación de la asignación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |

---

### 13.3.10 Entity: UserPreference

#### 13.3.10.1 Objetivo

Almacenar las preferencias configurables de cada usuario de BudgetKeep.

La entidad UserPreference representa la configuración personal asociada a un usuario y permite mantener estas preferencias separadas de la información funcional y de seguridad de la cuenta.

---

#### 13.3.10.2 Responsabilidades

La entidad UserPreference es responsable de:

- Almacenar las preferencias personales del usuario.
- Mantener una única configuración de preferencias por usuario.
- Permitir que las preferencias puedan evolucionar sin modificar la estructura principal de User.
- Mantener las preferencias asociadas exclusivamente al usuario propietario.

---

#### 13.3.10.3 Fuera del Alcance

La entidad UserPreference no será responsable de:

- Almacenar credenciales.
- Administrar autenticación.
- Administrar autorización.
- Almacenar información financiera.
- Almacenar configuraciones globales del sistema.

Las configuraciones globales serán gestionadas mediante SystemConfiguration.

---

#### 13.3.10.4 Relaciones

La entidad UserPreference mantiene una relación uno a uno con:

- User

UserPreference.UserId será simultáneamente Primary Key y Foreign Key hacia User.UserId.

Un User podrá tener como máximo un registro UserPreference.

---

#### 13.3.10.5 Reglas Generales

- UserId será la Primary Key de la entidad.
- UserId será también Foreign Key hacia User.UserId.
- No podrá existir más de un registro UserPreference para el mismo usuario.
- UserPreference no podrá existir sin un User correspondiente.
- Las preferencias deberán pertenecer exclusivamente al usuario identificado por UserId.
- Las preferencias no deberán utilizarse para almacenar configuraciones globales del sistema.
- La eliminación de un User deberá respetar las reglas de integridad referencial definidas para UserPreference.

---

#### 13.3.10.6 Atributos

La siguiente tabla define los atributos lógicos de la entidad **UserPreference**.

La definición de tipos de datos físicos, restricciones e índices será desarrollada durante el diseño físico de la entidad.

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| UserId | Identificador del usuario propietario de las preferencias. | Sí |
| PreferredLanguageId | Idioma preferido para la interfaz y comunicación del sistema. | Sí |
| TimeZoneId | Zona horaria utilizada para presentar fechas y horas al usuario. | Sí |
| CreatedAt | Fecha y hora de creación del registro. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |

---

### 13.3.11 Entity: SystemConfiguration

#### 13.3.11.1 Objetivo

Centralizar los valores de configuración global utilizados por BudgetKeep que puedan requerir modificación sin alterar la estructura de la base de datos ni incorporar valores fijos directamente en el código de la aplicación.

La entidad SystemConfiguration constituye la fuente persistente de configuración para parámetros técnicos y de seguridad definidos para el sistema.

---

#### 13.3.11.2 Responsabilidades

La entidad SystemConfiguration es responsable de:

- Mantener configuraciones globales del sistema.
- Proporcionar un identificador único para cada configuración.
- Mantener el valor actual de cada configuración.
- Identificar el tipo de dato representado por cada valor.
- Proporcionar una descripción funcional de cada configuración.
- Permitir activar o desactivar configuraciones cuando corresponda.

---

#### 13.3.11.3 Fuera del Alcance

SystemConfiguration no será utilizada para almacenar:

- Contraseñas.
- Password hashes.
- Tokens de acceso.
- Claves criptográficas.
- Secretos.
- Información personal de los usuarios.
- Información financiera del usuario.

Los secretos, credenciales, claves criptográficas, tokens y demás información sensible de infraestructura deberán utilizar los mecanismos de seguridad y gestión de secretos definidos por la Arquitectura Técnica y las disciplinas correspondientes.

SystemConfiguration podrá almacenar parámetros técnicos y de seguridad no secretos, pero no deberá utilizarse como almacén de secretos.

---

#### 13.3.11.4 Relaciones

SystemConfiguration no mantiene relaciones funcionales con las entidades de negocio.

SystemConfiguration mantiene una relación técnica con ConfigurationDataType mediante ConfigurationDataTypeId.

Cada SystemConfiguration deberá utilizar exactamente un ConfigurationDataType válido.
Un ConfigurationDataType podrá ser utilizado por múltiples registros de SystemConfiguration.

Las configuraciones serán consultadas por los componentes de aplicación que requieran su valor.

---

#### 13.3.11.5 Reglas Generales

- Cada configuración deberá poseer un Code único.
- Code deberá identificar de manera estable el propósito de la configuración.
- El valor de una configuración deberá interpretarse de acuerdo con su ConfigurationDataType.
- Las configuraciones inactivas no deberán ser utilizadas por la aplicación.
- Las configuraciones de seguridad deberán mantenerse bajo control de acceso restringido.
- Los valores de configuración no deberán estar duplicados dentro de la tabla.
- La aplicación deberá utilizar un mecanismo centralizado para consultar la configuración del sistema.
- Los valores críticos de seguridad deberán contar con valores definidos en la configuración inicial del sistema.
- SystemConfiguration no deberá utilizarse como mecanismo para almacenar secretos o credenciales.
- La política inicial de seguridad utilizará los siguientes parámetros:
  - SECURITY_MAX_FAILED_LOGIN_ATTEMPTS = 5.
  - SECURITY_LOCKOUT_DURATION_MINUTES = 15.
  - SECURITY_MAX_LOCKOUT_COUNT = 3.
  - SECURITY_LOCKOUT_COUNT_WINDOW_DAYS = 30.
- Los valores anteriores constituyen la configuración inicial de BudgetKeep y deberán almacenarse en SystemConfiguration.
- La aplicación deberá obtener estos valores mediante el mecanismo centralizado de consulta de configuración del sistema.
- ConfigurationDataTypeId deberá referenciar un registro válido de ConfigurationDataType.
- El catálogo inicial de tipos de configuración estará compuesto por:
  - INT
  - DECIMAL
  - BOOLEAN
  - STRING
  - DATETIME2
- No se permitirán valores de tipo de configuración que no estén definidos en ConfigurationDataType.
- La incorporación de nuevos tipos deberá realizarse mediante una decisión de diseño y actualización del catálogo correspondiente.

---

#### 13.3.11.6 Atributos

La siguiente tabla define los atributos lógicos de la entidad **SystemConfiguration**.

La definición de tipos de datos físicos, restricciones e índices será desarrollada durante el diseño físico de la entidad.

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| SystemConfigurationId | Identificador único de la configuración. | Sí |
| Code | Código único y estable que identifica la configuración. | Sí |
| Value | Valor persistente de la configuración. | Sí |
| ConfigurationDataTypeId | Identificador del tipo de dato utilizado para interpretar Value. | Sí |
| Description | Descripción del propósito y comportamiento de la configuración. | Sí |
| IsActive | Indica si la configuración se encuentra activa y puede ser utilizada. | Sí |
| CreatedAt | Fecha y hora de creación del registro. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |

---

### 13.3.12 Entity: ConfigurationDataType

#### 13.3.12.1 Objetivo

Representar el catálogo controlado de tipos de datos permitidos para los valores almacenados en SystemConfiguration.

---

#### 13.3.12.2 Responsabilidades

La entidad ConfigurationDataType es responsable de:

- Definir los tipos de datos permitidos para SystemConfiguration.
- Proporcionar un catálogo controlado y reutilizable.
- Evitar valores arbitrarios o inconsistentes en SystemConfiguration.ConfigurationDataTypeId.
- Permitir la incorporación controlada de nuevos tipos de datos cuando sea necesario.

---

#### 13.3.12.3 Fuera del Alcance

ConfigurationDataType no será responsable de:

- Almacenar valores de configuración.
- Interpretar o convertir directamente los valores.
- Almacenar configuraciones globales.
- Almacenar información de negocio.

---

#### 13.3.12.4 Relaciones

La entidad ConfigurationDataType mantiene una relación con:

- SystemConfiguration

Un ConfigurationDataType podrá estar asociado con múltiples registros de SystemConfiguration.

Cada SystemConfiguration deberá utilizar un ConfigurationDataType válido.

---

#### 13.3.12.5 Reglas Generales

- Cada ConfigurationDataType deberá tener un Code único.
- Code deberá ser estable y no depender del nombre mostrado.
- No deberán existir tipos de datos duplicados.
- Solo los tipos activos podrán utilizarse para nuevas configuraciones.
- La incorporación de nuevos tipos deberá realizarse mediante una decisión de diseño y actualización del catálogo correspondiente.

---

#### 13.3.12.6 Atributos

La siguiente tabla define los atributos lógicos de la entidad **ConfigurationDataType**.

La definición de tipos de datos físicos, restricciones e índices será desarrollada durante el diseño físico de la entidad.

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| ConfigurationDataTypeId | Identificador único del tipo de dato. | Sí |
| Code | Código único y estable del tipo de dato. | Sí |
| Name | Nombre descriptivo del tipo de dato. | Sí |
| Description | Descripción del tipo de dato y su uso. | No |
| IsActive | Indica si el tipo de dato puede utilizarse para nuevas configuraciones. | Sí |
| CreatedAt | Fecha y hora de creación del registro. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |

### 13.3.13 Relaciones del Dominio

Las relaciones del dominio Identity & Security se definen de la siguiente manera:

#### User

- User 1:1 UserSecurity
  - UserSecurity.UserId es Primary Key y Foreign Key hacia User.UserId.
  - Cada User deberá tener exactamente un registro UserSecurity.
  - Cada UserSecurity deberá pertenecer exactamente a un User.

- User 1:1 UserPreference
  - UserPreference.UserId es Primary Key y Foreign Key hacia User.UserId.
  - Cada User podrá tener como máximo un registro UserPreference.

- User 1:N UserRole
  - UserRole.UserId referencia User.UserId.
  - Un User podrá tener múltiples roles.

#### Role

- Role 1:N UserRole
  - UserRole.RoleId referencia Role.RoleId.
  - Un Role podrá estar asignado a múltiples usuarios.

- Role 1:N RolePermission
  - RolePermission.RoleId referencia Role.RoleId.
  - Un Role podrá tener múltiples capacidades autorizadas.

#### Module

- Module 1:N ModulePermission
  - ModulePermission.ModuleId referencia Module.ModuleId.
  - Un Module podrá tener múltiples permisos.

#### Permission

- Permission 1:N ModulePermission
  - ModulePermission.PermissionId referencia Permission.PermissionId.
  - Un Permission podrá utilizarse en múltiples módulos.

#### ModulePermission

- ModulePermission 1:N RolePermission
  - RolePermission.(ModuleId, PermissionId) es Foreign Key compuesta hacia ModulePermission.(ModuleId, PermissionId).
  - Un ModulePermission podrá estar asociado con múltiples roles.

- La Primary Key de ModulePermission es (ModuleId, PermissionId).
- La combinación ModuleId + PermissionId no podrá repetirse.

#### UserRole

- La Primary Key de UserRole es (UserId, RoleId).
- La combinación UserId + RoleId no podrá repetirse.

#### RolePermission

- La Primary Key de RolePermission es (RoleId, ModuleId, PermissionId).
- La combinación RoleId + ModuleId + PermissionId no podrá repetirse.

#### UserPreference

- UserPreference.UserId es Primary Key y Foreign Key hacia User.UserId.
- La relación User → UserPreference es uno a uno.
- Un User podrá tener como máximo un registro UserPreference.

#### SystemConfiguration

- ConfigurationDataTypeId referencia ConfigurationDataType.ConfigurationDataTypeId.
- Un SystemConfiguration deberá utilizar exactamente un ConfigurationDataType válido.
- SystemConfiguration no mantiene relaciones Foreign Key con las entidades funcionales del dominio.

#### ConfigurationDataType

- ConfigurationDataType 1:N SystemConfiguration.
- Un ConfigurationDataType podrá ser utilizado por múltiples registros SystemConfiguration.
- La incorporación de nuevos tipos deberá realizarse mediante una decisión de diseño y actualización del catálogo correspondiente.

### 13.3.14 Dominio: Catalogs

Este dominio agrupa las entidades de catálogo utilizadas por BudgetKeep para proporcionar valores controlados y reutilizables por diferentes componentes del sistema.

El diseño de este dominio se desarrollará de manera incremental. En esta etapa se definen las entidades Language y TimeZone, requeridas por las preferencias del usuario.

Las entidades de este dominio seguirán las convenciones generales de auditoría definidas para BudgetKeep. Cuando una entidad incluya los atributos CreatedBy o UpdatedBy, estos deberán referenciar User.UserId. Estos atributos podrán ser NULL cuando el registro sea creado o modificado mediante procesos de inicialización, migración o ejecución técnica que no cuenten con un usuario autenticado responsable de la operación.

Las entidades definidas en esta etapa son:

- Language
- TimeZone

### 13.3.15 Entity: Language

#### 13.3.15.1 Objetivo

Representar el catálogo de idiomas disponibles para BudgetKeep.

La entidad Language proporciona los valores controlados que pueden ser utilizados por las preferencias de idioma de los usuarios y permite mantener una referencia estable para el idioma seleccionado.

#### 13.3.15.2 Responsabilidades

La entidad Language es responsable de:

- Identificar de forma única cada idioma disponible.
- Mantener el código estándar del idioma.
- Mantener el nombre descriptivo del idioma.
- Controlar la disponibilidad del idioma mediante IsActive.
- Proporcionar una referencia reutilizable para las preferencias de idioma de los usuarios.

#### 13.3.15.3 Fuera del Alcance

La entidad Language no será responsable de:

- Determinar el idioma preferido de un usuario.
- Almacenar las preferencias completas del usuario.
- Gestionar traducciones de textos de la aplicación.
- Implementar la lógica de internacionalización.

La selección del idioma preferido por cada usuario será responsabilidad de UserPreference.

#### 13.3.15.4 Relaciones

La entidad Language mantiene una relación con:

- UserPreference

Un Language podrá ser utilizado como idioma preferido por múltiples usuarios.

La relación será implementada mediante:

UserPreference.PreferredLanguageId → Language.LanguageId

#### 13.3.15.5 Reglas Generales

- Cada Language deberá tener un Code único.
- Code deberá representar el identificador estándar del idioma.
- Code deberá ser estable y no depender del nombre mostrado al usuario.
- Name deberá representar el nombre descriptivo del idioma.
- Los idiomas inactivos no deberán utilizarse para nuevas preferencias.
- La eliminación de un Language deberá respetar las relaciones existentes y las reglas de integridad referencial.

#### 13.3.15.6 Atributos

La siguiente tabla define los atributos lógicos de la entidad **Language**.

La definición de tipos de datos físicos, restricciones e índices será desarrollada durante el diseño físico de la entidad.

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| LanguageId | Identificador único del idioma. | Sí |
| Code | Código estándar y estable que identifica el idioma. | Sí |
| Name | Nombre descriptivo del idioma. | Sí |
| IsActive | Indica si el idioma se encuentra disponible para selección. | Sí |
| CreatedAt | Fecha y hora de creación del registro. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |

### 13.3.16 Entity: TimeZone

#### 13.3.16.1 Objetivo

Representar el catálogo de zonas horarias disponibles para BudgetKeep.

La entidad TimeZone proporciona los valores controlados que pueden ser utilizados por las preferencias de zona horaria de los usuarios y permite mantener una referencia estable para la zona horaria seleccionada.

#### 13.3.16.2 Responsabilidades

La entidad TimeZone es responsable de:

- Identificar de forma única cada zona horaria disponible.
- Mantener el identificador estándar de la zona horaria.
- Mantener el nombre descriptivo de la zona horaria.
- Controlar la disponibilidad de la zona horaria mediante IsActive.
- Proporcionar una referencia reutilizable para las preferencias de zona horaria de los usuarios.

#### 13.3.16.3 Fuera del Alcance

La entidad TimeZone no será responsable de:

- Determinar la zona horaria preferida de un usuario.
- Almacenar las preferencias completas del usuario.
- Realizar conversiones de fechas y horas.
- Implementar la lógica de presentación de fechas y horas.

La selección de la zona horaria utilizada por cada usuario será responsabilidad de UserPreference.

#### 13.3.16.4 Relaciones

La entidad TimeZone mantiene una relación con:

- UserPreference

Una TimeZone podrá ser utilizada por múltiples usuarios como zona horaria preferida.

La relación será implementada mediante:

UserPreference.TimeZoneId → TimeZone.TimeZoneId

#### 13.3.16.5 Reglas Generales

- Cada TimeZone deberá tener un Code único.
- Code deberá representar el identificador estándar de la zona horaria.
- Code deberá ser estable y no depender del nombre mostrado al usuario.
- Name deberá representar el nombre descriptivo de la zona horaria.
- Las zonas horarias inactivas no deberán utilizarse para nuevas preferencias.
- La eliminación de una TimeZone deberá respetar las relaciones existentes y las reglas de integridad referencial.

#### 13.3.16.6 Atributos

La siguiente tabla define los atributos lógicos de la entidad **TimeZone**.

La definición de tipos de datos físicos, restricciones e índices será desarrollada durante el diseño físico de la entidad.

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| TimeZoneId | Identificador único de la zona horaria. | Sí |
| Code | Identificador estándar y estable de la zona horaria. | Sí |
| Name | Nombre descriptivo de la zona horaria. | Sí |
| IsActive | Indica si la zona horaria se encuentra disponible para selección. | Sí |
| CreatedAt | Fecha y hora de creación del registro. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |

### 13.3.17 Relaciones del Dominio Catalogs

Las relaciones del dominio Catalogs se definen de la siguiente manera:

#### Language

- Language 1:N UserPreference
  - UserPreference.PreferredLanguageId referencia Language.LanguageId.
  - Un Language podrá ser utilizado como idioma preferido por múltiples usuarios.
  - Cada UserPreference deberá utilizar un Language válido.

#### TimeZone

- TimeZone 1:N UserPreference
  - UserPreference.TimeZoneId referencia TimeZone.TimeZoneId.
  - Una TimeZone podrá ser utilizada por múltiples usuarios.
  - Cada UserPreference deberá utilizar una TimeZone válida.

### 13.3.18 Dominio: Financial Resources

El dominio Financial Resources agrupa las entidades responsables de
representar los recursos financieros que forman parte de la realidad
financiera del usuario.

Las entidades que conforman este dominio son:

- Financial Resource
- Currency

### 13.3.19 Entity: Financial Resource

#### 13.3.19.1 Objetivo

Representar los recursos financieros que el usuario incorpora a su
realidad financiera y que puede utilizar para atender sus obligaciones.

#### 13.3.19.2 Responsabilidades

La entidad Financial Resource es responsable de:

- Identificar cada recurso financiero del usuario.
- Asociar el recurso con su propietario.
- Identificar el tipo de recurso financiero.
- Identificar la moneda del recurso.
- Mantener el importe disponible del recurso.
- Mantener el estado del recurso.

#### 13.3.19.3 Relaciones

Financial Resource mantiene las siguientes relaciones:

- User 1:N Financial Resource.
- Currency 1:N Financial Resource.

Cada Financial Resource pertenece obligatoriamente a un único User.

Cada Financial Resource utiliza obligatoriamente una única Currency.

#### 13.3.19.4 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| FinancialResourceId | Identificador único del recurso financiero. | Sí |
| UserId | Usuario propietario del recurso. | Sí |
| Name | Nombre asignado por el usuario al recurso. | Sí |
| ResourceType | Tipo de recurso financiero. | Sí |
| CurrencyId | Moneda en la que se expresa el recurso. | Sí |
| AvailableAmount | Importe actualmente disponible del recurso. | Sí |
| IsActive | Indica si el recurso está activo. | Sí |
| CreatedAt | Fecha y hora de creación del registro. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación lógica. | No |

### 13.3.20 Entity: Currency

#### 13.3.20.1 Objetivo

Representar el catálogo oficial de monedas utilizadas por BudgetKeep
para soportar la operación multimoneda del producto.

#### 13.3.20.2 Responsabilidades

La entidad Currency es responsable de:

- Identificar de forma única una moneda.
- Proporcionar el código de la moneda.
- Proporcionar el nombre de la moneda.
- Proporcionar el símbolo utilizado para su representación.
- Indicar si la moneda se encuentra activa.

#### 13.3.20.3 Relaciones

Currency mantiene una relación 1:N con Financial Resource.

Una Currency puede ser utilizada por múltiples Financial Resources.

#### 13.3.20.4 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| CurrencyId | Identificador único de la moneda. | Sí |
| Code | Código único y estable de la moneda. | Sí |
| Name | Nombre descriptivo de la moneda. | Sí |
| Symbol | Símbolo utilizado para representar la moneda. | Sí |
| IsActive | Indica si la moneda está disponible para uso. | Sí |
| CreatedAt | Fecha y hora de creación del registro. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |

### 13.3.21 Relaciones del Dominio Financial Resources

- User 1:N Financial Resource.
  - FinancialResource.UserId referencia User.UserId.
  - Cada Financial Resource pertenece obligatoriamente a un único User.

- Currency 1:N Financial Resource.
  - FinancialResource.CurrencyId referencia Currency.CurrencyId.
  - Cada Financial Resource utiliza obligatoriamente una única Currency.

  ### 13.3.22 Cierre del Dominio Financial Resources

El dominio Financial Resources queda cerrado después de completar y
validar su diseño lógico, diseño físico, implementación y artefactos
de soporte.

Artefactos completados:

- Diseño lógico de Financial Resource y Currency.
- ERD Level 1 actualizado.
- Decisiones físicas documentadas.
- Scripts de creación de tablas.
- Scripts de Foreign Keys.
- Scripts de índices.
- Seed inicial de Currency.
- Script de validación.
- Scripts de rollback.

La implementación del dominio fue ejecutada correctamente en Azure SQL
y validada mediante el script correspondiente.

### 13.3.23 Dominio: Financial Events

El dominio Financial Events agrupa las entidades responsables de representar
las definiciones de ingresos y gastos del Usuario, las reglas opcionales de
recurrencia y las ocurrencias financieras correspondientes.

Las entidades que conforman este dominio son:

- Income
- Expense
- Financial Event
- StandAlone
- RecurrenceType
- RecurrenceConfiguration

El modelo separa la definición financiera de su ocurrencia.

`Income` y `Expense` representan definiciones configuradas por el Usuario.

`Financial Event` representa una ocurrencia financiera concreta.

Una misma definición de Income o Expense podrá generar múltiples Financial
Event a lo largo del tiempo.

La recurrencia es opcional. Cuando existe, BudgetKeep utilizará la
RecurrenceConfiguration para determinar automáticamente las futuras
ocurrencias esperadas sin requerir que el Usuario registre manualmente cada
fecha.

#### 13.3.23.1 Entity: Income

##### 13.3.23.1.1 Objetivo

Representar una definición de ingreso configurada por un Usuario.

Un Income representa el concepto de ingreso que el Usuario desea controlar,
organizar y, cuando corresponda, utilizar como base para generar futuras
ocurrencias financieras.

Ejemplos:

- Salario.
- Salario secundario.
- Freelance.
- Ingresos por inversiones.
- Otros ingresos definidos por el Usuario.

##### 13.3.23.1.2 Responsabilidades

La entidad Income es responsable de:

- Identificar el ingreso configurado por el Usuario.
- Asociar el ingreso con su propietario.
- Identificar el nombre del ingreso.
- Identificar su tipo u origen.
- Identificar la moneda utilizada.
- Mantener un importe esperado o de referencia cuando corresponda.
- Asociar opcionalmente una configuración de recurrencia.
- Mantener la definición del ingreso independientemente de sus ocurrencias.

##### 13.3.23.1.3 Relaciones

Income mantiene las siguientes relaciones:

- User 1:N Income.
- Currency 1:N Income.
- IncomeType 1:N Income.
- Income 1:0..1 RecurrenceConfiguration.
- Income 1:N Financial Event.

Cada Income pertenece obligatoriamente a un único User.

Cada Income utiliza una única Currency.

Cada Income utiliza un único IncomeType.

Un Income podrá tener como máximo una RecurrenceConfiguration.

Una RecurrenceConfiguration podrá estar asociada a un único Income.

Un Income podrá generar múltiples Financial Event.

Cada Financial Event generado a partir de un Income deberá conservar la
referencia al Income que lo originó.

##### 13.3.23.1.4 Reglas Generales

- Todo Income deberá pertenecer a un User.
- Todo Income deberá tener un nombre.
- Todo Income deberá utilizar una Currency válida.
- Todo Income deberá utilizar un IncomeType válido.
- La recurrencia será opcional.
- Un Income podrá generar múltiples Financial Event.
- La modificación de un Income no deberá modificar automáticamente los
  Financial Event históricos.
- El importe definido en Income representará un importe esperado o de
  referencia y no sustituirá el importe real de una ocurrencia confirmada.
- Un Income podrá existir sin Financial Event cuando todavía no haya
  ocurrido ninguna de sus ocurrencias.

##### 13.3.23.1.5 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| IncomeId | Identificador único de la definición de ingreso. | Sí |
| UserId | Usuario propietario del ingreso. | Sí |
| Name | Nombre del ingreso. | Sí |
| IncomeTypeId | Tipo u origen del ingreso. | Sí |
| CurrencyId | Moneda utilizada para expresar el ingreso. | Sí |
| ExpectedAmount | Importe esperado o de referencia para futuras ocurrencias. | No |
| IsActive | Indica si la definición del ingreso continúa disponible para nuevas ocurrencias. | Sí |
| CreatedAt | Fecha y hora de creación. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación lógica. | No |

---

#### 13.3.23.2 Entity: Expense

##### 13.3.23.2.1 Objetivo

Representar una definición de gasto configurada por un Usuario.

Un Expense representa el concepto de gasto que el Usuario desea controlar,
organizar y, cuando corresponda, utilizar como base para generar futuras
ocurrencias financieras.

Ejemplos:

- Renta de casa.
- Luz.
- Agua.
- Supermercado.
- Gasolina.
- Otros gastos definidos por el Usuario.

##### 13.3.23.2.2 Responsabilidades

La entidad Expense es responsable de:

- Identificar el gasto configurado por el Usuario.
- Asociar el gasto con su propietario.
- Identificar el nombre del gasto.
- Identificar su categoría.
- Identificar si se trata de un gasto fijo o variable.
- Identificar la moneda utilizada.
- Mantener un importe esperado o de referencia cuando corresponda.
- Asociar opcionalmente una configuración de recurrencia.
- Mantener la definición del gasto independientemente de sus ocurrencias.

##### 13.3.23.2.3 Relaciones

Expense mantiene las siguientes relaciones:

- User 1:N Expense.
- Currency 1:N Expense.
- ExpenseCategory 1:N Expense.
- Expense 1:0..1 RecurrenceConfiguration.
- Expense 1:N Financial Event.

Cada Expense pertenece obligatoriamente a un único User.

Cada Expense utiliza una única Currency.

Cada Expense utiliza una única ExpenseCategory.

Un Expense podrá tener como máximo una RecurrenceConfiguration.

Una RecurrenceConfiguration podrá estar asociada a un único Expense.

Un Expense podrá generar múltiples Financial Event.

Cada Financial Event generado a partir de un Expense deberá conservar la
referencia al Expense que lo originó.

##### 13.3.23.2.4 Reglas Generales

- Todo Expense deberá pertenecer a un User.
- Todo Expense deberá tener un nombre.
- Todo Expense deberá utilizar una Currency válida.
- Todo Expense deberá utilizar una ExpenseCategory válida.
- Todo Expense deberá identificar si es Fixed o Variable.
- La recurrencia será opcional.
- Un Expense podrá generar múltiples Financial Event.
- La modificación de un Expense no deberá modificar automáticamente los
  Financial Event históricos.
- El importe definido en Expense representará un importe esperado o de
  referencia y no sustituirá el importe real de una ocurrencia confirmada.
- Un Expense podrá existir sin Financial Event cuando todavía no haya
  ocurrido ninguna de sus ocurrencias.

##### 13.3.23.2.5 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| ExpenseId | Identificador único de la definición de gasto. | Sí |
| UserId | Usuario propietario del gasto. | Sí |
| Name | Nombre del gasto. | Sí |
| ExpenseCategoryId | Categoría del gasto. | Sí |
| ExpenseType | Indica si el gasto es Fixed o Variable. | Sí |
| CurrencyId | Moneda utilizada para expresar el gasto. | Sí |
| ExpectedAmount | Importe esperado o de referencia para futuras ocurrencias. | No |
| IsActive | Indica si la definición del gasto continúa disponible para nuevas ocurrencias. | Sí |
| CreatedAt | Fecha y hora de creación. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación lógica. | No |

---

#### 13.3.23.3 Entity: Financial Event

##### 13.3.23.3.1 Objetivo

Representar una ocurrencia financiera concreta correspondiente a un ingreso
o gasto esperado o registrado por el Usuario.

Financial Event constituye el registro persistente de la ocurrencia y
permite conservar separadamente la información esperada y la información
real confirmada por el Usuario.

##### 13.3.23.3.2 Responsabilidades

La entidad Financial Event es responsable de:

- Identificar una ocurrencia financiera.
- Asociar la ocurrencia con su User.
- Identificar si corresponde a Income o Expense.
- Identificar la fuente que originó la ocurrencia mediante Income, Expense o
  StandAlone.
- Mantener la fecha esperada.
- Mantener la fecha real cuando el Usuario confirme la ocurrencia.
- Mantener el importe esperado.
- Mantener el importe real confirmado.
- Mantener el estado de la ocurrencia.
- Conservar la información histórica de la ocurrencia.

##### 13.3.23.3.3 Relaciones

Financial Event mantiene las siguientes relaciones:

- User 1:N Financial Event.
- Income 1:N Financial Event.
- Expense 1:N Financial Event.
- StandAlone 1:N Financial Event.
- Currency 1:N Financial Event.
- Related Entity 1:N Financial Event.

Un Financial Event pertenece obligatoriamente a un único User.

Un Financial Event deberá estar asociado a exactamente una de las siguientes
fuentes:

- Income.
- Expense.
- StandAlone.

Un Financial Event no podrá estar asociado simultáneamente a más de una
fuente.

Cuando la fuente sea Income, FinancialEvent.IncomeId deberá estar informado.

Cuando la fuente sea Expense, FinancialEvent.ExpenseId deberá estar
informado.

Cuando la fuente sea StandAlone, FinancialEvent.StandAloneId deberá estar
informado.

La relación con Related Entity será opcional.

Cuando FinancialEvent.RelatedEntityId esté informado, la Related Entity
deberá pertenecer al mismo User propietario del Financial Event.

Related Entity representa la contraparte que el Usuario decide identificar
para la ocurrencia financiera.

Related Entity no representa obligatoriamente el comercio o establecimiento
donde se realizó una compra.

##### 13.3.23.3.4 Reglas Generales

- Todo Financial Event deberá pertenecer a un User.
- Todo Financial Event deberá tener un EventType válido.
- EventType deberá identificar si el evento corresponde a INCOME o EXPENSE.
- Todo Financial Event deberá tener exactamente una fuente.
- La fuente de un Financial Event deberá ser Income, Expense o StandAlone.
- IncomeId, ExpenseId y StandAloneId no podrán estar informados
  simultáneamente.
- IncomeId, ExpenseId y StandAloneId no podrán estar los tres en NULL.
- Cuando IncomeId esté informado, ExpenseId y StandAloneId deberán estar en
  NULL.
- Cuando ExpenseId esté informado, IncomeId y StandAloneId deberán estar en
  NULL.
- Cuando StandAloneId esté informado, IncomeId y ExpenseId deberán estar en
  NULL.
- Un Financial Event generado automáticamente a partir de una recurrencia
  deberá iniciar en estado EXPECTED.
- Un Financial Event generado desde StandAlone podrá iniciar en estado
  CONFIRMED cuando el Usuario indique que el evento ya ocurrió.
- Un Financial Event EXPECTED no deberá considerarse parte de la Realidad
  Financiera confirmada.
- La llegada o el vencimiento de ExpectedDate no deberá cambiar
  automáticamente el estado del evento.
- El Usuario deberá confirmar explícitamente la ocurrencia.
- La confirmación deberá permitir al Usuario registrar el importe real de
  la ocurrencia.
- Al confirmar un evento, ActualAmount deberá representar el importe real
  informado por el Usuario.
- ExpectedAmount y ActualAmount podrán ser diferentes.
- Un evento CONFIRMED deberá conservar la información proporcionada por el
  Usuario.
- Un evento EXPECTED que no sea confirmado deberá permanecer EXPECTED,
  independientemente de que ExpectedDate haya pasado.
- Un evento confirmado podrá tener una ActualDate diferente de ExpectedDate.
- La modificación de una configuración de recurrencia no deberá modificar
  Financial Event históricos.
- La modificación de Income, Expense o StandAlone no deberá modificar
  Financial Event históricos.

  - Todo Financial Event confirmado deberá conservar la Currency
  correspondiente a la ocurrencia financiera.
- La Currency de un Financial Event forma parte de su información histórica
  y no deberá modificarse para reflejar cambios posteriores en la Base
  Currency del Usuario.
- RelatedEntityId podrá ser NULL.
- Cuando RelatedEntityId esté informado, la Related Entity deberá pertenecer
  al mismo User propietario del Financial Event.
- La Related Entity asociada a un Financial Event representa la contraparte
  que el Usuario decidió identificar para esa ocurrencia.
- La ausencia de RelatedEntityId no impedirá registrar ni confirmar un
  Financial Event.
- Un Financial Event generado desde Income, Expense o StandAlone podrá
  asociarse opcionalmente a una Related Entity.
- La modificación de la Base Currency del Usuario no deberá modificar
  CurrencyId ni los importes históricos de Financial Event.

##### 13.3.23.3.5 Atributos

| Atributo | Descripción | Obligatorio |
|---|---|---|
| FinancialEventId | Identificador único de la ocurrencia financiera. | Sí |
| UserId | Usuario propietario del evento. | Sí |
| EventType | Indica si la ocurrencia corresponde a Income o Expense. | Sí |
| IncomeId | Definición de Income que originó la ocurrencia. | No |
| ExpenseId | Definición de Expense que originó la ocurrencia. | No |
| StandAloneId | Evento StandAlone que originó la ocurrencia. | No |
| RelatedEntityId | Entidad Relacionada que el Usuario decide asociar a la ocurrencia. | No |
| CurrencyId | Moneda en la que está expresado el importe de la ocurrencia financiera. | Sí |
| ExpectedDate | Fecha esperada calculada o registrada para la ocurrencia. | Sí |
| ActualDate | Fecha real informada por el Usuario al confirmar la ocurrencia. | No |
| ExpectedAmount | Importe esperado o de referencia para la ocurrencia. | No |
| ActualAmount | Importe real informado por el Usuario al confirmar la ocurrencia. | No |
| EventStatus | Estado de la ocurrencia. | Sí |
| CreatedAt | Fecha y hora de creación del evento. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación lógica. | No |

##### 13.3.23.3.6 Estados de Financial Event

Los estados definidos para Financial Event son:

- `EXPECTED`: ocurrencia prevista por BudgetKeep o registrada como
  esperada, pero todavía no confirmada por el Usuario.
- `CONFIRMED`: ocurrencia confirmada explícitamente por el Usuario.

La base de datos no deberá cambiar automáticamente `EXPECTED` a
`CONFIRMED` por el simple transcurso del tiempo.


#### 13.3.23.4 Entity: StandAlone

##### 13.3.23.4.1 Objetivo

Representar un evento financiero registrado directamente por el Usuario que
no proviene de una definición previa de Income o Expense y que no utiliza una
configuración de recurrencia.

StandAlone constituye una de las tres posibles fuentes de Financial Event:

- Income.
- Expense.
- StandAlone.

A diferencia de Income y Expense, StandAlone no utiliza una configuración de
recurrencia ni genera automáticamente ocurrencias futuras.

Un mismo StandAlone podrá utilizarse como fuente de múltiples Financial Event
cuando el mismo tipo de evento vuelva a ocurrir y el Usuario lo registre
nuevamente.

##### 13.3.23.4.2 Responsabilidades

La entidad StandAlone es responsable de:

- Identificar el evento financiero registrado directamente por el Usuario.
- Asociar el evento con su propietario.
- Identificar si el evento corresponde a un ingreso o un gasto.
- Proporcionar una descripción del evento.
- Identificar la moneda utilizada.
- Servir como fuente para la creación del Financial Event correspondiente.
- Mantener la información propia del origen StandAlone separada de la
  información común de Financial Event.

##### 13.3.23.4.3 Fuera del Alcance

StandAlone no será responsable de:

- Generar recurrencias.
- Administrar configuraciones de recurrencia.
- Representar una definición recurrente de Income o Expense.
- Administrar el estado de Financial Event.
- Sustituir Financial Event como registro de la ocurrencia financiera.
- Mantener información que corresponda exclusivamente al registro de la
  ocurrencia en Financial Event.

##### 13.3.23.4.4 Relaciones

StandAlone mantiene las siguientes relaciones:

- User 1:N StandAlone.
- Currency 1:N StandAlone.
- StandAlone 1:N Financial Event.

Cada StandAlone pertenece obligatoriamente a un único User.

Cada StandAlone utiliza una única Currency.

Un StandAlone podrá originar múltiples Financial Event.

Un Financial Event podrá estar asociado con un único StandAlone cuando ésta
sea su fuente.

##### 13.3.23.4.5 Reglas Generales

- Todo StandAlone deberá pertenecer a un User.
- Todo StandAlone deberá tener un EventType válido.
- EventType deberá identificar si el evento corresponde a INCOME o EXPENSE.
- Todo StandAlone deberá tener una Description.
- Todo StandAlone deberá utilizar una Currency válida.
- StandAlone no tendrá RecurrenceConfiguration.
- Un StandAlone representa una fuente no recurrente de Financial Event.
- La moneda de un StandAlone no deberá modificarse como parte de una
  modificación del evento.
- Si el Usuario necesita registrar el mismo concepto en otra moneda, deberá
  crearse un nuevo StandAlone.
- Un StandAlone no deberá duplicar la información común que pertenece a
  Financial Event.

##### 13.3.23.4.6 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| StandAloneId | Identificador único del evento StandAlone. | Sí |
| UserId | Usuario propietario del evento. | Sí |
| EventType | Indica si el evento corresponde a INCOME o EXPENSE. | Sí |
| Description | Descripción del evento financiero. | Sí |
| CurrencyId | Moneda utilizada para expresar el evento. | Sí |
| CreatedAt | Fecha y hora de creación del registro. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación lógica. | No |

---

#### 13.3.23.5 Entity: RecurrenceType

##### 13.3.23.5.1 Objetivo

Representar el catálogo de reglas de calendario soportadas por BudgetKeep
para determinar las fechas de futuras ocurrencias.

##### 13.3.23.5.2 Responsabilidades

RecurrenceType es responsable de:

- Identificar una regla de calendario.
- Proporcionar un código estable para la regla.
- Proporcionar una descripción comprensible de la regla.
- Permitir que RecurrenceConfiguration utilice reglas controladas.

##### 13.3.23.5.3 Relaciones

RecurrenceType mantiene una relación 1:N con RecurrenceConfiguration.

Un RecurrenceType podrá ser utilizado por múltiples configuraciones de
recurrencia.

##### 13.3.23.5.4 Reglas Generales

- Cada RecurrenceType deberá tener un Code único.
- Code deberá ser estable y no depender del nombre mostrado al Usuario.
- Solo los tipos activos podrán utilizarse para nuevas configuraciones.
- La definición de la regla deberá representar un patrón de calendario y
  no asumir que toda recurrencia consiste en sumar una cantidad fija de días.

##### 13.3.23.5.5 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| RecurrenceTypeId | Identificador único del tipo de recurrencia. | Sí |
| Code | Código único y estable de la regla de recurrencia. | Sí |
| Name | Nombre descriptivo de la regla. | Sí |
| Description | Descripción del comportamiento de la regla. | No |
| IsActive | Indica si la regla está disponible para nuevas configuraciones. | Sí |
| CreatedAt | Fecha y hora de creación. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |

##### 13.3.23.5.6 Reglas iniciales

El catálogo deberá soportar como mínimo las siguientes reglas:

- `MONTHLY_DAY`: un día específico de cada mes.
- `MONTHLY_15_LAST`: día 15 y último día de cada mes.
- `WEEKLY_WEEKDAY`: un día específico de la semana cada semana.
- `BIWEEKLY_WEEKDAY`: un día específico de la semana cada dos semanas,
  determinado mediante una fecha de referencia.
- `ANNUAL_DATE`: una fecha específica de cada año.

La denominación mostrada al Usuario podrá ser independiente del Code
técnico.

---

#### 13.3.23.6 Entity: RecurrenceConfiguration

##### 13.3.23.6.1 Objetivo

Representar la configuración concreta de recurrencia asociada a una
definición de Income o Expense.

La configuración permitirá que BudgetKeep determine automáticamente las
fechas futuras de las ocurrencias sin que el Usuario tenga que registrarlas
individualmente.

Una RecurrenceConfiguration deberá pertenecer a un Income o a un Expense,
pero nunca a ambos.

##### 13.3.23.6.2 Responsabilidades

RecurrenceConfiguration es responsable de:

- Identificar la definición de Income o Expense a la que pertenece.
- Asociar la definición financiera con una regla de recurrencia.
- Identificar la fecha a partir de la cual aplica la recurrencia.
- Identificar opcionalmente la fecha en la que termina.
- Mantener los parámetros requeridos por la regla de calendario.
- Permitir activar o desactivar una recurrencia.
- Proporcionar la información necesaria para calcular ocurrencias futuras.
- Permitir que BudgetKeep genere automáticamente ocurrencias esperadas sin
  requerir que el Usuario registre manualmente cada fecha.

##### 13.3.23.6.3 Relaciones

RecurrenceConfiguration mantiene las siguientes relaciones:

- Income 1:0..1 RecurrenceConfiguration.
- Expense 1:0..1 RecurrenceConfiguration.
- RecurrenceType 1:N RecurrenceConfiguration.

Una RecurrenceConfiguration deberá estar asociada a un único Income o a un
único Expense.

Una RecurrenceConfiguration no podrá estar asociada simultáneamente a un
Income y a un Expense.

Una definición de Income podrá tener como máximo una
RecurrenceConfiguration.

Una definición de Expense podrá tener como máximo una
RecurrenceConfiguration.

Una RecurrenceConfiguration deberá utilizar un único RecurrenceType.

##### 13.3.23.6.4 Reglas Generales

- Toda RecurrenceConfiguration deberá utilizar un RecurrenceType válido.
- Toda RecurrenceConfiguration deberá tener una fecha de inicio.
- La fecha de finalización será opcional.
- Una configuración activa podrá generar futuras ocurrencias esperadas.
- Una configuración inactiva no deberá generar nuevas ocurrencias.
- La configuración deberá contener los parámetros necesarios para la regla
  seleccionada.
- Una RecurrenceConfiguration deberá tener exactamente uno de los siguientes
  valores:
  - IncomeId.
  - ExpenseId.
- IncomeId y ExpenseId no podrán estar informados simultáneamente.
- IncomeId y ExpenseId no podrán estar ambos en NULL.
- Una configuración de recurrencia no representa una ocurrencia financiera.
- Modificar la configuración no deberá modificar Financial Event históricos.
- Las fechas futuras deberán calcularse conforme a la regla de calendario
  seleccionada.
- Una regla mensual no deberá interpretarse como una simple suma fija de
  días.
- Una regla catorcenal deberá utilizar una fecha de referencia para
  determinar la secuencia de ocurrencias.
- Los parámetros de calendario deberán ser consistentes con el
  RecurrenceType seleccionado.

##### 13.3.23.6.5 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| RecurrenceConfigurationId | Identificador único de la configuración. | Sí |
| IncomeId | Definición de Income a la que pertenece la configuración. | Condicional |
| ExpenseId | Definición de Expense a la que pertenece la configuración. | Condicional |
| RecurrenceTypeId | Regla de calendario utilizada. | Sí |
| StartDate | Fecha a partir de la cual aplica la recurrencia. | Sí |
| EndDate | Fecha en la que deja de aplicar la recurrencia. | No |
| DayOfMonth | Día del mes utilizado por reglas que requieren un día específico. | Condicional |
| DayOfWeek | Día de la semana utilizado por reglas semanales o catorcenales. | Condicional |
| AnchorDate | Fecha de referencia utilizada para establecer la secuencia de recurrencias. | Condicional |
| IsActive | Indica si la configuración continúa vigente. | Sí |
| CreatedAt | Fecha y hora de creación. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación lógica. | No |

Los atributos `DayOfMonth`, `DayOfWeek` y `AnchorDate` serán obligatorios o
nulos de acuerdo con las necesidades del `RecurrenceType` seleccionado.

La validación específica de los parámetros requeridos por cada tipo de
recurrencia será definida durante el diseño físico y la implementación de
la lógica correspondiente.

---

#### 13.3.23.7 Relaciones del Dominio Financial Events

Las relaciones del dominio Financial Events se definen de la siguiente
manera:

##### User

- User 1:N Income.
  - Income.UserId referencia User.UserId.

- User 1:N Expense.
  - Expense.UserId referencia User.UserId.

- User 1:N StandAlone.
  - StandAlone.UserId referencia User.UserId.

- User 1:N Financial Event.
  - FinancialEvent.UserId referencia User.UserId.

##### Income

- Income 1:N Financial Event.
  - FinancialEvent.IncomeId referencia Income.IncomeId.
  - Un Income podrá generar múltiples Financial Event.

- Income 1:0..1 RecurrenceConfiguration.
  - RecurrenceConfiguration.IncomeId referencia Income.IncomeId.
  - Un Income podrá tener como máximo una RecurrenceConfiguration.

##### Expense

- Expense 1:N Financial Event.
  - FinancialEvent.ExpenseId referencia Expense.ExpenseId.
  - Un Expense podrá generar múltiples Financial Event.

- Expense 1:0..1 RecurrenceConfiguration.
  - RecurrenceConfiguration.ExpenseId referencia Expense.ExpenseId.
  - Un Expense podrá tener como máximo una RecurrenceConfiguration.

##### StandAlone

- StandAlone 1:N Financial Event.
  - FinancialEvent.StandAloneId referencia StandAlone.StandAloneId.
  - Un StandAlone podrá originar múltiples Financial Event.

##### Currency

- Currency 1:N Income.
  - Income.CurrencyId referencia Currency.CurrencyId.

- Currency 1:N Expense.
  - Expense.CurrencyId referencia Currency.CurrencyId.

- Currency 1:N StandAlone.
  - StandAlone.CurrencyId referencia Currency.CurrencyId.

##### IncomeType

- IncomeType 1:N Income.
  - Income.IncomeTypeId referencia IncomeType.IncomeTypeId.

##### ExpenseCategory

- ExpenseCategory 1:N Expense.
  - Expense.ExpenseCategoryId referencia ExpenseCategory.ExpenseCategoryId.

##### RecurrenceType

- RecurrenceType 1:N RecurrenceConfiguration.
  - RecurrenceConfiguration.RecurrenceTypeId referencia
    RecurrenceType.RecurrenceTypeId.

##### RecurrenceConfiguration

- Una RecurrenceConfiguration deberá pertenecer a un Income o a un Expense.
- Una RecurrenceConfiguration no podrá pertenecer simultáneamente a un
  Income y un Expense.
- IncomeId y ExpenseId serán opcionales individualmente, pero exactamente uno
  de ellos deberá estar informado.
- Una RecurrenceConfiguration no representa una ocurrencia financiera.
- La modificación de una RecurrenceConfiguration no deberá modificar
  Financial Event históricos.

#### 13.3.23.8 Reglas de Integridad del Dominio

Las siguientes reglas deberán preservarse durante el diseño lógico, el diseño
físico y la implementación del dominio Financial Events.

##### Financial Event

1. Todo Financial Event deberá pertenecer obligatoriamente a un User.

2. Todo Financial Event deberá tener un EventType válido.

3. EventType deberá identificar si el evento corresponde a INCOME o EXPENSE.

4. Todo Financial Event deberá tener exactamente una fuente.

5. La fuente de un Financial Event deberá ser Income, Expense o StandAlone.

6. IncomeId, ExpenseId y StandAloneId no podrán estar los tres en NULL.

7. IncomeId, ExpenseId y StandAloneId no podrán estar informados
   simultáneamente.

8. Cuando IncomeId esté informado, ExpenseId y StandAloneId deberán estar
   en NULL.

9. Cuando ExpenseId esté informado, IncomeId y StandAloneId deberán estar
   en NULL.

10. Cuando StandAloneId esté informado, IncomeId y ExpenseId deberán estar
    en NULL.

11. Un Financial Event generado automáticamente a partir de una recurrencia
    deberá iniciar en estado EXPECTED.

12. Un Financial Event generado desde StandAlone podrá iniciar en estado
    CONFIRMED cuando el Usuario indique que el evento ya ocurrió.

13. Un Financial Event EXPECTED no deberá considerarse parte de la Realidad
    Financiera confirmada.

14. La llegada o el vencimiento de ExpectedDate no deberá cambiar
    automáticamente el estado del evento.

15. El estado EXPECTED deberá permanecer sin cambios hasta que exista una
    acción explícita del Usuario.

16. Un Financial Event CONFIRMED deberá tener ActualDate y ActualAmount
    informados.

17. Un Financial Event EXPECTED no deberá tener ActualDate ni ActualAmount.

18. La confirmación de un Financial Event deberá permitir al Usuario informar
    el importe real de la ocurrencia.

19. ExpectedAmount y ActualAmount podrán ser diferentes.

20. ExpectedDate y ActualDate podrán ser diferentes.

21. ExpectedAmount representará el importe esperado o de referencia de la
    ocurrencia.

22. ActualAmount representará exclusivamente el importe real informado por el
    Usuario al confirmar la ocurrencia.

23. ActualAmount será la información utilizada como importe confirmado para
    efectos de la Realidad Financiera.

24. La modificación de Income, Expense o StandAlone no deberá modificar
    automáticamente Financial Event históricos.

25. La modificación de RecurrenceConfiguration no deberá modificar
    Financial Event históricos.

26. Los Financial Event históricos deberán conservar la información que
    correspondía a la ocurrencia cuando fueron registrados o confirmados.

##### RecurrenceConfiguration

27. Toda RecurrenceConfiguration deberá utilizar un RecurrenceType válido.

28. Toda RecurrenceConfiguration deberá tener StartDate.

29. EndDate será opcional.

30. Una RecurrenceConfiguration deberá estar asociada a un Income o a un
    Expense.

31. Una RecurrenceConfiguration no podrá estar asociada simultáneamente a un
    Income y un Expense.

32. IncomeId y ExpenseId no podrán estar ambos en NULL.

33. IncomeId y ExpenseId no podrán estar ambos informados.

34. Una definición de Income podrá tener como máximo una
    RecurrenceConfiguration.

35. Una definición de Expense podrá tener como máximo una
    RecurrenceConfiguration.

36. Una RecurrenceConfiguration activa podrá utilizarse para generar futuras
    ocurrencias EXPECTED.

37. Una RecurrenceConfiguration inactiva no deberá generar nuevas ocurrencias.

38. Una RecurrenceConfiguration no representa una ocurrencia financiera.

39. La configuración de recurrencia deberá contener los parámetros requeridos
    por el RecurrenceType seleccionado.

40. Una regla de recurrencia mensual deberá calcularse de acuerdo con el
    calendario mensual correspondiente y no mediante una suma fija de días
    cuando la regla represente una posición dentro del mes.

41. La regla de recurrencia `MONTHLY_15_LAST` deberá representar el día 15 y
    el último día de cada mes.

42. Una regla de recurrencia `BIWEEKLY_WEEKDAY` deberá utilizar DayOfWeek y
    AnchorDate para determinar la secuencia de ocurrencias cada dos semanas.

43. Los parámetros de calendario que no correspondan al RecurrenceType
    seleccionado deberán permanecer NULL.

##### Income y Expense

44. Todo Income deberá pertenecer a un User.

45. Todo Expense deberá pertenecer a un User.

46. Todo Income deberá utilizar una Currency válida.

47. Todo Expense deberá utilizar una Currency válida.

48. Todo Income deberá utilizar un IncomeType válido.

49. Todo Expense deberá utilizar una ExpenseCategory válida.

50. ExpenseType deberá identificar únicamente los valores permitidos para
    gasto Fixed o Variable.

51. ExpectedAmount de Income y Expense representará el importe esperado o de
    referencia para futuras ocurrencias.

52. El cambio de ExpectedAmount en Income o Expense no deberá modificar
    ExpectedAmount ni ActualAmount de Financial Event históricos.

##### Realidad Financiera

53. Un Financial Event EXPECTED representa una expectativa o planificación,
    no una ocurrencia financiera confirmada.

54. Un Financial Event CONFIRMED representa una ocurrencia confirmada
    explícitamente por el Usuario.

55. BudgetKeep no deberá inferir que un evento ocurrió únicamente porque haya
    llegado o pasado su fecha esperada.

56. La ausencia de confirmación del Usuario no deberá convertirse
    automáticamente en confirmación por el transcurso del tiempo.

57. La Realidad Financiera confirmada deberá derivarse de Financial Event
    CONFIRMED y de las relaciones financieras correspondientes definidas por
    los demás dominios.

##### Historial

58. Los Financial Event históricos deberán conservar la información que
    correspondía a la ocurrencia cuando fue registrada o confirmada.

59. Los cambios posteriores realizados sobre Income, Expense o
    RecurrenceConfiguration no deberán alterar los Financial Event
    históricos.

60. La diferencia entre ExpectedAmount y ActualAmount deberá conservarse para
    permitir análisis posteriores de desviación entre lo esperado y lo real.

61. La diferencia entre ExpectedDate y ActualDate deberá conservarse cuando
    ambas existan para permitir análisis posteriores de desviación temporal.

#### 13.3.23.9 Consideraciones de Implementación

La implementación de Financial Events deberá mantener una separación clara
entre las responsabilidades de persistencia de la base de datos y la lógica
de aplicación.

##### Persistencia

La base de datos será responsable de:

- Persistir las definiciones de Income y Expense.
- Persistir los eventos StandAlone.
- Persistir las configuraciones de recurrencia.
- Persistir las ocurrencias financieras en Financial Event.
- Mantener las relaciones entre las tres fuentes y Financial Event.
- Garantizar la integridad referencial.
- Garantizar las reglas estructurales de integridad definidas para
  Financial Event, StandAlone y RecurrenceConfiguration.
- Conservar el importe esperado y el importe real de cada ocurrencia.
- Conservar la fecha esperada y la fecha real cuando ambas existan.
- Conservar el estado de cada Financial Event.
- Preservar la información histórica de las ocurrencias.

##### Lógica de recurrencia

La lógica de aplicación será responsable de:

- Interpretar el RecurrenceType.
- Calcular las fechas futuras de acuerdo con la regla de calendario.
- Utilizar los parámetros de RecurrenceConfiguration para calcular las
  ocurrencias.
- Generar las ocurrencias futuras esperadas.
- Evitar la generación duplicada de una misma ocurrencia.
- Determinar el horizonte de generación de ocurrencias.
- Mantener las ocurrencias futuras de acuerdo con los cambios válidos en la
  configuración.
- Presentar las ocurrencias al Usuario.
- Solicitar o facilitar la confirmación de las ocurrencias.

La base de datos no deberá implementar por sí misma la lógica necesaria para
calcular calendarios recurrentes.

##### Confirmación de ocurrencias

La confirmación de una ocurrencia será una acción explícita del Usuario.

La aplicación deberá permitir que el Usuario confirme una ocurrencia
`EXPECTED` mediante una interacción simple.

Al confirmar una ocurrencia, la aplicación deberá permitir registrar:

- ActualDate.
- ActualAmount.

El Usuario podrá confirmar una ocurrencia utilizando una fecha real
diferente de la fecha esperada.

El Usuario podrá confirmar una ocurrencia utilizando un importe real
diferente del importe esperado.

La aplicación no deberá confirmar automáticamente una ocurrencia únicamente
porque haya llegado o pasado su ExpectedDate.

La ausencia de confirmación no deberá modificar automáticamente el estado
del evento.

##### ExpectedAmount y ActualAmount

`ExpectedAmount` representa el importe esperado para una ocurrencia.

`ActualAmount` representa el importe real informado por el Usuario cuando la
ocurrencia es confirmada.

Ambos valores deberán conservarse independientemente cuando existan.

Ejemplo:

- ExpectedAmount = 800.
- ActualAmount = 780.

La diferencia entre ambos valores deberá permanecer disponible para análisis
posteriores.

El `ExpectedAmount` de Financial Event constituirá información persistente
que podrá utilizarse posteriormente como entrada para el dominio Financial
Planning / Budget.

El dominio Financial Events no será responsable de calcular ni administrar
el presupuesto.

##### ExpectedDate y ActualDate

`ExpectedDate` representa la fecha esperada de acuerdo con la configuración
o información registrada.

`ActualDate` representa la fecha real proporcionada por el Usuario al
confirmar la ocurrencia.

Ambas fechas deberán conservarse cuando sean diferentes.

La diferencia entre ExpectedDate y ActualDate deberá permanecer disponible
para análisis posteriores.

##### Eventos sin recurrencia

La aplicación deberá permitir registrar Financial Event sin una
RecurrenceConfiguration.

Estos eventos podrán corresponder a:

- eventos únicos;
- eventos no recurrentes;
- eventos cuya fecha no siga un patrón;
- eventos cuya recurrencia no sea conocida;
- eventos que ya ocurrieron.

Cuando el Usuario registre directamente un evento que ya ocurrió, la
aplicación podrá crearlo directamente como `CONFIRMED`, utilizando la fecha
y el importe informados por el Usuario.

##### Historial

Los Financial Event históricos deberán permanecer independientes de los
cambios posteriores realizados sobre:

- Income;
- Expense;
- RecurrenceType;
- RecurrenceConfiguration.

Modificar una configuración de recurrencia no deberá modificar los eventos
históricos que ya hayan sido generados.

Modificar ExpectedAmount en Income o Expense no deberá modificar los
ExpectedAmount ni ActualAmount de Financial Event históricos.

##### Consulta mensual

La aplicación deberá proporcionar una consulta mensual de Financial Events.

La consulta deberá incluir tanto eventos:

- `EXPECTED`; como
- `CONFIRMED`.

La consulta mensual deberá permitir al Usuario visualizar su realidad
financiera desde la perspectiva de:

- lo que esperaba que ocurriera;
- lo que ya confirmó que ocurrió;
- los importes esperados;
- los importes reales;
- las fechas esperadas;
- las fechas reales cuando existan.

Un evento `EXPECTED` cuya fecha haya pasado no deberá desaparecer de la
consulta ni convertirse automáticamente en `CONFIRMED`.

##### Fuente de verdad

La información confirmada explícitamente por el Usuario constituye la
fuente de verdad para determinar qué ocurrió realmente.

BudgetKeep no deberá inferir una ocurrencia financiera a partir únicamente
de:

- el paso del tiempo;
- la fecha esperada;
- la existencia de una configuración de recurrencia;
- el importe esperado.

La existencia de una ocurrencia `EXPECTED` representa una expectativa de
BudgetKeep y no una afirmación de que la operación financiera haya ocurrido.

##### Responsabilidad de Financial Reality

Financial Reality continuará siendo un concepto derivado.

La Realidad Financiera confirmada deberá obtenerse mediante consultas,
agregaciones y reglas de negocio basadas en la información persistente
confirmada y en las relaciones financieras correspondientes.

Financial Events no deberá crear una entidad independiente denominada
Financial Reality.

##### Integridad de la generación

La lógica de aplicación deberá garantizar que una misma ocurrencia esperada
no sea generada más de una vez.

La identificación de una ocurrencia deberá considerar la definición
financiera, la regla de recurrencia y la fecha correspondiente, conforme a
las reglas que se definan para la implementación.

Los mecanismos específicos para evitar duplicados serán definidos durante
el diseño físico y la implementación del Backend, manteniendo consistencia
con las restricciones de integridad de esta especificación.

##### Evolución futura

El diseño deberá permitir que posteriormente Financial Events pueda
relacionarse con otras entidades financieras, tales como Financial
Obligation, Debt, Financial Resource, Budget u otros conceptos que se
definan en los dominios correspondientes.

Estas relaciones no deberán anticiparse dentro de Financial Events mediante
una relación polimórfica genérica.

Cada relación futura deberá definirse explícitamente en el dominio
correspondiente y utilizar Foreign Keys reales cuando la relación requiera
persistencia referencial.

### 13.3.24 Cierre del Dominio Financial Events

El dominio Financial Events queda cerrado después de completar y
validar su diseño lógico, diseño físico, implementación y artefactos
de soporte.

Artefactos completados:

- Diseño lógico de Income, Expense, StandAlone, FinancialEvent,
  RecurrenceType y RecurrenceConfiguration.
- ERD Level 1 actualizado.
- Decisiones físicas documentadas.
- Scripts de creación de tablas.
- Scripts de Foreign Keys.
- Scripts de índices.
- Seed inicial de RecurrenceType.
- Scripts de validación.
- Scripts de rollback.
- Implementación en Azure SQL Database.
- Validación de la implementación en Azure SQL Database.

La implementación del dominio fue ejecutada correctamente en Azure SQL
Database.

La validación confirmó:

- Existencia de todas las tablas requeridas.
- Existencia y activación de los cinco tipos iniciales de recurrencia.
- Integridad de la regla de fuente única de FinancialEvent.
- Integridad de los estados EXPECTED y CONFIRMED.

El dominio Financial Events queda establecido como línea base para las
disciplinas posteriores que dependan de sus entidades y reglas.

### 13.3.25 Dominio: Financial Planning

El dominio Financial Planning agrupa las entidades responsables de
persistir las Estrategias Financieras generadas por BudgetKeep, los Planes
Financieros adoptados por el Usuario y las relaciones necesarias para
preservar su composición, ejecución y trazabilidad.

El dominio soporta las capacidades funcionales:

- FC-007 – Estrategias Financieras.
- FC-008 – Planificación Financiera.

Las entidades que conforman este dominio son:

- Financial Strategy
- Financial Strategy Item
- Financial Plan
- Financial Plan Item
- Financial Plan Strategy
- Financial Plan Resource
- Financial Plan Item Event

Financial Strategy representa una recomendación generada por BudgetKeep.

Financial Plan representa exclusivamente las decisiones adoptadas por el
Usuario.

Financial Strategy no modifica Financial Reality y Financial Plan no
modifica automáticamente Financial Reality.

El avance del Financial Plan se obtiene relacionando sus acciones con los
Financial Events correspondientes.

#### 13.3.25.1 Entity: Financial Strategy

##### 13.3.25.1.1 Objetivo

Representar una Estrategia Financiera generada por BudgetKeep para un
Usuario determinado.

La entidad conserva la recomendación generada para que pueda ser
consultada y utilizada posteriormente como base para la construcción de
uno o varios Planes Financieros.

##### 13.3.25.1.2 Responsabilidades

La entidad Financial Strategy es responsable de:

- Identificar de forma única una Estrategia Financiera.
- Asociar la estrategia con el Usuario para quien fue generada.
- Conservar el nombre de la estrategia.
- Conservar el objetivo financiero de la estrategia.
- Conservar la descripción de la recomendación.
- Conservar la prioridad recomendada.
- Conservar los beneficios esperados.
- Conservar las consideraciones asociadas a la estrategia.
- Mantener la recomendación como información histórica.

Financial Strategy no representa una decisión adoptada por el Usuario.

##### 13.3.25.1.3 Relaciones

Financial Strategy mantiene las siguientes relaciones:

- User 1:N Financial Strategy.
- Financial Strategy 1:N Financial Strategy Item.
- Financial Strategy N:M Financial Plan mediante Financial Plan Strategy.

Una Financial Strategy pertenece obligatoriamente a un único User.

Una Financial Strategy podrá ser utilizada como base para múltiples
Financial Plan cuando corresponda.

##### 13.3.25.1.4 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| FinancialStrategyId | Identificador único de la Estrategia Financiera. | Sí |
| UserId | Usuario para quien fue generada la estrategia. | Sí |
| Name | Nombre de la Estrategia Financiera. | Sí |
| Objective | Resultado financiero que la estrategia busca alcanzar. | Sí |
| Description | Explicación general de la estrategia propuesta. | Sí |
| RecommendedPriority | Prioridad recomendada por BudgetKeep. | No |
| ExpectedBenefits | Resultados esperados si el Usuario adopta la estrategia. | No |
| Considerations | Aspectos que el Usuario debe considerar antes de adoptar la estrategia. | No |
| CreatedAt | Fecha y hora de generación de la estrategia. | Sí |
| CreatedBy | Usuario responsable de la operación cuando exista. | No |

#### 13.3.25.2 Entity: Financial Strategy Item

##### 13.3.25.2.1 Objetivo

Representar una acción individual perteneciente al conjunto organizado de
acciones de una Financial Strategy.

Esta entidad es una estructura de persistencia de apoyo derivada de la
definición de Financial Strategy como un conjunto organizado de acciones.

No constituye un nuevo Domain Concept.

##### 13.3.25.2.2 Responsabilidades

Financial Strategy Item es responsable de:

- Asociar una acción con una Financial Strategy.
- Mantener el orden recomendado de las acciones.
- Conservar la descripción de la acción propuesta.
- Mantener la composición histórica de la estrategia generada.

##### 13.3.25.2.3 Relaciones

- Financial Strategy 1:N Financial Strategy Item.

Cada Financial Strategy Item pertenece obligatoriamente a una única
Financial Strategy.

##### 13.3.25.2.4 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| FinancialStrategyItemId | Identificador único de la acción de la estrategia. | Sí |
| FinancialStrategyId | Estrategia Financiera a la que pertenece la acción. | Sí |
| SequenceNumber | Orden de ejecución recomendado dentro de la estrategia. | Sí |
| Description | Descripción de la acción recomendada. | Sí |
| CreatedAt | Fecha y hora de creación. | Sí |
| CreatedBy | Usuario responsable de la operación cuando exista. | No |

#### 13.3.25.3 Entity: Financial Plan

##### 13.3.25.3.1 Objetivo

Representar el conjunto organizado de decisiones financieras adoptadas por
el Usuario durante un periodo determinado.

Financial Plan constituye la persistencia de las decisiones del Usuario y
sirve como referencia para la ejecución y seguimiento de dichas decisiones.

##### 13.3.25.3.2 Responsabilidades

Financial Plan es responsable de:

- Identificar de forma única el Plan Financiero.
- Asociar el plan con su propietario.
- Conservar el nombre del plan.
- Conservar el objetivo financiero.
- Conservar la fecha de inicio.
- Conservar la fecha de revisión.
- Mantener el estado del ciclo de vida.
- Conservar las notas registradas por el Usuario.
- Mantener el historial de los planes finalizados.

Financial Plan no representa una recomendación generada por BudgetKeep.

Representa exclusivamente decisiones adoptadas por el Usuario.

##### 13.3.25.3.3 Relaciones

Financial Plan mantiene las siguientes relaciones:

- User 1:N Financial Plan.
- Financial Plan 1:N Financial Plan Item.
- Financial Plan N:M Financial Strategy mediante Financial Plan Strategy.
- Financial Plan N:M Financial Resource mediante Financial Plan Resource.

Financial Plan Item mantiene además una relación N:M con Financial Event
mediante Financial Plan Item Event.

##### 13.3.25.3.4 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| FinancialPlanId | Identificador único del Plan Financiero. | Sí |
| UserId | Usuario propietario del Plan Financiero. | Sí |
| Name | Nombre utilizado para identificar el Plan. | Sí |
| Objective | Resultado financiero que el Usuario desea alcanzar. | Sí |
| StartDate | Fecha a partir de la cual el Plan comienza a ejecutarse. | Sí |
| ReviewDate | Fecha prevista para revisar o actualizar el Plan. | No |
| LifecycleStatus | Estado actual del ciclo de vida del Plan. | Sí |
| UserNotes | Observaciones, decisiones o recordatorios registrados por el Usuario. | No |
| CreatedAt | Fecha y hora de creación. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |

#### 13.3.25.4 Entity: Financial Plan Item

##### 13.3.25.4.1 Objetivo

Representar una acción individual perteneciente al conjunto organizado de
decisiones de un Financial Plan.

Esta entidad es una estructura de persistencia de apoyo derivada de la
responsabilidad del Financial Plan de permitir al Usuario definir el orden
en que ejecutará sus acciones.

No constituye un nuevo Domain Concept.

##### 13.3.25.4.2 Responsabilidades

Financial Plan Item es responsable de:

- Asociar una acción con un Financial Plan.
- Mantener el orden definido por el Usuario.
- Conservar la descripción de la acción.
- Servir como unidad de seguimiento del avance del Plan mediante los
  Financial Events relacionados.

##### 13.3.25.4.3 Relaciones

- Financial Plan 1:N Financial Plan Item.
- Financial Plan Item N:M Financial Event mediante Financial Plan Item Event.

##### 13.3.25.4.4 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| FinancialPlanItemId | Identificador único de la acción del Plan. | Sí |
| FinancialPlanId | Plan Financiero al que pertenece la acción. | Sí |
| SequenceNumber | Orden de ejecución definido por el Usuario. | Sí |
| Description | Descripción de la acción financiera. | Sí |
| CreatedAt | Fecha y hora de creación. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la última modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación lógica. | No |

#### 13.3.25.5 Entity: Financial Plan Strategy

##### 13.3.25.5.1 Objetivo

Representar la relación entre un Financial Plan y las Financial Strategies
que fueron utilizadas como base para su construcción.

La entidad permite conservar que un Plan pudo construirse a partir de una
o varias Estrategias Financieras.

##### 13.3.25.5.2 Relaciones

- Financial Plan N:M Financial Strategy.

Cada registro representa una única asociación entre un Financial Plan y
una Financial Strategy.

##### 13.3.25.5.3 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| FinancialPlanId | Plan Financiero relacionado. | Sí |
| FinancialStrategyId | Estrategia Financiera utilizada como base. | Sí |
| CreatedAt | Fecha y hora de creación de la relación. | Sí |
| CreatedBy | Usuario responsable de la asociación. | No |

#### 13.3.25.6 Entity: Financial Plan Resource

##### 13.3.25.6.1 Objetivo

Representar los Financial Resources seleccionados por el Usuario para la
ejecución de un Financial Plan.

##### 13.3.25.6.2 Relaciones

- Financial Plan N:M Financial Resource.

Cada registro representa una única selección de un Financial Resource
dentro de un Financial Plan.

##### 13.3.25.6.3 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| FinancialPlanId | Plan Financiero relacionado. | Sí |
| FinancialResourceId | Recurso Financiero seleccionado para ejecutar el Plan. | Sí |
| CreatedAt | Fecha y hora de selección. | Sí |
| CreatedBy | Usuario responsable de la selección. | No |

#### 13.3.25.7 Entity: Financial Plan Item Event

##### 13.3.25.7.1 Objetivo

Representar la relación entre una acción de un Financial Plan y los
Financial Events utilizados para evaluar su ejecución.

Esta entidad permite determinar el avance del Plan a partir de eventos
financieros registrados.

##### 13.3.25.7.2 Relaciones

- Financial Plan Item N:M Financial Event.

Un Financial Plan Item podrá relacionarse con múltiples Financial Events.

Un Financial Event podrá participar en la evaluación de múltiples
Financial Plan Items cuando corresponda.

##### 13.3.25.7.3 Atributos

| Atributo | Descripción | Obligatorio |
|----------|-------------|-------------|
| FinancialPlanItemId | Acción del Plan relacionada. | Sí |
| FinancialEventId | Evento Financiero utilizado para evaluar la acción. | Sí |
| CreatedAt | Fecha y hora de creación de la relación. | Sí |
| CreatedBy | Usuario responsable de la asociación. | No |

#### 13.3.25.8 Relaciones del Dominio Financial Planning

Las relaciones del dominio Financial Planning se definen de la siguiente
manera:

##### User

- User 1:N Financial Strategy.
- User 1:N Financial Plan.

##### Financial Strategy

- Financial Strategy 1:N Financial Strategy Item.
- Financial Strategy N:M Financial Plan mediante Financial Plan Strategy.

##### Financial Plan

- Financial Plan 1:N Financial Plan Item.
- Financial Plan N:M Financial Strategy mediante Financial Plan Strategy.
- Financial Plan N:M Financial Resource mediante Financial Plan Resource.

##### Financial Plan Item

- Financial Plan Item N:M Financial Event mediante Financial Plan Item Event.

##### Financial Resource

- Financial Resource N:M Financial Plan mediante Financial Plan Resource.

##### Financial Event

- Financial Event N:M Financial Plan Item mediante Financial Plan Item Event.

#### 13.3.25.9 Reglas de Integridad del Dominio

Las siguientes reglas deberán preservarse durante el diseño lógico,
el diseño físico y la implementación del dominio Financial Planning.

##### Financial Strategy

1. Toda Financial Strategy deberá pertenecer obligatoriamente a un User.

2. Toda Financial Strategy deberá conservar su información como una
   recomendación generada por BudgetKeep.

3. Una Financial Strategy no deberá modificar directamente Financial Reality.

4. Una Financial Strategy no deberá representar por sí misma una decisión
   adoptada por el Usuario.

5. Una Financial Strategy podrá utilizarse como base para uno o varios
   Financial Plan cuando corresponda.

##### Financial Strategy Item

6. Todo Financial Strategy Item deberá pertenecer a una única
   Financial Strategy.

7. Una Financial Strategy podrá tener múltiples Financial Strategy Items.

8. El SequenceNumber deberá identificar el orden de la acción dentro de su
   Financial Strategy.

##### Financial Plan

9. Todo Financial Plan deberá pertenecer obligatoriamente a un User.

10. Todo Financial Plan deberá tener un LifecycleStatus válido.

11. LifecycleStatus deberá admitir únicamente:
    - ACTIVE
    - FINALIZED

12. Un Financial Plan FINALIZED deberá conservarse para consultas históricas.

13. Un Financial Plan no deberá modificar automáticamente Financial Reality.

14. La modificación de un Financial Plan deberá afectar únicamente la
    planificación del Usuario.

##### Financial Plan Item

15. Todo Financial Plan Item deberá pertenecer a un único Financial Plan.

16. Una Financial Plan podrá tener múltiples Financial Plan Items.

17. El SequenceNumber deberá identificar el orden de la acción dentro de
    su Financial Plan.

##### Financial Plan Strategy

18. Una misma combinación de FinancialPlanId y FinancialStrategyId no podrá
    registrarse más de una vez.

19. Una Financial Strategy asociada a un Financial Plan deberá pertenecer
    al mismo User propietario del Plan.

##### Financial Plan Resource

20. Una misma combinación de FinancialPlanId y FinancialResourceId no podrá
    registrarse más de una vez.

21. Un Financial Resource asociado a un Financial Plan deberá pertenecer
    al mismo User propietario del Plan.

##### Financial Plan Item Event

22. Una misma combinación de FinancialPlanItemId y FinancialEventId no podrá
    registrarse más de una vez.

23. Un Financial Event relacionado con un Financial Plan Item deberá
    pertenecer al mismo User propietario del Financial Plan.

24. Financial Plan Item Event no deberá modificar ni duplicar información
    de Financial Event.

25. El avance del Financial Plan deberá obtenerse a partir de los
    Financial Events relacionados y no mediante un estado persistente
    duplicado en Financial Plan.

##### Estrategia y decisión del Usuario

26. La asociación entre Financial Strategy y Financial Plan representa
    trazabilidad de origen y no implica que el Usuario haya adoptado
    automáticamente toda la estrategia.

27. Las decisiones finalmente adoptadas por el Usuario deberán quedar
    representadas dentro de Financial Plan y sus Financial Plan Items.

### 13.3.25.10 Cierre del Dominio Financial Planning

El dominio Financial Planning queda cerrado después de completar y
validar su diseño lógico, diseño físico, implementación y artefactos
de soporte.

Artefactos completados:

- Diseño lógico de Financial Strategy, Financial Strategy Item,
  Financial Plan, Financial Plan Item, Financial Plan Strategy,
  Financial Plan Resource y Financial Plan Item Event.
- ERD Level 1 actualizado.
- Decisiones físicas documentadas.
- Scripts de creación de tablas.
- Scripts de Foreign Keys.
- Scripts de índices.
- Scripts de validación.
- Scripts de rollback.
- Implementación en Azure SQL Database.
- Validación de la implementación en Azure SQL Database.

No se requirió Seed para Financial Planning.

La implementación del dominio fue ejecutada correctamente en
Azure SQL Database.

La validación confirmó:

- Existencia de todas las tablas requeridas.
- Integridad de las Primary Keys.
- Integridad de las Foreign Keys.
- Integridad de los Check Constraints.
- Integridad de los índices requeridos.
- Integridad de las reglas de SequenceNumber.
- Integridad de LifecycleStatus.
- Integridad de las reglas de fecha de Financial Plan.
- Integridad de las relaciones entre Financial Plan y Financial Strategy.
- Integridad de las relaciones entre Financial Plan y Financial Resource.
- Integridad de las relaciones entre Financial Plan Item y Financial Event.
- Ausencia de registros huérfanos.
- Consistencia de propiedad por User.
- Ausencia de duplicados en las relaciones asociativas.

El dominio Financial Planning queda establecido como línea base para
las disciplinas posteriores que dependan de sus entidades y reglas.

### 13.3.26 Dominio: Financial Obligations

El dominio Financial Obligations agrupa las entidades responsables de
representar los compromisos económicos del Usuario, las Deudas, las
Prioridades Financieras, los Pagos y las Entidades Relacionadas utilizadas
en las operaciones financieras.

El dominio soporta principalmente la capacidad funcional:

- FC-003 – Administración de Obligaciones Financieras.

El dominio también proporciona las estructuras persistentes necesarias para
la administración de Deudas, Prioridades Financieras y Pagos.

Las entidades que conforman este dominio son:

- Financial Obligation
- Debt
- Financial Priority
- Payment
- Payment Resource
- Related Entity

Las entidades de soporte son:

- Financial Obligation Type
- Debt Type
- Related Entity Type
- Financial Obligation Recurrence Configuration

Una Financial Obligation representa un compromiso económico específico que
el Usuario debe atender.

Una Debt representa un compromiso financiero persistente que puede generar
una o varias Financial Obligations.

Una Financial Priority representa la prioridad definida por el Usuario
para ordenar la atención de sus Financial Obligations.

Un Payment representa el acto mediante el cual el Usuario atiende total o
parcialmente una única Financial Obligation.

Una Related Entity representa a una persona u organización distinta del
Usuario con la que existe una relación financiera.

Financial Event continuará siendo la representación persistente del hecho
financiero ocurrido.

Payment no sustituye a Financial Event.

Una Transfer entre Financial Resources constituye un hecho distinto y no
representa por sí misma el cumplimiento de una Financial Obligation.

#### 13.3.26.1 Entity: Financial Obligation

##### 13.3.26.1.1 Objetivo

Representar un compromiso económico específico que el Usuario debe atender
como parte de su Realidad Financiera.

##### 13.3.26.1.2 Responsabilidades

Financial Obligation es responsable de:

- identificar de forma única la obligación;
- asociar la obligación con su Usuario propietario;
- identificar su tipo;
- conservar el importe comprometido;
- conservar la moneda original;
- asociar la obligación con una Debt cuando corresponda;
- conservar la Prioridad Financiera definida por el Usuario;
- conservar las fechas necesarias para determinar su situación temporal;
- permitir registrar uno o varios Payments;
- conservar la información necesaria para determinar su cumplimiento.

##### 13.3.26.1.3 Relaciones

- User 1:N Financial Obligation.
- Financial Obligation Type 1:N Financial Obligation.
- Debt 1:N Financial Obligation.
- Financial Priority 1:N Financial Obligation.
- Currency 1:N Financial Obligation.
- Financial Obligation 1:0..1 Financial Obligation Recurrence Configuration.
- Financial Obligation 1:N Payment.

Una Financial Obligation podrá existir sin pertenecer a una Debt.

Una Financial Obligation podrá recibir múltiples Payments.

##### 13.3.26.1.4 Atributos

| Atributo | Descripción | Obligatorio |
|---|---|---|
| FinancialObligationId | Identificador único de la obligación. | Sí |
| UserId | Usuario propietario. | Sí |
| Name | Nombre utilizado para identificar la obligación. | Sí |
| FinancialObligationTypeId | Tipo de obligación. | Sí |
| DebtId | Deuda de la que deriva la obligación cuando corresponda. | No |
| Amount | Importe económico comprometido. | Sí |
| CurrencyId | Moneda original de la obligación. | Sí |
| FinancialPriorityId | Prioridad asignada por el Usuario. | No |
| DueDate | Fecha de vencimiento cuando corresponda. | No |
| LifecycleStatus | Estado del ciclo de vida de la obligación. | Sí |
| CreatedAt | Fecha y hora de creación. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de la última modificación. | No |
| UpdatedBy | Usuario responsable de la modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación. | No |

El Estado Financiero no se persistirá como una copia independiente.

El Estado Temporal no se persistirá como una copia independiente cuando
pueda obtenerse mediante las fechas de negocio persistidas.

#### 13.3.26.2 Entity: Debt

##### 13.3.26.2.1 Objetivo

Representar un compromiso financiero persistente del Usuario que mantiene
un saldo pendiente y que puede generar una o varias Financial Obligations.

##### 13.3.26.2.2 Relaciones

- User 1:N Debt.
- Debt Type 1:N Debt.
- Related Entity 1:N Debt.
- Currency 1:N Debt.
- Debt 1:N Financial Obligation.

##### 13.3.26.2.3 Atributos

| Atributo | Descripción | Obligatorio |
|---|---|---|
| DebtId | Identificador único de la deuda. | Sí |
| UserId | Usuario propietario. | Sí |
| Name | Nombre utilizado para identificar la deuda. | Sí |
| DebtTypeId | Tipo de deuda. | Sí |
| RelatedEntityId | Entidad Relacionada con la deuda. | No |
| InitialAmount | Monto inicial de la deuda cuando corresponda. | No |
| OutstandingBalance | Saldo pendiente de la deuda. | Sí |
| CurrencyId | Moneda original de la deuda. | Sí |
| InterestRate | Tasa de interés cuando corresponda. | No |
| LifecycleStatus | Estado del ciclo de vida de la deuda. | Sí |
| Notes | Observaciones registradas por el Usuario. | No |
| CreatedAt | Fecha y hora de creación. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de modificación. | No |
| UpdatedBy | Usuario responsable de la modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación. | No |

#### 13.3.26.3 Entity: Financial Priority

##### 13.3.26.3.1 Objetivo

Representar el nivel de prioridad definido por el Usuario para ordenar la
atención de sus Financial Obligations.

##### 13.3.26.3.2 Relaciones

- User 1:N Financial Priority.
- Financial Priority 1:N Financial Obligation.

##### 13.3.26.3.3 Atributos

| Atributo | Descripción | Obligatorio |
|---|---|---|
| FinancialPriorityId | Identificador único de la prioridad. | Sí |
| UserId | Usuario propietario. | Sí |
| Name | Nombre de la prioridad. | Sí |
| Level | Valor ordinal utilizado para establecer el orden. | Sí |
| Description | Descripción opcional. | No |
| LifecycleStatus | Estado del ciclo de vida. | Sí |
| CreatedAt | Fecha y hora de creación. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de modificación. | No |
| UpdatedBy | Usuario responsable de la modificación. | No |

#### 13.3.26.4 Entity: Payment

##### 13.3.26.4.1 Objetivo

Representar el acto mediante el cual el Usuario atiende total o
parcialmente una única Financial Obligation.

Payment representa un hecho financiero realizado y confirmado por el
Usuario.

##### 13.3.26.4.2 Relaciones

- User 1:N Payment.
- Financial Obligation 1:N Payment.
- Financial Event 1:0..1 Payment.
- Payment N:M Financial Resource mediante Payment Resource.

La relación entre Payment y Financial Resource será implementada mediante
la entidad asociativa Payment Resource.

Cada Payment deberá estar asociado a exactamente una Financial Obligation.

Una Financial Obligation podrá recibir múltiples Payments.

No existirá una relación N:M entre Payment y Financial Obligation.

Payment no tendrá una RelatedEntityId.

La contraparte financiera asociada al Payment podrá determinarse a través
del Financial Event relacionado y, cuando corresponda, mediante la
Financial Obligation o Debt asociada.

Un Payment atiende una Financial Obligation en la Currency definida por
dicha obligación.

Un Payment podrá utilizar uno o varios Financial Resources, incluso cuando
los Resources utilicen diferentes Currencies.

##### 13.3.26.4.3 Atributos

| Atributo | Descripción | Obligatorio |
|---|---|---|
| PaymentId | Identificador único del pago. | Sí |
| UserId | Usuario propietario. | Sí |
| FinancialObligationId | Obligación Financiera atendida por el pago. | Sí |
| FinancialEventId | Evento Financiero que representa el hecho financiero del pago. | Sí |
| CreatedAt | Fecha y hora de registro del pago. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de modificación. | No |
| UpdatedBy | Usuario responsable de la modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación. | No |

El importe, fecha y moneda del Payment serán representados por el
Financial Event asociado.

Payment no duplicará dichos valores.

##### 13.3.26.4.4 Regla de cardinalidad

Una Financial Obligation podrá recibir cero, uno o múltiples Payments.

Cada Payment deberá pertenecer a una única Financial Obligation.

Si una misma operación financiera atiende múltiples Financial Obligations,
se registrará un Payment independiente para cada Financial Obligation.

#### 13.3.26.5 Entity: Payment Resource

##### 13.3.26.5.1 Objetivo

Representar la aplicación de un Financial Resource específico para
financiar un Payment.

Payment Resource permite conservar cómo se utilizó cada Financial Resource
para atender una Financial Obligation y conservar la conversión monetaria
real cuando la moneda del Resource sea diferente de la Currency de la
Financial Obligation.

##### 13.3.26.5.2 Relaciones

- Payment 1:N Payment Resource.
- Financial Resource 1:N Payment Resource.

La relación conceptual entre Payment y Financial Resource es N:M y será
persistida mediante Payment Resource.

Un Payment podrá utilizar múltiples Financial Resources.

Un Financial Resource podrá utilizarse en múltiples Payments.

Los Financial Resources utilizados deberán pertenecer al mismo User que
el Payment.

##### 13.3.26.5.3 Atributos

| Atributo | Descripción | Obligatorio |
|---|---|---|
| PaymentResourceId | Identificador único de la aplicación del recurso al Payment. | Sí |
| PaymentId | Payment al que se aplica el recurso. | Sí |
| FinancialResourceId | Financial Resource utilizado. | Sí |
| AmountUsed | Importe realmente utilizado del Financial Resource en su propia Currency. | Sí |
| ExchangeRate | Tipo de cambio realmente aplicado para convertir AmountUsed a la Currency de la Financial Obligation. | Sí |
| AppliedAmount | Importe resultante aplicado a la Financial Obligation en la Currency de dicha obligación. | Sí |
| CreatedAt | Fecha y hora de registro de la aplicación del recurso. | Sí |
| CreatedBy | Usuario responsable de la operación. | No |

La Currency utilizada para AmountUsed se obtiene del Financial Resource
relacionado.

La Currency de AppliedAmount se obtiene de la Financial Obligation asociada
al Payment.

Cuando ambas Currencies sean iguales, ExchangeRate deberá representar una
conversión de 1:1.

ExchangeRate representa la tasa realmente aplicada por la entidad financiera
al momento de realizar el Payment.

Payment Resource conserva esta información como parte de la realidad
financiera histórica y no deberá recalcularse posteriormente por cambios
en la Base Currency del Usuario.

#### 13.3.26.6 Entity: Related Entity

##### 13.3.26.6.1 Objetivo

Representar a una persona u organización distinta del Usuario con la que
existe o existió una relación financiera.

##### 13.3.26.6.2 Relaciones

- User 1:N Related Entity.
- Related Entity Type 1:N Related Entity.
- Related Entity 1:N Financial Event.
- Related Entity 1:N Debt.

Una Related Entity podrá estar asociada a múltiples Financial Events.

Una Related Entity podrá estar asociada a múltiples Debts.

Una Related Entity no se asociará directamente a Payment.

Una Related Entity no se asociará directamente a Financial Obligation.

Cuando una Financial Obligation pertenezca a una Debt, la Related Entity
de la Debt podrá utilizarse para identificar la contraparte de la relación
financiera.

La asociación con Financial Event permitirá identificar una contraparte
específica de una ocurrencia financiera cuando el Usuario decida registrarla.

##### 13.3.26.6.3 Atributos

| Atributo | Descripción | Obligatorio |
|---|---|---|
| RelatedEntityId | Identificador único. | Sí |
| UserId | Usuario propietario de la relación. | Sí |
| Name | Nombre de la persona u organización. | Sí |
| RelatedEntityTypeId | Tipo de Entidad Relacionada. | Sí |
| LifecycleStatus | Estado del ciclo de vida. | Sí |
| Notes | Observaciones. | No |
| CreatedAt | Fecha y hora de creación. | Sí |
| CreatedBy | Usuario responsable de la creación. | No |
| UpdatedAt | Fecha y hora de modificación. | No |
| UpdatedBy | Usuario responsable de la modificación. | No |
| DeletedAt | Fecha y hora de eliminación lógica. | No |
| DeletedBy | Usuario responsable de la eliminación. | No |

#### 13.3.26.7 Entity: Financial Obligation Type

Entidad de soporte utilizada para clasificar Financial Obligations.

Deberá permitir mantener valores controlados proporcionados por el
producto y, cuando corresponda, valores definidos por el Usuario.

#### 13.3.26.8 Entity: Debt Type

Entidad de soporte utilizada para clasificar Debts.

Deberá permitir mantener valores controlados proporcionados por el
producto y, cuando corresponda, valores definidos por el Usuario.

#### 13.3.26.9 Entity: Related Entity Type

Entidad de soporte utilizada para clasificar Related Entities.

Deberá permitir mantener valores controlados proporcionados por el
producto y, cuando corresponda, valores definidos por el Usuario.

#### 13.3.26.10 Entity: Financial Obligation Recurrence Configuration

Entidad de soporte utilizada para definir la recurrencia de una
Financial Obligation.

Una Financial Obligation podrá tener como máximo una configuración activa
de recurrencia.

La configuración de recurrencia no representa por sí misma una
Financial Obligation.

La modificación de una configuración de recurrencia no deberá modificar
Financial Obligations históricas.

#### 13.3.26.11 Relaciones del Dominio Financial Obligations

##### User

- User 1:N Financial Obligation.
- User 1:N Debt.
- User 1:N Financial Priority.
- User 1:N Payment.
- User 1:N Related Entity.

##### Financial Obligation

- Financial Obligation N:1 Financial Obligation Type.
- Financial Obligation N:1 Debt.
- Financial Obligation N:1 Financial Priority.
- Financial Obligation N:1 Currency.
- Financial Obligation 1:0..1 Financial Obligation Recurrence Configuration.
- Financial Obligation 1:N Payment.

##### Debt

- Debt N:1 Debt Type.
- Debt N:1 Related Entity.
- Debt N:1 Currency.
- Debt 1:N Financial Obligation.

##### Financial Priority

- Financial Priority 1:N Financial Obligation.

##### Payment

- Payment N:1 Financial Obligation.
- Payment 1:0..1 Financial Event.
- Payment N:M Financial Resource mediante Payment Resource.

##### Payment Resource

- Payment Resource N:1 Payment.
- Payment Resource N:1 Financial Resource.

##### Related Entity

- Related Entity N:1 Related Entity Type.
- Related Entity 1:N Financial Event.
- Related Entity 1:N Debt.

##### Financial Event

- Financial Event N:1 Related Entity cuando el Usuario decida identificar
  una contraparte.

##### Recurrence

- RecurrenceType 1:N Financial Obligation Recurrence Configuration.
- Financial Obligation 1:0..1 Financial Obligation Recurrence Configuration.

Payment N:M Financial Resource se implementará mediante Payment Resource.

No existirá una entidad PaymentObligation.

No existirá una relación directa Payment → Related Entity.

No existirá una relación directa Financial Obligation → Related Entity.

#### 13.3.26.12 Reglas de Integridad del Dominio Financial Obligations

##### Financial Obligation

1. Toda Financial Obligation deberá pertenecer obligatoriamente a un User.

2. Toda Financial Obligation deberá tener un Financial Obligation Type válido.

3. Una Financial Obligation podrá o no pertenecer a una Debt.

4. Cuando una Financial Obligation pertenezca a una Debt, ambas deberán
   pertenecer al mismo User.

5. Una Financial Obligation deberá conservar su Currency original.

6. Una Financial Obligation podrá tener una Financial Priority.

7. Una Financial Priority asignada a una Financial Obligation deberá
   pertenecer al mismo User.

8. Una Financial Obligation podrá recibir múltiples Payments.

9. La información del importe comprometido de una Financial Obligation no
   deberá ser reemplazada por los importes de los Payments realizados.

10. El Financial Status de una Financial Obligation deberá obtenerse a
    partir de la información persistente de la obligación y sus Payments.

##### Debt

11. Toda Debt deberá pertenecer obligatoriamente a un User.

12. Toda Debt deberá tener un Debt Type válido.

13. Una Debt podrá generar múltiples Financial Obligations.

14. Una Debt podrá existir sin Financial Obligations.

15. Una Debt deberá conservar su Currency original.

16. El Outstanding Balance no deberá ser negativo.

17. Una Debt podrá permanecer ACTIVE aunque su Outstanding Balance sea cero
    hasta que el Usuario decida cerrarla.

18. Una Debt CLOSED podrá reabrirse conforme a las reglas de negocio cuando
    vuelva a presentar saldo pendiente.

##### Financial Priority

19. Toda Financial Priority deberá pertenecer a un único User.

20. Una Financial Priority podrá asignarse a múltiples Financial Obligations.

21. BudgetKeep no deberá modificar automáticamente la Financial Priority
    definida por el Usuario.

##### Payment

22. Todo Payment deberá pertenecer obligatoriamente a un User.

23. Todo Payment deberá estar asociado a exactamente una Financial
    Obligation.

24. Una Financial Obligation podrá tener múltiples Payments.

25. Un Payment podrá representar un pago total o parcial de su Financial
    Obligation.

26. Un Payment deberá estar asociado a un único Financial Event.

27. El Financial Event asociado a un Payment deberá estar CONFIRMED.

28. El Financial Event asociado a un Payment deberá tener EventType = EXPENSE.

29. Payment no deberá existir como proyección o evento esperado.

30. El importe, fecha y Currency de un Payment deberán corresponder al
    Financial Event asociado y a la Financial Obligation atendida.

31. Un Payment atenderá la Financial Obligation utilizando la Currency
    definida por dicha obligación.

32. Si una misma operación financiera atiende múltiples Financial
    Obligations, deberá registrarse un Payment independiente para cada
    Financial Obligation atendida.

33. No deberá existir una entidad asociativa entre Payment y Financial
    Obligation.

34. Una Transfer entre Financial Resources no deberá considerarse por sí
    misma un Payment ni el cumplimiento de una Financial Obligation.

35. Un Payment podrá utilizar uno o varios Financial Resources.

36. Los Financial Resources utilizados por un Payment deberán pertenecer al
    mismo User propietario del Payment.

37. Un Payment podrá utilizar Financial Resources con diferentes Currencies.

38. Cada utilización de un Financial Resource dentro de un Payment deberá
    registrarse mediante Payment Resource.

39. AmountUsed deberá representar el importe realmente utilizado del
    Financial Resource en la Currency de dicho Resource.

40. AppliedAmount deberá representar el importe equivalente aplicado a la
    Financial Obligation en la Currency de dicha obligación.

41. ExchangeRate deberá representar el tipo de cambio realmente aplicado
    para convertir AmountUsed a AppliedAmount.

42. La suma de AppliedAmount de todos los Payment Resource de un Payment
    deberá ser igual al importe aplicado por el Payment a la Financial
    Obligation.

43. Cuando la Currency del Financial Resource y la Currency de la Financial
    Obligation sean iguales, ExchangeRate deberá representar una conversión
    1:1.

44. ExchangeRate de Payment Resource deberá conservarse como información
    histórica y no deberá modificarse como consecuencia de cambios
    posteriores en la Base Currency del Usuario.

45. Payment no tendrá RelatedEntityId.

46. La contraparte asociada al Payment deberá determinarse mediante las
    relaciones persistentes del Financial Event, Financial Obligation o
    Debt, según corresponda.

##### Related Entity

47. Toda Related Entity deberá pertenecer a un único User.

48. Toda Related Entity deberá tener un Related Entity Type válido.

49. Una Related Entity podrá asociarse a múltiples Financial Events.

50. Una Related Entity podrá asociarse a múltiples Debts.

51. Una Related Entity podrá ser utilizada por el Usuario como contraparte
    identificable de una ocurrencia financiera, pero su asociación con un
    Financial Event será opcional.

52. La ausencia de RelatedEntityId en Financial Event no impedirá registrar
    ni confirmar la ocurrencia financiera.

53. Una Related Entity no deberá representar obligatoriamente el comercio o
    establecimiento donde se realizó una compra.

54. Retirar una Related Entity no deberá eliminar ni modificar información
    histórica asociada.

55. Una Related Entity siempre deberá representar una persona u organización
    distinta del User.

##### Recurrence

56. Una Financial Obligation podrá tener como máximo una configuración activa
    de recurrencia.

57. Una Financial Obligation Recurrence Configuration deberá pertenecer a
    una única Financial Obligation.

58. La configuración de recurrencia de Financial Obligation será
    independiente de RecurrenceConfiguration de Financial Events.

59. La modificación de una configuración de recurrencia no deberá modificar
    Financial Obligations históricas.

##### Integridad de propietario

60. Las entidades financieras relacionadas mediante Financial Obligation,
    Debt, Financial Priority, Payment, Payment Resource y Related Entity
    deberán conservar consistencia de UserId.

61. No deberá permitirse que un Payment de un User se relacione con una
    Financial Obligation perteneciente a otro User.

62. No deberá permitirse que un Payment utilice un Financial Resource
    perteneciente a otro User.

63. No deberá permitirse que una Financial Obligation se relacione con una
    Debt o Financial Priority perteneciente a otro User.

64. No deberá permitirse que una Debt se relacione con una Related Entity
    perteneciente a otro User.

65. No deberá permitirse que un Financial Event se relacione con una
    Related Entity perteneciente a otro User.

66. No deberá permitirse que un Payment Resource se relacione con un
    Payment o Financial Resource perteneciente a otro User.