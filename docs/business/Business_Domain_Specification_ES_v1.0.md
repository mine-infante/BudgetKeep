
# Business Domain Specification

---

# 1. Información del documento

| Campo | Valor |
|-------|-------|
| Producto | BudgetKeep |
| Artefacto | Business Domain Specification |
| Identificador | BDS-001 |
| Estado | Approved |
| Metodología | AI MineSoftware |
| Especialista responsable | BA-001 – Business Analysis Expert |
| Documento de entrada | Product Vision v1.1 |
| Documento de salida | Business Domain Specification Draft |

---

# 2. Introducción

## 2.1 Propósito

El presente documento define el Modelo de Dominio de Negocio de BudgetKeep.

Su propósito es establecer el lenguaje oficial del negocio mediante la definición de los Conceptos del Dominio, sus responsabilidades, relaciones y terminología, proporcionando una base común para todas las disciplinas que participarán en el diseño, construcción, validación y evolución del producto.

Este documento no define decisiones de implementación, arquitectura, diseño de bases de datos, APIs ni componentes de software.

---

## 2.2 Objetivo

Establecer un Modelo de Dominio consistente, estable y reutilizable que represente los conceptos fundamentales del negocio de BudgetKeep.

---

## 2.3 Alcance

Esta especificación cubre todos los Domain Concepts aprobados para BudgetKeep y constituye la referencia oficial de terminología y relaciones de negocio para el proyecto.

---

## 2.4 Audiencia

Este documento está dirigido a:

- Project Office
- Business Analysis
- Solution Architecture
- UX
- Development
- QA
- Especialistas de IA

---

## 2.5 Documentos de referencia

La presente especificación se elaboró tomando como referencia los siguientes documentos aprobados:

- Product Vision v1.1
- Decision Log
- Business Analysis Specification
- Artifact Naming Standard

Toda la información contenida en este documento deberá ser consistente con dichos artefactos.

---

# 3. Business Domain Model

## 3.1 Introducción

El Modelo del Dominio de Negocio identifica y define los conceptos que conforman la realidad financiera administrada por BudgetKeep.

Cada Concepto del Dominio representa una entidad o abstracción propia del negocio y constituye la base para la definición de los procesos de negocio, las reglas de negocio, las capacidades funcionales y los requerimientos funcionales descritos en este documento.

El Modelo del Dominio de Negocio representa el lenguaje común que deberá utilizarse en todos los artefactos del proyecto.

---

# 3.2 Conceptos del Dominio

## DC-001 – Usuario

### Definición

Representa a la persona que administra su realidad financiera mediante BudgetKeep.

El Usuario es el propietario de toda la información financiera registrada dentro del producto y el responsable de mantenerla actualizada para que represente fielmente su situación financiera.

BudgetKeep proporciona información, análisis, recomendaciones y estrategias financieras; sin embargo, la decisión final siempre corresponde al Usuario.

---

### Propósito

Representar al actor principal del negocio y propietario de la Realidad Financiera administrada por BudgetKeep.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-001.01 | Identificador | Identifica de manera única al Usuario dentro del producto. |
| BI-001.02 | Nombre | Nombre utilizado para identificar al Usuario. |
| BI-001.03 | Moneda Base | Moneda utilizada para presentar y analizar la realidad financiera del Usuario. |
| BI-001.04 | Configuración de Monedas | Conjunto de monedas que el Usuario decide utilizar dentro de su realidad financiera. |
| BI-001.05 | Realidad Financiera | Modelo financiero perteneciente al Usuario. |

---

### Responsabilidades

El Usuario es responsable de:

- Registrar información financiera.
- Mantener actualizada su realidad financiera.
- Decidir qué obligaciones forman parte de su realidad financiera.
- Configurar la Moneda Base utilizada para analizar su realidad financiera.
- Seleccionar la estrategia financiera que considere más conveniente.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-002 – Realidad Financiera | El Usuario posee una Realidad Financiera. |
| DC-016 – Recurso Financiero | El Usuario administra sus Recursos Financieros. |
| DC-017 – Estrategia Financiera | El Usuario evalúa y selecciona las Estrategias Financieras. |

---

## DC-002 – Realidad Financiera

### Definición

Representa la situación financiera actual del Usuario en un momento determinado.

La Realidad Financiera integra toda la información necesaria para comprender el contexto financiero del Usuario y constituye la fuente principal utilizada por BudgetKeep para apoyar la toma de decisiones.

---

### Propósito

Proporcionar una representación organizada, consistente y confiable de la situación financiera del Usuario.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-002.01 | Obligaciones Financieras | Obligaciones que forman parte de la realidad financiera. |
| BI-002.02 | Ingresos | Ingresos registrados por el Usuario. |
| BI-002.03 | Gastos | Gastos registrados por el Usuario. |
| BI-002.04 | Deudas | Deudas administradas por el Usuario. |
| BI-002.05 | Recursos Financieros | Recursos disponibles para atender obligaciones. |
| BI-002.06 | Disponibilidad Financiera | Capacidad financiera disponible en un momento determinado. |
| BI-002.07 | Estrategias Financieras | Estrategias derivadas de la realidad financiera. |
| BI-002.08 | Presupuesto | Planeación financiera del Usuario. |
| BI-002.09 | Ahorros | Recursos reservados para objetivos futuros. |

---

### Responsabilidades

La Realidad Financiera deberá:

- Representar la situación financiera vigente del Usuario.
- Integrar toda la información necesaria para apoyar el análisis financiero.
- Servir como base para la priorización de obligaciones.
- Servir como base para el análisis financiero y la generación de Recomendaciones y Estrategias Financieras.
- Integrar información financiera registrada en múltiples monedas conservando la moneda original de cada elemento financiero.
- Reducir la incertidumbre financiera mediante información organizada y confiable.
- Permitir la representación consolidada de la realidad financiera utilizando la Moneda Base seleccionada por el Usuario.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-001 – Usuario | Pertenece a un Usuario. |
| DC-003 – Obligación Financiera | Contiene Obligaciones Financieras. |
| DC-006 – Ingreso | Integra los Ingresos del Usuario. |
| DC-007 – Gasto | Integra los Gastos del Usuario. |
| DC-008 – Deuda | Integra las Deudas del Usuario. |
| DC-009 – Disponibilidad Financiera | Permite determinar la Disponibilidad Financiera. |
| DC-010 – Presupuesto | Puede incorporar Presupuestos. |
| DC-011 – Ahorro | Puede incorporar Ahorros. |
| DC-016 – Recurso Financiero | Utiliza Recursos Financieros. |
| DC-017 – Estrategia Financiera | Es la base para el análisis financiero y la generación de Recomendaciones y Estrategias Financieras. |

## DC-003 – Obligación Financiera

### Definición

Representa un compromiso económico específico que el Usuario debe atender como parte de su Realidad Financiera.

Una Obligación Financiera representa un compromiso concreto cuyo cumplimiento impacta la situación financiera del Usuario. Forma parte de la Realidad Financiera y constituye uno de los principales elementos utilizados por BudgetKeep para realizar el análisis financiero y generar Recomendaciones y Estrategias Financieras.

Una Obligación Financiera no representa un contrato, un producto financiero ni una cuenta. Representa un compromiso específico que debe ser atendido por el Usuario.

---

### Propósito

Representar los compromisos financieros que afectan la toma de decisiones del Usuario y que forman parte de su Realidad Financiera.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-003.01 | Identificador | Identifica de manera única la Obligación Financiera. |
| BI-003.02 | Nombre | Nombre utilizado para identificar la obligación. |
| BI-003.03 | Tipo de Obligación | Clasificación utilizada para organizar las obligaciones financieras. El producto proporcionará un catálogo inicial y permitirá al Usuario crear tipos adicionales. |
| BI-003.04 | Entidad Relacionada | Persona u organización relacionada con la obligación financiera. |
| BI-003.05 | Importe | Valor económico comprometido. |
| BI-003.06 | Moneda | Moneda original en la que fue registrada la obligación. |
| BI-003.07 | Eventos Financieros | Conjunto de Eventos Financieros asociados a la Obligación Financiera. |
| BI-003.08 | Prioridad del Usuario | Nivel de importancia asignado por el Usuario a la obligación financiera. |
| BI-003.09 | Estado del Ciclo de Vida | Determina si la obligación forma parte de la Realidad Financiera activa. |
| BI-003.10 | Estado Financiero | Describe el nivel de cumplimiento económico de la obligación. |
| BI-003.11 | Estado Temporal | Describe la situación de la obligación respecto a sus fechas de negocio. |
| BI-003.12 | Recurrencia | Define si la obligación genera nuevas obligaciones financieras de forma periódica y la configuración asociada a dicha recurrencia. |
| BI-003.13 | Observaciones | Información adicional registrada por el Usuario. |

---

### Responsabilidades

Una Obligación Financiera deberá:

- formar parte de la Realidad Financiera mientras permanezca activa;
- participar en la determinación de la Disponibilidad Financiera cuando corresponda;
- participar en la construcción de Estrategias Financieras;
- conservar siempre la moneda original con la que fue registrada;
- conservar su información histórica cuando deje de formar parte de la Realidad Financiera activa;
- permitir la generación de nuevas obligaciones cuando exista una Configuración de Recurrencia;
- permitir que el Usuario modifique la Configuración de Recurrencia sin afectar las obligaciones previamente generadas.

---

### Ciclo de Vida

El Ciclo de Vida determina si una Obligación Financiera participa en la Realidad Financiera.

Los estados permitidos son:

- Registrada
- Activa
- Retirada
- Eliminada

#### Registrada

La obligación ha sido creada por el Usuario y forma parte de su información financiera.

#### Activa

La obligación participa en la Realidad Financiera y deberá considerarse durante el análisis financiero y la construcción de Estrategias Financieras.

#### Retirada

La obligación deja de participar temporalmente en la Realidad Financiera por decisión del Usuario.

La información histórica permanece disponible y la obligación podrá volver a activarse posteriormente.

#### Eliminada

La obligación deja de existir únicamente cuando su eliminación no compromete la integridad de la información financiera.

Una obligación eliminada no podrá recuperarse.

---

### Estado Financiero

El Estado Financiero representa el grado de cumplimiento económico de la obligación.

Los estados definidos son:

- Pendiente
- Parcialmente Atendida
- Atendida

---

### Estado Temporal

El Estado Temporal representa la situación de la obligación respecto a sus Fechas de Negocio.

El catálogo de Estados Temporales será definido como parte del Concepto del Dominio **DC-005 – Fecha de Negocio**.

---

### Configuración de Recurrencia

Una Obligación Financiera podrá configurarse como recurrente.

La Configuración de Recurrencia define la forma en que el producto generará nuevas Obligaciones Financieras a partir de la obligación original.

Cada obligación generada será independiente y conservará su propio ciclo de vida, estado financiero e historial.

La modificación de la Configuración de Recurrencia afectará únicamente las obligaciones futuras y no alterará la información histórica de las obligaciones previamente generadas.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-002 – Realidad Financiera | Forma parte de la Realidad Financiera. |
| DC-004 – Pago | Puede ser atendida mediante uno o varios Pagos. |
| DC-005 – Fecha de Negocio | Se relaciona con una o varias Fechas de Negocio. |
| DC-009 – Disponibilidad Financiera | Influye en la Disponibilidad Financiera. |
| DC-015 – Prioridad Financiera | Puede ser considerada durante la determinación de Prioridades Financieras. |
| DC-016 – Recurso Financiero | Puede ser atendida utilizando uno o varios Recursos Financieros. |
| DC-017 – Estrategia Financiera | Es utilizada durante el análisis financiero para generar Recomendaciones y Estrategias Financieras. |

## DC-004 – Pago

### Definición

Representa el acto mediante el cual el Usuario atiende total o parcialmente una Obligación Financiera utilizando uno o varios Recursos Financieros.

Un Pago constituye un evento de negocio que modifica la Realidad Financiera del Usuario al actualizar el Estado Financiero de la Obligación Financiera correspondiente.

El Pago no representa un movimiento bancario ni una transacción entre cuentas. Representa el hecho de que el Usuario ha atendido una Obligación Financiera.

---

### Propósito

Representar la atención total o parcial de una Obligación Financiera y contribuir a mantener actualizada la Realidad Financiera del Usuario.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-004.01 | Identificador | Identifica de manera única el Pago. |
| BI-004.02 | Obligación Financiera | Obligación Financiera atendida mediante el Pago. |
| BI-004.03 | Fecha del Pago | Fecha en la que el Usuario registra que realizó el Pago. |
| BI-004.04 | Importe | Valor económico aplicado al Pago. |
| BI-004.05 | Moneda | Moneda original utilizada para realizar el Pago. |
| BI-004.06 | Recurso Financiero | Recurso Financiero utilizado para atender la Obligación Financiera. |
| BI-004.07 | Observaciones | Información adicional registrada por el Usuario. |

---

### Responsabilidades

Un Pago deberá:

- atender total o parcialmente una Obligación Financiera;
- actualizar el Estado Financiero de la Obligación Financiera correspondiente;
- conservar la moneda original utilizada para realizar el Pago;
- identificar el Recurso Financiero utilizado para atender la Obligación Financiera;
- contribuir a mantener actualizada la Realidad Financiera del Usuario.

Cuando un Pago sea modificado, reclasificado o eliminado, la Realidad Financiera deberá reconstruirse utilizando la información vigente para garantizar que represente correctamente la situación financiera actual del Usuario.

---

### Consideraciones de negocio

- Todo Pago deberá estar asociado a una Obligación Financiera.
- Un Pago no puede existir de manera independiente.
- Una Obligación Financiera podrá ser atendida mediante uno o varios Pagos.
- Una transferencia o disposición de recursos utilizada para atender varias Obligaciones Financieras dará origen a un Pago independiente por cada Obligación Financiera atendida.
- Todo Pago representa un Gasto para el Usuario; sin embargo, no todo Gasto representa un Pago.
- BudgetKeep asumirá que la información registrada por el Usuario representa correctamente su Realidad Financiera.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-002 – Realidad Financiera | Forma parte de la Realidad Financiera del Usuario. |
| DC-003 – Obligación Financiera | Atiende total o parcialmente una Obligación Financiera. |
| DC-007 – Gasto | Todo Pago representa un Gasto; no todo Gasto representa un Pago. |
| DC-016 – Recurso Financiero | Utiliza uno o varios Recursos Financieros para atender una Obligación Financiera. |

## DC-005 – Evento Financiero

### Definición

Representa un acontecimiento relevante asociado a uno o varios conceptos de la Realidad Financiera que ocurre en una fecha determinada y que puede requerir atención por parte del Usuario o producir efectos definidos por las reglas del negocio.

Un Evento Financiero representa el significado de un acontecimiento dentro del dominio de negocio. La fecha asociada indica cuándo ocurre dicho acontecimiento, mientras que las consecuencias derivadas del evento serán definidas mediante los Procesos de Negocio y las Reglas de Negocio correspondientes.

Un Evento Financiero puede ser registrado por el Usuario o generado automáticamente por el producto conforme a la configuración y reglas del negocio.

---

### Propósito

Representar los acontecimientos relevantes que participan en la evolución de la Realidad Financiera del Usuario y que sirven como referencia para la ejecución de procesos, la aplicación de reglas de negocio y la toma de decisiones.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-005.01 | Identificador | Identifica de manera única el Evento Financiero. |
| BI-005.02 | Clase de Evento | Clasificación utilizada para identificar el tipo de acontecimiento financiero. |
| BI-005.03 | Fecha del Evento | Fecha en la que ocurre el acontecimiento. |
| BI-005.04 | Origen del Evento | Indica si el evento fue registrado por el Usuario o generado por el producto. |
| BI-005.05 | Descripción | Información que describe el propósito del Evento Financiero. |
| BI-005.06 | Concepto Relacionado | Concepto del Dominio al que pertenece el Evento Financiero. |

---

### Responsabilidades

Un Evento Financiero deberá:

- representar un acontecimiento relevante dentro de la Realidad Financiera;
- estar asociado a una fecha específica;
- poder relacionarse con uno o varios Conceptos del Dominio;
- servir como referencia para la aplicación de Procesos de Negocio y Reglas de Negocio;
- permitir que el Usuario registre eventos propios de su realidad financiera;
- permitir que el producto genere eventos derivados de configuraciones y reglas del negocio.

---

### Consideraciones de negocio

- Un Evento Financiero no posee estados propios.
- La condición de un Evento Financiero se determina comparando su Fecha del Evento con la fecha utilizada como referencia para el análisis de la Realidad Financiera.
- Un Evento Financiero puede ser registrado por el Usuario o generado automáticamente por el producto.
- Un mismo Concepto del Dominio puede tener asociados múltiples Eventos Financieros.
- Un Evento Financiero podrá relacionarse con diferentes Conceptos del Dominio cuando el negocio así lo requiera.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-002 – Realidad Financiera | Forma parte de la evolución de la Realidad Financiera. |
| DC-003 – Obligación Financiera | Puede estar asociado a una Obligación Financiera. |
| DC-008 – Deuda | Puede estar asociado a una Deuda. |
| DC-010 – Presupuesto | Puede estar asociado a un Presupuesto. |
| DC-011 – Ahorro | Puede estar asociado a un Ahorro. |
| DC-016 – Recurso Financiero | Puede estar asociado a un Recurso Financiero. |

## DC-006 – Ingreso

### Definición

Representa un Flujo de Dinero que incrementa la capacidad económica del Usuario y que, una vez ocurrido el Evento Financiero correspondiente y confirmado por el Usuario, pasa a formar parte de la Realidad Financiera como dinero disponible para su utilización.

Un Ingreso representa recursos económicos que el Usuario incorpora a su patrimonio o disponibilidad financiera sin generar, por sí mismo, una Obligación Financiera.

Los recursos obtenidos mediante préstamos, disposiciones de crédito o mecanismos similares no constituyen Ingresos, aunque sí representan Flujos de Dinero que incrementan temporalmente la disponibilidad financiera y generan las Obligaciones Financieras correspondientes.

---

### Propósito

Representar los recursos económicos que incrementan la capacidad financiera del Usuario y que podrán utilizarse para atender Obligaciones Financieras, realizar Gastos, generar Ahorros o apoyar la toma de decisiones financieras.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-006.01 | Identificador | Identifica de manera única el Ingreso. |
| BI-006.02 | Nombre | Nombre utilizado para identificar el Ingreso. |
| BI-006.03 | Origen del Ingreso | Clasificación del origen del Ingreso. El producto proporcionará un catálogo inicial y permitirá al Usuario crear nuevos orígenes. |
| BI-006.04 | Importe | Valor económico del Ingreso. |
| BI-006.05 | Moneda | Moneda original en la que fue recibido el Ingreso. |
| BI-006.06 | Evento Financiero | Evento Financiero asociado al Ingreso. |
| BI-006.07 | Recurrencia | Define si el Ingreso puede generarse periódicamente y la configuración asociada a dicha recurrencia. |
| BI-006.08 | Observaciones | Información adicional registrada por el Usuario. |

---

### Responsabilidades

Un Ingreso deberá:

- representar recursos económicos disponibles para el Usuario una vez ocurrido el Evento Financiero correspondiente;
- conservar la moneda original con la que fue registrado;
- permitir la planificación financiera mediante el registro de ingresos esperados;
- permitir que el Usuario confirme cuándo un Ingreso ha ocurrido y forma parte de su Realidad Financiera;
- permitir la configuración de ingresos recurrentes;
- permitir que el Usuario modifique la configuración de recurrencia sin alterar los ingresos previamente registrados.

---

### Consideraciones de negocio

- Un Ingreso esperado no modifica la Realidad Financiera mientras el Evento Financiero asociado no haya ocurrido y el Usuario no confirme su recepción.
- Una vez confirmado por el Usuario, el Ingreso pasará a formar parte de la Realidad Financiera y podrá considerarse para el cálculo de la Disponibilidad Financiera.
- Un préstamo o una disposición de crédito no constituyen un Ingreso.
- Una transferencia entre Recursos Financieros del mismo Usuario no constituye un Ingreso.
- El Origen del Ingreso utilizará un catálogo inicial proporcionado por el producto y permitirá al Usuario crear nuevos orígenes conforme a sus necesidades.
- Un Ingreso podrá ser recurrente cuando así lo configure el Usuario.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-002 – Realidad Financiera | Forma parte de la Realidad Financiera una vez confirmado por el Usuario. |
| DC-005 – Evento Financiero | Su incorporación depende del Evento Financiero correspondiente. |
| DC-009 – Disponibilidad Financiera | Contribuye a la Disponibilidad Financiera del Usuario. |
| DC-016 – Recurso Financiero | Puede incorporarse mediante uno o varios Recursos Financieros. |

## DC-007 – Gasto

### Definición

Representa un Flujo de Dinero mediante el cual el Usuario consume parte de su Disponibilidad Financiera para satisfacer una necesidad, adquirir un bien o contratar un servicio.

Un Gasto representa la utilización de recursos financieros por parte del Usuario y constituye uno de los principales elementos para comprender la evolución de su Realidad Financiera.

Un Gasto puede estar asociado o no a una Obligación Financiera. Cuando un Gasto atiende una Obligación Financiera, también constituye un Pago.

---

### Propósito

Representar los Flujos de Dinero que disminuyen la Disponibilidad Financiera del Usuario y proporcionar información que apoye el análisis de sus hábitos de consumo y la toma de decisiones financieras.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-007.01 | Identificador | Identifica de manera única el Gasto. |
| BI-007.02 | Nombre | Nombre utilizado para identificar el Gasto. |
| BI-007.03 | Categoría del Gasto | Clasificación utilizada para organizar los Gastos. El producto proporcionará un catálogo inicial y permitirá al Usuario crear nuevas categorías. |
| BI-007.04 | Importe | Valor económico del Gasto. |
| BI-007.05 | Moneda | Moneda original en la que fue registrado el Gasto. |
| BI-007.06 | Evento Financiero | Evento Financiero asociado al Gasto. |
| BI-007.07 | Recurso Financiero | Recurso Financiero utilizado para realizar el Gasto. |
| BI-007.08 | Observaciones | Información adicional registrada por el Usuario. |

---

### Responsabilidades

Un Gasto deberá:

- representar un Flujo de Dinero que disminuya la Disponibilidad Financiera del Usuario;
- conservar la moneda original con la que fue registrado;
- permitir la planificación financiera mediante el registro de Gastos Esperados;
- permitir que el Usuario confirme cuándo un Gasto ha ocurrido y debe formar parte de su Realidad Financiera;
- identificar el Recurso Financiero utilizado para realizar el Gasto;
- conservar la categoría asignada por el Usuario.

---

### Consideraciones de negocio

- Un Gasto Esperado no modifica la Realidad Financiera mientras el Evento Financiero asociado no haya ocurrido y el Usuario no confirme su realización.
- Una vez confirmado por el Usuario, el Gasto pasará a formar parte de la Realidad Financiera y disminuirá la Disponibilidad Financiera correspondiente.
- Todo Pago representa un Gasto; sin embargo, no todo Gasto representa un Pago.
- Una transferencia entre Recursos Financieros del mismo Usuario no constituye un Gasto.
- La Categoría del Gasto utilizará un catálogo inicial proporcionado por el producto y permitirá al Usuario crear nuevas categorías conforme a sus necesidades.
- El producto podrá analizar los Gastos registrados para identificar patrones de comportamiento que apoyen la toma de decisiones financieras, sin modificar la categoría asignada por el Usuario.
- Los Gastos de pequeño importe deberán registrarse de la misma forma que cualquier otro Gasto, ya que su análisis acumulado puede representar oportunidades para mejorar la Realidad Financiera del Usuario.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-002 – Realidad Financiera | Forma parte de la Realidad Financiera una vez confirmado por el Usuario. |
| DC-003 – Obligación Financiera | Puede atender una Obligación Financiera cuando constituye un Pago. |
| DC-004 – Pago | Todo Pago representa un Gasto. |
| DC-005 – Evento Financiero | Su incorporación depende del Evento Financiero correspondiente. |
| DC-009 – Disponibilidad Financiera | Disminuye la Disponibilidad Financiera del Usuario. |
| DC-016 – Recurso Financiero | Utiliza un Recurso Financiero para realizar el Gasto. |

## DC-008 – Deuda

### Definición

Representa el saldo pendiente de un compromiso financiero adquirido por el Usuario.

Una Deuda constituye un compromiso financiero persistente que puede generar una o varias Obligaciones Financieras a lo largo de su ciclo de vida y cuya evolución influye directamente en la Realidad Financiera y en las Estrategias Financieras del Usuario.

Una Deuda puede originarse por productos financieros, acuerdos personales u otros compromisos económicos que impliquen la existencia de un saldo pendiente.

---

### Propósito

Representar los compromisos financieros persistentes del Usuario, administrar su evolución y proporcionar información para apoyar la construcción de Estrategias Financieras y la toma de decisiones.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-008.01 | Identificador | Identifica de manera única la Deuda. |
| BI-008.02 | Nombre | Nombre utilizado para identificar la Deuda. |
| BI-008.03 | Tipo de Deuda | Clasificación utilizada para organizar las Deudas. El producto proporcionará un catálogo inicial y permitirá al Usuario crear nuevos tipos. |
| BI-008.04 | Entidad Relacionada | Persona u organización con la que existe el compromiso financiero. |
| BI-008.05 | Monto Inicial | Valor original de la Deuda cuando aplique. |
| BI-008.06 | Saldo Pendiente | Valor económico pendiente de liquidar. |
| BI-008.07 | Moneda | Moneda original de la Deuda. |
| BI-008.08 | Tasa | Condición financiera aplicable cuando exista (intereses, rendimiento u otra tasa relacionada). |
| BI-008.09 | Evento Financiero | Eventos Financieros asociados a la Deuda. |
| BI-008.10 | Estado del Ciclo de Vida | Determina si la Deuda permanece activa o ha sido cerrada por decisión del Usuario. |
| BI-008.11 | Observaciones | Información adicional registrada por el Usuario. |

---

### Responsabilidades

Una Deuda deberá:

- representar un compromiso financiero persistente del Usuario;
- mantener actualizado su Saldo Pendiente;
- conservar la moneda original con la que fue registrada;
- permitir la generación de Obligaciones Financieras cuando corresponda;
- participar en la construcción de la Realidad Financiera;
- proporcionar información para la construcción de Estrategias Financieras;
- conservar su información histórica aun cuando su saldo pendiente sea igual a cero.

---

### Estado del Ciclo de Vida

El Ciclo de Vida determina si la Deuda continúa formando parte de la administración financiera del Usuario.

Los estados permitidos son:

- Activa
- Cerrada

#### Activa

La Deuda permanece disponible para su administración dentro de la Realidad Financiera del Usuario.

Una Deuda podrá permanecer Activa aun cuando su Saldo Pendiente sea igual a cero, hasta que el Usuario decida cerrarla.

#### Cerrada

La Deuda deja de formar parte de la administración financiera activa por decisión del Usuario.

Si posteriormente vuelve a registrar un Saldo Pendiente, el producto deberá reabrir automáticamente la Deuda para continuar su administración.

---

### Consideraciones de negocio

- Toda Deuda podrá generar una o varias Obligaciones Financieras.
- No toda Obligación Financiera pertenece a una Deuda.
- El Saldo Pendiente determina la condición financiera de la Deuda.
- Una Deuda podrá aumentar o disminuir su Saldo Pendiente durante su ciclo de vida.
- La Tasa es un atributo opcional y estará disponible cuando aplique al tipo de Deuda correspondiente.
- El cierre de una Deuda siempre será una decisión del Usuario.
- El producto podrá recomendar el cierre de una Deuda cuyo Saldo Pendiente sea igual a cero, pero nunca lo realizará automáticamente.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-002 – Realidad Financiera | Forma parte de la Realidad Financiera del Usuario. |
| DC-003 – Obligación Financiera | Puede generar una o varias Obligaciones Financieras. |
| DC-005 – Evento Financiero | Puede tener asociados uno o varios Eventos Financieros. |
| DC-009 – Disponibilidad Financiera | Influye en la Disponibilidad Financiera del Usuario. |
| DC-015 – Prioridad Financiera | Puede participar en la determinación de Prioridades Financieras. |
| DC-016 – Recurso Financiero | Puede estar asociada a uno o varios Recursos Financieros. |
| DC-017 – Estrategia Financiera | Constituye uno de los principales elementos para la construcción de Estrategias Financieras. |

## DC-009 – Disponibilidad Financiera

### Definición

Representa la porción de la Realidad Financiera que el Usuario decide considerar para atender sus Obligaciones Financieras, realizar Gastos y construir su Plan Financiero.

La Disponibilidad Financiera no representa la totalidad de los recursos financieros del Usuario, sino únicamente aquellos que el propio Usuario ha decidido incorporar al análisis para la toma de decisiones en un momento determinado.

La Disponibilidad Financiera constituye la base sobre la cual BudgetKeep genera recomendaciones y propone Estrategias Financieras.

---

### Propósito

Representar la capacidad financiera utilizable por el Usuario para apoyar la toma de decisiones y la construcción de un Plan Financiero acorde con su realidad financiera.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-009.01 | Identificador | Identifica de manera única la Disponibilidad Financiera. |
| BI-009.02 | Moneda Base del Análisis | Moneda utilizada para presentar el análisis financiero consolidado. |
| BI-009.03 | Recursos Considerados | Conjunto de Recursos Financieros seleccionados por el Usuario para formar parte del análisis. |
| BI-009.04 | Recursos Excluidos | Recursos Financieros que el Usuario decidió no considerar para la toma de decisiones, sin dejar de formar parte de su Realidad Financiera. |
| BI-009.05 | Ingresos Considerados | Ingresos que el Usuario decidió incorporar al análisis de Disponibilidad Financiera. |
| BI-009.06 | Ingresos Excluidos | Ingresos que el Usuario decidió reservar y no utilizar para atender su situación financiera actual. |
| BI-009.07 | Fecha de Referencia | Fecha utilizada para realizar el análisis de la Disponibilidad Financiera. |
| BI-009.08 | Resultado de la Disponibilidad | Valor consolidado de la Disponibilidad Financiera considerando únicamente los elementos seleccionados por el Usuario. |

---

### Responsabilidades

La Disponibilidad Financiera deberá:

- representar únicamente los recursos que el Usuario haya decidido considerar para su análisis financiero;
- respetar la decisión del Usuario de incluir o excluir Recursos Financieros e Ingresos;
- actualizarse automáticamente cuando cambie la Realidad Financiera;
- actualizarse automáticamente cuando el Usuario modifique los elementos considerados para el análisis;
- servir como base para la generación de Recomendaciones Financieras;
- servir como base para la construcción de Estrategias Financieras;
- servir como base para la elaboración del Plan Financiero del Usuario.

---

### Consideraciones de negocio

- La Disponibilidad Financiera nunca representa la totalidad de la Realidad Financiera.
- La Realidad Financiera conserva toda la información registrada por el Usuario.
- Los Recursos Financieros excluidos continúan formando parte de la Realidad Financiera, pero no participan en el cálculo de la Disponibilidad Financiera.
- Los Ingresos excluidos continúan formando parte de la Realidad Financiera, pero no participan en la Disponibilidad Financiera hasta que el Usuario decida incorporarlos.
- La Disponibilidad Financiera nunca podrá ser negativa.
- Cuando no existan recursos disponibles para el análisis, la Disponibilidad Financiera será igual a cero.
- El Balance Financiero podrá reflejar una situación deficitaria aun cuando la Disponibilidad Financiera sea igual o superior a cero.
- La Disponibilidad Financiera utilizará una Moneda Base del Análisis para presentar la información consolidada, conservando siempre la moneda original de cada concepto financiero.
- La modificación de la Disponibilidad Financiera nunca altera la Realidad Financiera; únicamente modifica los elementos considerados para el análisis.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-002 – Realidad Financiera | Se construye a partir de la Realidad Financiera del Usuario. |
| DC-006 – Ingreso | Puede incorporar o excluir Ingresos del análisis. |
| DC-007 – Gasto | Se reduce conforme se registran Gastos confirmados. |
| DC-008 – Deuda | Se utiliza para evaluar la capacidad del Usuario para atender sus compromisos financieros. |
| DC-016 – Recurso Financiero | Utiliza los Recursos Financieros seleccionados por el Usuario. |
| DC-017 – Estrategia Financiera | Constituye la base para la generación de Estrategias Financieras. |
| DC-018 – Plan Financiero | Constituye la base sobre la cual el Usuario construye su Plan Financiero. |

## DC-010 – Entidad Relacionada

### Definición

Representa a la persona u organización distinta del Usuario con la que existe o existió una relación financiera.

Una Entidad Relacionada identifica al tercero con quien el Usuario mantiene compromisos financieros, recibe ingresos, realiza pagos o registra cualquier otra interacción económica que forme parte de su Realidad Financiera.

Las transferencias realizadas entre Recursos Financieros pertenecientes al mismo Usuario no generan una Entidad Relacionada, ya que no representan una relación financiera con un tercero.

---

### Propósito

Representar a los terceros que participan en las relaciones financieras del Usuario para proporcionar trazabilidad, organización y contexto a la información registrada dentro de la Realidad Financiera.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-010.01 | Identificador | Identifica de manera única la Entidad Relacionada. |
| BI-010.02 | Nombre | Nombre utilizado para identificar a la persona u organización. |
| BI-010.03 | Tipo de Entidad | Clasificación de la Entidad Relacionada. El producto proporcionará un catálogo inicial y permitirá al Usuario crear nuevos tipos. |
| BI-010.04 | Estado del Ciclo de Vida | Determina si la Entidad Relacionada continúa utilizándose o fue retirada por el Usuario. |
| BI-010.05 | Observaciones | Información adicional registrada por el Usuario. |

---

### Responsabilidades

Una Entidad Relacionada deberá:

- representar a un tercero con quien el Usuario mantiene o mantuvo una relación financiera;
- poder asociarse a Obligaciones Financieras, Deudas, Ingresos y Pagos;
- permitir su reutilización en múltiples registros financieros;
- conservar su información histórica;
- permitir al Usuario retirarla de uso cuando ya no participe en nuevas operaciones, sin afectar la información histórica.

---

### Estado del Ciclo de Vida

El Ciclo de Vida determina la disponibilidad de la Entidad Relacionada para nuevos registros.

Los estados permitidos son:

- Activa
- Retirada

#### Activa

La Entidad Relacionada puede utilizarse para registrar nuevas operaciones financieras.

#### Retirada

La Entidad Relacionada deja de estar disponible para nuevos registros, pero conserva toda la información histórica asociada.

Una Entidad Relacionada podrá volver al estado Activa por decisión del Usuario.

---

### Consideraciones de negocio

- Una Entidad Relacionada siempre representa una persona u organización distinta del Usuario.
- Una misma Entidad Relacionada podrá asociarse a múltiples registros financieros.
- Una transferencia entre Recursos Financieros pertenecientes al mismo Usuario no requiere una Entidad Relacionada.
- El producto proporcionará un catálogo inicial para el Tipo de Entidad y permitirá al Usuario crear nuevos tipos conforme a sus necesidades.
- Retirar una Entidad Relacionada nunca eliminará ni modificará la información histórica previamente registrada.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-003 – Obligación Financiera | Una Obligación Financiera puede asociarse a una Entidad Relacionada. |
| DC-004 – Pago | Un Pago puede realizarse a favor de una Entidad Relacionada. |
| DC-006 – Ingreso | Un Ingreso puede provenir de una Entidad Relacionada. |
| DC-008 – Deuda | Una Deuda puede existir con una Entidad Relacionada. |

## DC-011 – Moneda

### Definición

Representa la unidad monetaria utilizada para registrar la información financiera del Usuario.

La Moneda identifica la unidad de valor con la que se expresan los Recursos Financieros, Ingresos, Gastos, Deudas, Obligaciones Financieras y Pagos dentro de la Realidad Financiera.

Cada registro financiero conservará siempre la Moneda con la que fue originalmente registrado, independientemente de la Moneda Base utilizada para los análisis financieros.

---

### Propósito

Representar la unidad monetaria original de toda la información financiera registrada por el Usuario y proporcionar una base consistente para el soporte multimoneda del producto.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-011.01 | Identificador | Identifica de manera única la Moneda. |
| BI-011.02 | Código | Código internacional utilizado para identificar la Moneda (por ejemplo: MXN, USD, EUR). |
| BI-011.03 | Nombre | Nombre de la Moneda. |
| BI-011.04 | Símbolo | Símbolo utilizado para representar la Moneda. |
| BI-011.05 | Cantidad de Decimales | Número de posiciones decimales utilizadas por la Moneda. |
| BI-011.06 | Estado del Ciclo de Vida | Determina si la Moneda puede utilizarse para nuevos registros. |

---

### Responsabilidades

Una Moneda deberá:

- identificar la unidad monetaria utilizada por los registros financieros;
- conservar la moneda original de cada registro;
- permitir el registro de información financiera en distintas monedas;
- participar en los procesos de conversión monetaria mediante los Tipos de Cambio correspondientes;
- permitir al Usuario seleccionar una Moneda Base para los análisis financieros sin modificar la información originalmente registrada.

---

### Estado del Ciclo de Vida

El Ciclo de Vida determina si la Moneda puede utilizarse para registrar nueva información financiera.

Los estados permitidos son:

- Activa
- Retirada

#### Activa

La Moneda puede utilizarse para registrar nueva información financiera.

#### Retirada

La Moneda deja de estar disponible para nuevos registros, pero conservará toda la información histórica previamente registrada.

---

### Consideraciones de negocio

- Toda la información financiera deberá conservar la Moneda con la que fue originalmente registrada.
- Cambiar la Moneda Base del análisis nunca modificará la Moneda original de los registros financieros.
- Una misma Moneda podrá utilizarse en múltiples Recursos Financieros, Ingresos, Gastos, Deudas, Obligaciones Financieras y Pagos.
- La conversión entre monedas no forma parte de la responsabilidad de la Moneda; será administrada mediante los Tipos de Cambio.
- El producto proporcionará un catálogo inicial de Monedas y permitirá habilitar únicamente aquellas que el Usuario decida utilizar.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-006 – Ingreso | Todo Ingreso se registra en una Moneda. |
| DC-007 – Gasto | Todo Gasto se registra en una Moneda. |
| DC-008 – Deuda | Toda Deuda se registra en una Moneda. |
| DC-009 – Disponibilidad Financiera | Utiliza una Moneda Base para presentar los análisis. |
| DC-012 – Tipo de Cambio | Un Tipo de Cambio relaciona dos Monedas. |
| DC-014 – Recurso Financiero | Todo Recurso Financiero se registra en una Moneda. |

## DC-012 – Tipo de Cambio

### Definición

Representa la relación de conversión entre dos Monedas en un momento determinado.

Un Tipo de Cambio permite interpretar, comparar y analizar información financiera registrada en distintas Monedas, preservando siempre la Moneda original de cada registro.

El Tipo de Cambio constituye un concepto de negocio independiente de la Moneda y forma parte del soporte multimoneda de BudgetKeep.

---

### Propósito

Representar la relación de conversión entre dos Monedas para permitir el análisis consolidado de la Realidad Financiera del Usuario en una Moneda Base, sin alterar la información financiera originalmente registrada.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-012.01 | Identificador | Identifica de manera única el Tipo de Cambio. |
| BI-012.02 | Moneda Origen | Moneda desde la cual se realizará la conversión. |
| BI-012.03 | Moneda Destino | Moneda hacia la cual se realizará la conversión. |
| BI-012.04 | Valor de Conversión | Factor utilizado para convertir la Moneda Origen a la Moneda Destino. |
| BI-012.05 | Fecha de Vigencia | Fecha a partir de la cual el Tipo de Cambio es aplicable. |
| BI-012.06 | Estado del Ciclo de Vida | Determina si el Tipo de Cambio puede utilizarse para nuevos análisis. |

---

### Responsabilidades

Un Tipo de Cambio deberá:

- representar la relación de conversión entre dos Monedas;
- conservar la fecha de vigencia correspondiente;
- permitir la conversión de valores financieros entre distintas Monedas;
- preservar la Moneda original de toda la información financiera;
- permitir la comparación y consolidación de información financiera utilizando la Moneda Base del análisis.

---

### Estado del Ciclo de Vida

El Ciclo de Vida determina si el Tipo de Cambio puede utilizarse para nuevos análisis financieros.

Los estados permitidos son:

- Activo
- Retirado

#### Activo

El Tipo de Cambio podrá utilizarse para realizar conversiones monetarias.

#### Retirado

El Tipo de Cambio deja de utilizarse para nuevas conversiones, pero conservará su información histórica para mantener la trazabilidad de análisis previamente realizados.

---

### Consideraciones de negocio

- Un Tipo de Cambio relaciona exactamente dos Monedas.
- La relación de conversión se registra en una única dirección (Moneda Origen → Moneda Destino).
- La conversión inversa será calculada por el producto cuando sea necesaria; no deberá registrarse como un Tipo de Cambio independiente.
- El Tipo de Cambio nunca modifica la Moneda original de los registros financieros.
- El producto podrá conservar múltiples Tipos de Cambio para una misma combinación de Monedas en diferentes fechas de vigencia.
- El origen del Tipo de Cambio (captura manual, servicios externos u otros mecanismos) no forma parte de este Domain Concept.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-011 – Moneda | Relaciona dos Monedas para realizar conversiones. |
| DC-009 – Disponibilidad Financiera | Permite consolidar información financiera utilizando la Moneda Base del análisis. |
| DC-006 – Ingreso | Puede utilizarse para convertir Ingresos entre distintas Monedas durante el análisis. |
| DC-007 – Gasto | Puede utilizarse para convertir Gastos entre distintas Monedas durante el análisis. |
| DC-008 – Deuda | Puede utilizarse para convertir Deudas entre distintas Monedas durante el análisis. |
| DC-013 – Recurso Financiero | Puede utilizarse para consolidar Recursos Financieros registrados en distintas Monedas. |

## DC-013 – Prioridad Financiera

### Definición

Representa el nivel de importancia que el Usuario asigna a una Obligación Financiera para determinar el orden en que desea atender sus compromisos económicos.

La Prioridad Financiera expresa una decisión personal del Usuario basada en su realidad, necesidades y preferencias, y constituye un elemento fundamental para la construcción de su Plan Financiero.

La Prioridad Financiera nunca será modificada automáticamente por BudgetKeep.

---

### Propósito

Permitir que el Usuario establezca el orden de atención de sus Obligaciones Financieras conforme a sus propios criterios y facilitar la construcción de un Plan Financiero alineado con su realidad.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-013.01 | Identificador | Identifica de manera única la Prioridad Financiera. |
| BI-013.02 | Nombre | Nombre utilizado para identificar el nivel de prioridad. |
| BI-013.03 | Nivel | Valor ordinal utilizado para establecer el orden de atención de las Obligaciones Financieras. |
| BI-013.04 | Descripción | Explicación opcional del significado de la prioridad. |
| BI-013.05 | Estado del Ciclo de Vida | Determina si la Prioridad puede utilizarse para nuevas asignaciones. |

---

### Responsabilidades

Una Prioridad Financiera deberá:

- permitir al Usuario definir el orden en que desea atender sus Obligaciones Financieras;
- poder asociarse a una o varias Obligaciones Financieras;
- conservar la decisión del Usuario sin modificaciones automáticas;
- servir como uno de los elementos considerados durante la construcción del Plan Financiero;
- coexistir con las prioridades sugeridas por BudgetKeep sin sustituirlas.

---

### Estado del Ciclo de Vida

El Ciclo de Vida determina si una Prioridad Financiera puede utilizarse para nuevas asignaciones.

Los estados permitidos son:

- Activa
- Retirada

#### Activa

La Prioridad Financiera podrá asignarse a nuevas Obligaciones Financieras.

#### Retirada

La Prioridad Financiera deja de estar disponible para nuevas asignaciones, pero conserva todas las referencias históricas previamente registradas.

---

### Consideraciones de negocio

- La Prioridad Financiera representa exclusivamente una decisión del Usuario.
- BudgetKeep nunca modificará automáticamente la Prioridad Financiera definida por el Usuario.
- BudgetKeep podrá generar prioridades recomendadas como parte de sus Estrategias Financieras.
- Las prioridades recomendadas no sustituyen ni modifican la Prioridad Financiera definida por el Usuario.
- El Usuario podrá modificar la Prioridad Financiera en cualquier momento conforme cambie su realidad financiera.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-003 – Obligación Financiera | Una Obligación Financiera puede tener asignada una Prioridad Financiera. |
| DC-015 – Estrategia Financiera | Las Estrategias Financieras consideran la Prioridad Financiera definida por el Usuario junto con las prioridades recomendadas por BudgetKeep. |
| DC-016 – Plan Financiero | El Plan Financiero utiliza la Prioridad Financiera como uno de los criterios para organizar la ejecución de las acciones del Usuario. |

## DC-014 – Recurso Financiero

### Definición

Representa cualquier recurso económico administrado por el Usuario que puede participar en su Disponibilidad Financiera para atender Obligaciones Financieras, realizar Pagos, registrar Gastos o ejecutar su Plan Financiero.

Un Recurso Financiero puede representar dinero disponible, líneas de crédito u otros instrumentos financieros que el Usuario decida administrar dentro de BudgetKeep.

La participación de un Recurso Financiero en la Disponibilidad Financiera será siempre una decisión del Usuario.

---

### Propósito

Representar los recursos económicos administrados por el Usuario y proporcionar la base para calcular la Disponibilidad Financiera utilizada durante el análisis, la generación de Estrategias Financieras y la construcción del Plan Financiero.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-014.01 | Identificador | Identifica de manera única el Recurso Financiero. |
| BI-014.02 | Nombre | Nombre utilizado para identificar el Recurso Financiero. |
| BI-014.03 | Tipo de Recurso | Clasificación del Recurso Financiero. El producto proporcionará un catálogo inicial y permitirá al Usuario crear nuevos tipos. |
| BI-014.04 | Entidad Relacionada | Institución o persona propietaria o administradora del Recurso Financiero, cuando aplique. |
| BI-014.05 | Moneda | Moneda en la que opera el Recurso Financiero. |
| BI-014.06 | Saldo Actual | Valor disponible registrado para el Recurso Financiero. |
| BI-014.07 | Disponible para Análisis | Indica si el Usuario desea considerar este Recurso Financiero dentro de la Disponibilidad Financiera. |
| BI-014.08 | Estado del Ciclo de Vida | Determina si el Recurso Financiero continúa siendo administrado por el Usuario. |
| BI-014.09 | Observaciones | Información adicional registrada por el Usuario. |

---

### Responsabilidades

Un Recurso Financiero deberá:

- representar un recurso económico administrado por el Usuario;
- conservar su moneda original;
- mantener su saldo actualizado conforme evolucione la Realidad Financiera;
- permitir al Usuario decidir si participa o no en la Disponibilidad Financiera;
- participar en la ejecución de Pagos, Gastos e Ingresos cuando corresponda;
- conservar su historial aun cuando deje de utilizarse.

---

### Estado del Ciclo de Vida

El Ciclo de Vida determina si el Recurso Financiero continúa formando parte de la administración financiera del Usuario.

Los estados permitidos son:

- Activo
- Retirado

#### Activo

El Recurso Financiero puede utilizarse para registrar nuevas operaciones financieras y participar en la Disponibilidad Financiera.

#### Retirado

El Recurso Financiero deja de utilizarse para nuevas operaciones, pero conserva toda la información histórica previamente registrada.

Un Recurso Financiero podrá volver al estado Activo por decisión del Usuario.

---

### Consideraciones de negocio

- Todo Recurso Financiero pertenece exclusivamente al Usuario.
- Un Recurso Financiero podrá participar o no en la Disponibilidad Financiera según la decisión del Usuario.
- Excluir un Recurso Financiero de la Disponibilidad Financiera no modifica la Realidad Financiera.
- Un Recurso Financiero podrá utilizarse en múltiples Ingresos, Gastos y Pagos.
- El producto proporcionará un catálogo inicial para los Tipos de Recurso Financiero y permitirá al Usuario crear nuevos tipos conforme a sus necesidades.
- El saldo de un Recurso Financiero podrá variar como consecuencia de los Eventos Financieros registrados por el Usuario.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-002 – Realidad Financiera | Forma parte de la Realidad Financiera del Usuario. |
| DC-004 – Pago | Un Pago puede utilizar un Recurso Financiero. |
| DC-006 – Ingreso | Un Ingreso puede depositarse en un Recurso Financiero. |
| DC-007 – Gasto | Un Gasto puede realizarse utilizando un Recurso Financiero. |
| DC-009 – Disponibilidad Financiera | Puede participar en la Disponibilidad Financiera por decisión del Usuario. |
| DC-010 – Entidad Relacionada | Puede estar asociado a una Entidad Relacionada cuando corresponda. |
| DC-011 – Moneda | Opera en una Moneda determinada. |
| DC-012 – Tipo de Cambio | Puede participar en conversiones monetarias durante el análisis financiero. |
| DC-016 – Plan Financiero | Puede ser seleccionado por el Usuario para ejecutar las acciones definidas en su Plan Financiero. |

## DC-015 – Estrategia Financiera

### Definición

Representa un enfoque alternativo propuesto por BudgetKeep para mejorar, estabilizar u optimizar la Realidad Financiera del Usuario.

Una Estrategia Financiera constituye el resultado del análisis realizado por BudgetKeep sobre la información registrada por el Usuario y propone un conjunto organizado de acciones orientadas a alcanzar un objetivo financiero determinado.

Para una misma situación financiera podrán existir múltiples Estrategias Financieras.

Las Estrategias Financieras representan recomendaciones generadas por BudgetKeep y nunca sustituyen las decisiones del Usuario.

---

### Propósito

Proporcionar al Usuario alternativas para atender su Realidad Financiera mediante recomendaciones estructuradas que sirvan como base para la construcción de su Plan Financiero.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-015.01 | Identificador | Identifica de manera única la Estrategia Financiera. |
| BI-015.02 | Nombre | Nombre utilizado para identificar la Estrategia Financiera. |
| BI-015.03 | Objetivo | Resultado financiero que la Estrategia busca alcanzar. |
| BI-015.04 | Descripción | Explicación general de la Estrategia propuesta. |
| BI-015.05 | Prioridad Recomendada | Orden sugerido por BudgetKeep para atender las Obligaciones Financieras involucradas. |
| BI-015.06 | Beneficios Esperados | Resultados esperados si el Usuario adopta la Estrategia. |
| BI-015.07 | Consideraciones | Aspectos que el Usuario debe tomar en cuenta antes de adoptar la Estrategia. |

---

### Responsabilidades

Una Estrategia Financiera deberá:

- analizar la Realidad Financiera del Usuario;
- considerar la Disponibilidad Financiera seleccionada por el Usuario;
- considerar las Prioridades Financieras definidas por el Usuario;
- generar recomendaciones orientadas al logro de un objetivo financiero;
- proponer diferentes alternativas cuando exista más de una solución posible;
- servir como base para que el Usuario construya su Plan Financiero.

---

### Consideraciones de negocio

- Una Estrategia Financiera es generada exclusivamente por BudgetKeep.
- Una misma situación financiera podrá producir múltiples Estrategias Financieras.
- Las Estrategias Financieras representan recomendaciones y no decisiones obligatorias.
- La Prioridad Recomendada generada por BudgetKeep nunca modifica la Prioridad Financiera definida por el Usuario.
- El Usuario podrá adoptar completamente una Estrategia, combinar elementos de varias Estrategias o construir un Plan Financiero completamente distinto.
- Una Estrategia Financiera no modifica por sí misma la Realidad Financiera del Usuario.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-002 – Realidad Financiera | Se construye a partir del análisis de la Realidad Financiera. |
| DC-003 – Obligación Financiera | Puede proponer un orden recomendado para atender las Obligaciones Financieras. |
| DC-008 – Deuda | Puede proponer alternativas para administrar o reducir las Deudas. |
| DC-009 – Disponibilidad Financiera | Utiliza la Disponibilidad Financiera como base para el análisis. |
| DC-013 – Prioridad Financiera | Considera la Prioridad Financiera definida por el Usuario sin modificarla. |
| DC-016 – Plan Financiero | Sirve como base para la construcción del Plan Financiero. |

## DC-016 – Plan Financiero

### Definición

Representa el conjunto organizado de decisiones financieras adoptadas por el Usuario después de evaluar las Recomendaciones Financieras y las Estrategias Financieras propuestas por BudgetKeep.

El Plan Financiero constituye la estrategia personal de ejecución del Usuario para mejorar, estabilizar o mantener su Realidad Financiera durante un periodo determinado.

Un Plan Financiero podrá evolucionar conforme cambie la Realidad Financiera del Usuario o éste decida modificar sus acciones.

---

### Propósito

Permitir que el Usuario transforme las recomendaciones y estrategias propuestas por BudgetKeep en un plan concreto de ejecución que pueda consultarse, ajustarse y seguirse a lo largo del tiempo.

---

### Información de negocio

| Identificador | Atributo | Descripción |
|---------------|----------|-------------|
| BI-016.01 | Identificador | Identifica de manera única el Plan Financiero. |
| BI-016.02 | Nombre | Nombre utilizado para identificar el Plan Financiero. |
| BI-016.03 | Objetivo | Resultado financiero que el Usuario desea alcanzar mediante la ejecución del Plan. |
| BI-016.04 | Fecha de Inicio | Fecha a partir de la cual el Plan comienza a ejecutarse. |
| BI-016.05 | Fecha de Revisión | Fecha prevista para revisar o actualizar el Plan. |
| BI-016.06 | Estado del Ciclo de Vida | Determina si el Plan continúa vigente. |
| BI-016.07 | Notas del Usuario | Observaciones, decisiones o recordatorios registrados por el Usuario durante la construcción y ejecución del Plan. |

---

### Responsabilidades

Un Plan Financiero deberá:

- representar las decisiones adoptadas por el Usuario;
- poder construirse utilizando una o varias Estrategias Financieras;
- permitir al Usuario definir el orden en que ejecutará sus acciones;
- permitir registrar observaciones y recordatorios personales;
- evolucionar conforme cambie la Realidad Financiera o el Usuario modifique sus decisiones;
- servir como referencia durante la ejecución de las acciones financieras.

---

### Estado del Ciclo de Vida

El Ciclo de Vida determina si el Plan Financiero continúa vigente.

Los estados permitidos son:

- Activo
- Finalizado

#### Activo

El Plan Financiero continúa siendo utilizado por el Usuario como guía para la ejecución de sus decisiones financieras.

#### Finalizado

El Plan deja de utilizarse para nuevas acciones, pero conserva toda la información histórica para futuras consultas.

---

### Consideraciones de negocio

- El Plan Financiero siempre representa una decisión del Usuario.
- BudgetKeep nunca modificará automáticamente un Plan Financiero.
- El Usuario podrá construir un Plan Financiero utilizando una Estrategia Financiera completa, combinar varias Estrategias o definir un Plan completamente propio.
- Un Plan Financiero podrá modificarse en cualquier momento.
- La modificación de un Plan Financiero no altera automáticamente la Realidad Financiera; únicamente cambia la planificación del Usuario.
- El cumplimiento del Plan dependerá de los Eventos Financieros registrados por el Usuario.

---

### Relaciones

| Concepto | Relación |
|-----------|----------|
| DC-002 – Realidad Financiera | Se construye considerando la Realidad Financiera del Usuario. |
| DC-003 – Obligación Financiera | Puede organizar el orden de atención de las Obligaciones Financieras. |
| DC-004 – Pago | Puede planificar la ejecución de Pagos. |
| DC-009 – Disponibilidad Financiera | Utiliza la Disponibilidad Financiera como base para construir el Plan. |
| DC-013 – Prioridad Financiera | Considera la Prioridad Financiera definida por el Usuario. |
| DC-014 – Recurso Financiero | Puede seleccionar los Recursos Financieros que el Usuario utilizará durante la ejecución del Plan. |
| DC-015 – Estrategia Financiera | Puede construirse a partir de una o varias Estrategias Financieras propuestas por BudgetKeep. |