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

## 13.1 Matriz de Transformación del Modelo de Dominio

La presente matriz documenta la transformación oficial entre los Conceptos del Dominio definidos en el *Business Domain Specification* y el Modelo de Persistencia definido por el *Database Design Specification*.

Su propósito es mantener la trazabilidad entre ambas disciplinas y justificar las decisiones tomadas durante el diseño de la base de datos.

La existencia de un Concepto del Dominio no implica necesariamente la existencia de una entidad persistente. Cada concepto ha sido analizado desde la perspectiva de persistencia para determinar la forma en que será representado dentro del modelo de datos.

| ID | Concepto del Dominio | Clasificación | Entidad Persistente | Observaciones |
|:---|:---------------------|:--------------|:--------------------|:--------------|
| DC-001 | User | Persistente | User | Entidad raíz del modelo. |
| DC-002 | Financial Reality | Derivado | — | Se obtiene mediante la agregación de información persistente. |
| DC-003 | Financial Obligation | Persistente | Financial Obligation | Representa compromisos financieros del usuario. |
| DC-004 | Payment | Persistente | Payment | Registra pagos realizados o programados. |
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

Las entidades técnicas necesarias para la implementación física de la base de datos, tales como configuración, auditoría, control interno u otras de naturaleza exclusivamente técnica, serán incorporadas durante el diseño del Modelo Físico de Datos y deberán mantener trazabilidad con las decisiones establecidas en la presente especificación.

---

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
| Identity & Security | Diseño DDS completado |
| Catalogs | Pendiente |
| Financial Resources | Pendiente |
| Financial Events | Pendiente |
| Financial Planning | Pendiente |
| Financial Obligations | Pendiente |
| Audit | Pendiente |

---

# 13. Diseño de Entidades

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

## 13.1 Dominio: Identity & Security

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

### 13.1.1 Reglas de Auditoría

Los atributos de auditoría CreatedBy, UpdatedBy y DeletedBy, cuando estén presentes en una entidad, deberán referenciar User.UserId.

Estas referencias representan al usuario responsable de la operación y constituyen relaciones técnicas de auditoría, no relaciones funcionales del dominio.

Los atributos podrán ser NULL cuando la operación sea ejecutada durante la inicialización, migración o por un proceso técnico que no cuente con un usuario autenticado, conforme a las reglas de auditoría definidas para el dominio.

El primer usuario del sistema constituirá una excepción controlada y podrá ser creado con CreatedBy, UpdatedBy y DeletedBy en NULL.

Una vez creado el primer usuario, cuando exista un usuario autenticado como responsable de la operación, la aplicación deberá registrar su UserId en el atributo de auditoría correspondiente.

Los procesos de inicialización, migración o ejecución técnica que no cuenten con un usuario autenticado podrán mantener estos atributos en NULL cuando corresponda.

---

## 13.2 Entity: User

### 13.2.1 Objetivo

Representar a cada usuario registrado en BudgetKeep y establecer el propietario de toda la información financiera almacenada en el sistema.

La entidad User constituye la raíz del modelo de datos y será la referencia principal para la asociación de recursos financieros, eventos, planes, obligaciones y configuraciones personales.

---

### 13.2.2 Responsabilidades

La entidad User es responsable de:

- Identificar de forma única a cada usuario del sistema.
- Mantener la información básica del perfil del usuario.
- Asociar toda la información financiera con un único propietario.
- Servir como entidad raíz para las relaciones funcionales del modelo.

---

### 13.2.3 Fuera del Alcance

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

### 13.2.4 Relaciones

La entidad User mantiene relaciones directas con las siguientes entidades:

- UserSecurity
- UserRole
- UserPreference
- FinancialResource
- FinancialEvent
- FinancialPlan
- FinancialObligation

---

### 13.2.5 Observaciones de Diseño

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

### 13.2.5.1 Identificación y Soporte

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

### 13.2.6 Atributos

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

## 13.3 Entity: UserSecurity

### 13.3.1 Objetivo

Almacenar la información persistente relacionada con las credenciales y el estado de seguridad de la cuenta de un usuario.

La entidad UserSecurity mantiene una relación uno a uno con User y separa la información sensible de seguridad de la información funcional del perfil del usuario.

---

### 13.3.2 Responsabilidades

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

### 13.3.3 Fuera del Alcance

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

### 13.3.4 Relaciones

La entidad UserSecurity mantiene una relación uno a uno obligatoria con:

- User

La clave UserSecurity.UserId será simultáneamente Primary Key y Foreign Key hacia User.UserId.

Cada User deberá tener exactamente un registro UserSecurity.
Cada UserSecurity deberá pertenecer exactamente a un User.

---

### 13.3.5 Reglas Generales

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

### 13.3.6 Atributos

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

## 13.4 Entity: Role

### 13.4.1 Objetivo

Representar los roles funcionales disponibles dentro de BudgetKeep para controlar el acceso de los usuarios a las diferentes funcionalidades del sistema.

Un Role representa un conjunto lógico de permisos que puede ser asignado a uno o varios usuarios mediante la entidad UserRole.

---

### 13.4.2 Responsabilidades

La entidad Role es responsable de:

- Identificar un perfil de autorización dentro del sistema.
- Agrupar permisos relacionados con las funcionalidades de BudgetKeep.
- Permitir la asignación de un conjunto de permisos a uno o varios usuarios.
- Facilitar la administración centralizada de los permisos mediante roles.

---

### 13.4.3 Fuera del Alcance

La entidad Role no será responsable de:

- Autenticar usuarios.
- Validar contraseñas.
- Administrar sesiones.
- Ejecutar directamente las reglas de autorización.
- Almacenar permisos individuales asignados directamente a usuarios.

La asignación de roles a usuarios será gestionada mediante UserRole y la relación entre roles y permisos mediante RolePermission.

---

### 13.4.4 Relaciones

La entidad Role mantiene relaciones con:

- UserRole
- RolePermission

Un Role podrá estar asociado con múltiples usuarios mediante UserRole.

Un Role podrá estar asociado con múltiples permisos mediante RolePermission.

---

### 13.4.5 Reglas Generales

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

### 13.4.6 Atributos

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

## 13.5 Entity: Module

### 13.5.1 Objetivo

Representar las funcionalidades o áreas funcionales del sistema sobre las cuales se definirán permisos de acceso.

Un Module permite organizar los permisos de BudgetKeep de acuerdo con la funcionalidad a la que pertenecen.

---

### 13.5.2 Responsabilidades

La entidad Module es responsable de:

- Identificar una funcionalidad o área funcional del sistema.
- Proporcionar una agrupación lógica para los permisos.
- Permitir que los permisos sean asociados a funcionalidades específicas mediante ModulePermission.
- Facilitar la administración y organización de la autorización del sistema.

---

### 13.5.3 Fuera del Alcance

La entidad Module no será responsable de:

- Autenticar usuarios.
- Autorizar directamente una operación.
- Asignar módulos directamente a usuarios.
- Almacenar permisos individuales.
- Definir las reglas específicas de cada permiso.

La relación entre módulos y permisos será gestionada mediante ModulePermission.

---

### 13.5.4 Relaciones

La entidad Module mantiene una relación con:

- ModulePermission

Un Module podrá estar asociado con múltiples permisos mediante ModulePermission.

---

### 13.5.5 Reglas Generales

- Cada Module deberá tener un Code único.
- Code deberá ser estable y no depender del nombre mostrado al usuario.
- Un Module podrá tener múltiples permisos.
- Un permiso podrá estar asociado con múltiples módulos mediante ModulePermission.
- Los módulos inactivos no deberán utilizarse para nuevas configuraciones de permisos.
- La eliminación de un Module deberá respetar las relaciones existentes y las reglas de integridad referencial.

---

### 13.5.6 Atributos

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

## 13.6 Entity: Permission

### 13.6.1 Objetivo

Representar los tipos de operaciones o acciones de autorización que pueden aplicarse a las funcionalidades de BudgetKeep.

Un Permission representa una capacidad de operación reutilizable, como consultar, crear, modificar o eliminar información.

La asociación entre un Permission y una funcionalidad específica del sistema será definida mediante ModulePermission.

---

### 13.6.2 Responsabilidades

La entidad Permission es responsable de:

- Identificar un tipo de operación de autorización.
- Proporcionar un catálogo reutilizable de operaciones.
- Permitir que una misma operación pueda utilizarse en diferentes módulos.
- Servir como elemento base para la construcción de permisos específicos mediante ModulePermission.

---

### 13.6.3 Fuera del Alcance

La entidad Permission no será responsable de:

- Asignar permisos directamente a usuarios.
- Asignar permisos directamente a roles.
- Determinar por sí misma si un usuario puede ejecutar una operación.
- Contener reglas específicas de autorización de una funcionalidad.

La asociación entre permisos y módulos será gestionada mediante ModulePermission.

La asignación de permisos a roles será gestionada mediante RolePermission.

---

### 13.6.4 Relaciones

La entidad Permission mantiene una relación con:

- ModulePermission

Un Permission podrá estar asociado con múltiples módulos mediante ModulePermission.

---

### 13.6.5 Reglas Generales

- Cada Permission deberá tener un Code único.
- Code deberá ser estable y no depender del texto mostrado al usuario.
- Un Permission podrá utilizarse en múltiples módulos.
- Los permisos inactivos no deberán utilizarse para nuevas configuraciones de autorización.
- Los permisos no serán asignados directamente a usuarios.
- Los permisos no serán asociados directamente con roles; esta asociación se realizará mediante ModulePermission y RolePermission.
- La eliminación de un Permission deberá respetar las relaciones existentes y las reglas de integridad referencial.

---

### 13.6.6 Atributos

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

## 13.7 Entity: ModulePermission

### 13.7.1 Objetivo

Representar una combinación válida entre un Module y un Permission.

ModulePermission define una capacidad de operación concreta dentro de una funcionalidad específica de BudgetKeep.

Por ejemplo, la combinación de un módulo Payments con el permiso VIEW representa la capacidad de consultar información de Payments.

---

### 13.7.2 Responsabilidades

La entidad ModulePermission es responsable de:

- Asociar un Module con un Permission.
- Definir las combinaciones válidas de módulo y operación.
- Servir como unidad de autorización reutilizable para los roles.
- Evitar que un Permission sea asignado a un Role fuera de un Module válido.

---

### 13.7.3 Fuera del Alcance

La entidad ModulePermission no será responsable de:

- Asignar directamente permisos a usuarios.
- Asignar directamente permisos a roles.
- Determinar si un usuario puede ejecutar una operación.
- Ejecutar las reglas de autorización.

La asignación de una combinación ModulePermission a un Role será gestionada mediante RolePermission.

---

### 13.7.4 Relaciones

La entidad ModulePermission mantiene relaciones con:

- Module
- Permission
- RolePermission

Un Module podrá tener múltiples combinaciones ModulePermission.

Un Permission podrá utilizarse en múltiples Modules.

Un ModulePermission podrá estar asociado con múltiples Roles mediante RolePermission.

---

### 13.7.5 Reglas Generales

- La combinación `(ModuleId, PermissionId)` será única.
- La combinación `(ModuleId, PermissionId)` será la Primary Key de la entidad.
- ModuleId deberá referenciar un Module existente.
- PermissionId deberá referenciar un Permission existente.
- No deberán existir combinaciones duplicadas entre Module y Permission.
- Un ModulePermission inactivo no deberá utilizarse para nuevas configuraciones de autorización.
- La eliminación de un Module o Permission deberá respetar las relaciones existentes y las reglas de integridad referencial.

---

### 13.7.6 Atributos

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

## 13.8 Entity: UserRole

### 13.8.1 Objetivo

Representar la asignación de uno o varios roles a los usuarios de BudgetKeep.

UserRole es una entidad puente que implementa la relación muchos a muchos entre User y Role.

---

### 13.8.2 Responsabilidades

La entidad UserRole es responsable de:

- Asociar un usuario con un rol.
- Permitir que un usuario tenga múltiples roles.
- Permitir que un rol sea asignado a múltiples usuarios.
- Evitar asignaciones duplicadas entre un mismo usuario y un mismo rol.

---

### 13.8.3 Fuera del Alcance

La entidad UserRole no será responsable de:

- Autenticar usuarios.
- Definir los permisos de un rol.
- Ejecutar reglas de autorización.
- Almacenar información de credenciales.
- Definir permisos individuales.

Los permisos asociados a un rol serán gestionados mediante RolePermission.

---

### 13.8.4 Relaciones

La entidad UserRole mantiene relaciones con:

- User
- Role

Un User podrá tener múltiples registros en UserRole.

Un Role podrá tener múltiples registros en UserRole.

---

### 13.8.5 Reglas Generales

- La combinación `(UserId, RoleId)` será única.
- La combinación `(UserId, RoleId)` será la Primary Key de la entidad.
- UserId deberá referenciar un User existente.
- RoleId deberá referenciar un Role existente.
- No deberán existir asignaciones duplicadas entre un usuario y un rol.
- Una asignación deberá eliminarse o desactivarse de acuerdo con las reglas de autorización definidas por el sistema.
- La eliminación de un User o Role deberá respetar las relaciones existentes y las reglas de integridad referencial.

---

### 13.8.6 Atributos

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

## 13.9 Entity: RolePermission

### 13.9.1 Objetivo

Representar la asignación de una combinación ModulePermission a un Role.

RolePermission define qué operaciones puede realizar un Role dentro de una funcionalidad específica de BudgetKeep.

---

### 13.9.2 Responsabilidades

La entidad RolePermission es responsable de:

- Asociar un Role con una combinación ModulePermission.
- Definir las capacidades de autorización disponibles para cada Role.
- Evitar asignaciones duplicadas de una misma combinación de módulo y permiso a un mismo Role.
- Servir como base para determinar las capacidades autorizadas de los usuarios a través de sus roles.

---

### 13.9.3 Fuera del Alcance

La entidad RolePermission no será responsable de:

- Autenticar usuarios.
- Asignar roles a usuarios.
- Validar contraseñas.
- Ejecutar directamente las reglas de autorización.
- Definir permisos fuera de un Module válido.

La asignación de roles a usuarios será gestionada mediante UserRole.

---

### 13.9.4 Relaciones

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

### 13.9.5 Reglas Generales

- La combinación `(RoleId, ModuleId, PermissionId)` será única.
- La combinación `(RoleId, ModuleId, PermissionId)` será la Primary Key de la entidad.
- RoleId deberá referenciar un Role existente.
- `(ModuleId, PermissionId)` deberá referenciar un ModulePermission existente.
- No deberán existir asignaciones duplicadas entre un Role y una combinación ModulePermission.
- Un RolePermission deberá representar únicamente una combinación ModulePermission válida.
- La eliminación de un Role o ModulePermission deberá respetar las relaciones existentes y las reglas de integridad referencial.

---

### 13.9.6 Atributos

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

## 13.10 Entity: UserPreference

### 13.10.1 Objetivo

Almacenar las preferencias configurables de cada usuario de BudgetKeep.

La entidad UserPreference representa la configuración personal asociada a un usuario y permite mantener estas preferencias separadas de la información funcional y de seguridad de la cuenta.

---

### 13.10.2 Responsabilidades

La entidad UserPreference es responsable de:

- Almacenar las preferencias personales del usuario.
- Mantener una única configuración de preferencias por usuario.
- Permitir que las preferencias puedan evolucionar sin modificar la estructura principal de User.
- Mantener las preferencias asociadas exclusivamente al usuario propietario.

---

### 13.10.3 Fuera del Alcance

La entidad UserPreference no será responsable de:

- Almacenar credenciales.
- Administrar autenticación.
- Administrar autorización.
- Almacenar información financiera.
- Almacenar configuraciones globales del sistema.

Las configuraciones globales serán gestionadas mediante SystemConfiguration.

---

### 13.10.4 Relaciones

La entidad UserPreference mantiene una relación uno a uno con:

- User

UserPreference.UserId será simultáneamente Primary Key y Foreign Key hacia User.UserId.

Un User podrá tener como máximo un registro UserPreference.

---

### 13.10.5 Reglas Generales

- UserId será la Primary Key de la entidad.
- UserId será también Foreign Key hacia User.UserId.
- No podrá existir más de un registro UserPreference para el mismo usuario.
- UserPreference no podrá existir sin un User correspondiente.
- Las preferencias deberán pertenecer exclusivamente al usuario identificado por UserId.
- Las preferencias no deberán utilizarse para almacenar configuraciones globales del sistema.
- La eliminación de un User deberá respetar las reglas de integridad referencial definidas para UserPreference.

---

### 13.10.6 Atributos

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

## 13.11 Entity: SystemConfiguration

### 13.11.1 Objetivo

Centralizar los valores de configuración global utilizados por BudgetKeep que puedan requerir modificación sin alterar la estructura de la base de datos ni incorporar valores fijos directamente en el código de la aplicación.

La entidad SystemConfiguration constituye la fuente persistente de configuración para parámetros técnicos y de seguridad definidos para el sistema.

---

### 13.11.2 Responsabilidades

La entidad SystemConfiguration es responsable de:

- Mantener configuraciones globales del sistema.
- Proporcionar un identificador único para cada configuración.
- Mantener el valor actual de cada configuración.
- Identificar el tipo de dato representado por cada valor.
- Proporcionar una descripción funcional de cada configuración.
- Permitir activar o desactivar configuraciones cuando corresponda.

---

### 13.11.3 Fuera del Alcance

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

### 13.11.4 Relaciones

SystemConfiguration no mantiene relaciones funcionales con las entidades de negocio.

SystemConfiguration mantiene una relación técnica con ConfigurationDataType mediante ConfigurationDataTypeId.

Cada SystemConfiguration deberá utilizar exactamente un ConfigurationDataType válido.
Un ConfigurationDataType podrá ser utilizado por múltiples registros de SystemConfiguration.

Las configuraciones serán consultadas por los componentes de aplicación que requieran su valor.

---

### 13.11.5 Reglas Generales

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

### 13.11.6 Atributos

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

## 13.12 Entity: ConfigurationDataType

### 13.12.1 Objetivo

Representar el catálogo controlado de tipos de datos permitidos para los valores almacenados en SystemConfiguration.

---

### 13.12.2 Responsabilidades

La entidad ConfigurationDataType es responsable de:

- Definir los tipos de datos permitidos para SystemConfiguration.
- Proporcionar un catálogo controlado y reutilizable.
- Evitar valores arbitrarios o inconsistentes en SystemConfiguration.ConfigurationDataTypeId.
- Permitir la incorporación controlada de nuevos tipos de datos cuando sea necesario.

---

### 13.12.3 Fuera del Alcance

ConfigurationDataType no será responsable de:

- Almacenar valores de configuración.
- Interpretar o convertir directamente los valores.
- Almacenar configuraciones globales.
- Almacenar información de negocio.

---

### 13.12.4 Relaciones

La entidad ConfigurationDataType mantiene una relación con:

- SystemConfiguration

Un ConfigurationDataType podrá estar asociado con múltiples registros de SystemConfiguration.

Cada SystemConfiguration deberá utilizar un ConfigurationDataType válido.

---

### 13.12.5 Reglas Generales

- Cada ConfigurationDataType deberá tener un Code único.
- Code deberá ser estable y no depender del nombre mostrado.
- No deberán existir tipos de datos duplicados.
- Solo los tipos activos podrán utilizarse para nuevas configuraciones.
- La incorporación de nuevos tipos deberá realizarse mediante una decisión de diseño y actualización del catálogo correspondiente.

---

### 13.12.6 Atributos

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

## 13.13 Relaciones del Dominio

Las relaciones del dominio Identity & Security se definen de la siguiente manera:

### User

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

### Role

- Role 1:N UserRole
  - UserRole.RoleId referencia Role.RoleId.
  - Un Role podrá estar asignado a múltiples usuarios.

- Role 1:N RolePermission
  - RolePermission.RoleId referencia Role.RoleId.
  - Un Role podrá tener múltiples capacidades autorizadas.

### Module

- Module 1:N ModulePermission
  - ModulePermission.ModuleId referencia Module.ModuleId.
  - Un Module podrá tener múltiples permisos.

### Permission

- Permission 1:N ModulePermission
  - ModulePermission.PermissionId referencia Permission.PermissionId.
  - Un Permission podrá utilizarse en múltiples módulos.

### ModulePermission

- ModulePermission 1:N RolePermission
  - RolePermission.(ModuleId, PermissionId) es Foreign Key compuesta hacia ModulePermission.(ModuleId, PermissionId).
  - Un ModulePermission podrá estar asociado con múltiples roles.

- La Primary Key de ModulePermission es (ModuleId, PermissionId).
- La combinación ModuleId + PermissionId no podrá repetirse.

### UserRole

- La Primary Key de UserRole es (UserId, RoleId).
- La combinación UserId + RoleId no podrá repetirse.

### RolePermission

- La Primary Key de RolePermission es (RoleId, ModuleId, PermissionId).
- La combinación RoleId + ModuleId + PermissionId no podrá repetirse.

### UserPreference

- UserPreference.UserId es Primary Key y Foreign Key hacia User.UserId.
- La relación User → UserPreference es uno a uno.
- Un User podrá tener como máximo un registro UserPreference.

### SystemConfiguration

- ConfigurationDataTypeId referencia ConfigurationDataType.ConfigurationDataTypeId.
- Un SystemConfiguration deberá utilizar exactamente un ConfigurationDataType válido.
- SystemConfiguration no mantiene relaciones Foreign Key con las entidades funcionales del dominio.

### ConfigurationDataType

- ConfigurationDataType 1:N SystemConfiguration.
- Un ConfigurationDataType podrá ser utilizado por múltiples registros SystemConfiguration.
- La incorporación de nuevos tipos deberá realizarse mediante una decisión de diseño y actualización del catálogo correspondiente.

