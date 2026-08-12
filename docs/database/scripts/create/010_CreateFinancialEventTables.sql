/*
    BudgetKeep
    Financial Events
    Create Tables

    Creates:
      - Income
      - Expense
      - StandAlone
      - RecurrenceConfiguration
      - FinancialEvent

    Existing catalog tables reused:
      - IncomeType
      - ExpenseCategory
      - RecurrenceType
      - Currency
      - User
*/

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

CREATE TABLE dbo.Income
(
    IncomeId       BIGINT IDENTITY(1,1) NOT NULL,
    UserId         BIGINT NOT NULL,
    Name           NVARCHAR(150) NOT NULL,
    IncomeTypeId   BIGINT NOT NULL,
    CurrencyId     BIGINT NOT NULL,
    ExpectedAmount DECIMAL(19,4) NULL,
    IsActive       BIT NOT NULL CONSTRAINT DF_Income_IsActive DEFAULT (1),
    CreatedAt      DATETIME2(3) NOT NULL CONSTRAINT DF_Income_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy      BIGINT NULL,
    UpdatedAt      DATETIME2(3) NULL,
    UpdatedBy      BIGINT NULL,
    DeletedAt      DATETIME2(3) NULL,
    DeletedBy      BIGINT NULL,
    CONSTRAINT PK_Income PRIMARY KEY (IncomeId)
);

CREATE TABLE dbo.Expense
(
    ExpenseId         BIGINT IDENTITY(1,1) NOT NULL,
    UserId            BIGINT NOT NULL,
    Name              NVARCHAR(150) NOT NULL,
    ExpenseCategoryId BIGINT NOT NULL,
    ExpenseType       VARCHAR(50) NOT NULL,
    CurrencyId        BIGINT NOT NULL,
    ExpectedAmount    DECIMAL(19,4) NULL,
    IsActive          BIT NOT NULL CONSTRAINT DF_Expense_IsActive DEFAULT (1),
    CreatedAt         DATETIME2(3) NOT NULL CONSTRAINT DF_Expense_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy         BIGINT NULL,
    UpdatedAt         DATETIME2(3) NULL,
    UpdatedBy         BIGINT NULL,
    DeletedAt         DATETIME2(3) NULL,
    DeletedBy         BIGINT NULL,
    CONSTRAINT PK_Expense PRIMARY KEY (ExpenseId),
    CONSTRAINT CK_Expense_ExpenseType CHECK (ExpenseType IN ('FIXED','VARIABLE'))
);

CREATE TABLE dbo.StandAlone
(
    StandAloneId BIGINT IDENTITY(1,1) NOT NULL,
    UserId       BIGINT NOT NULL,
    EventType    VARCHAR(20) NOT NULL,
    Description  NVARCHAR(500) NOT NULL,
    CurrencyId   BIGINT NOT NULL,
    CreatedAt    DATETIME2(3) NOT NULL CONSTRAINT DF_StandAlone_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy    BIGINT NULL,
    UpdatedAt    DATETIME2(3) NULL,
    UpdatedBy    BIGINT NULL,
    DeletedAt    DATETIME2(3) NULL,
    DeletedBy    BIGINT NULL,
    CONSTRAINT PK_StandAlone PRIMARY KEY (StandAloneId),
    CONSTRAINT CK_StandAlone_EventType CHECK (EventType IN ('INCOME','EXPENSE'))
);

CREATE TABLE dbo.RecurrenceConfiguration
(
    RecurrenceConfigurationId BIGINT IDENTITY(1,1) NOT NULL,
    IncomeId                  BIGINT NULL,
    ExpenseId                 BIGINT NULL,
    RecurrenceTypeId          BIGINT NOT NULL,
    StartDate                 DATE NOT NULL,
    EndDate                   DATE NULL,
    DayOfMonth                TINYINT NULL,
    DayOfWeek                 TINYINT NULL,
    AnchorDate                DATE NULL,
    IsActive                  BIT NOT NULL CONSTRAINT DF_RecurrenceConfiguration_IsActive DEFAULT (1),
    CreatedAt                 DATETIME2(3) NOT NULL CONSTRAINT DF_RecurrenceConfiguration_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy                 BIGINT NULL,
    UpdatedAt                 DATETIME2(3) NULL,
    UpdatedBy                 BIGINT NULL,
    DeletedAt                 DATETIME2(3) NULL,
    DeletedBy                 BIGINT NULL,
    CONSTRAINT PK_RecurrenceConfiguration PRIMARY KEY (RecurrenceConfigurationId),
    CONSTRAINT CK_RecurrenceConfiguration_Source CHECK (
        (IncomeId IS NOT NULL AND ExpenseId IS NULL)
        OR
        (IncomeId IS NULL AND ExpenseId IS NOT NULL)
    ),
    CONSTRAINT CK_RecurrenceConfiguration_Dates CHECK (
        EndDate IS NULL OR EndDate >= StartDate
    ),
    CONSTRAINT CK_RecurrenceConfiguration_DayOfMonth CHECK (
        DayOfMonth IS NULL OR DayOfMonth BETWEEN 1 AND 31
    ),
    CONSTRAINT CK_RecurrenceConfiguration_DayOfWeek CHECK (
        DayOfWeek IS NULL OR DayOfWeek BETWEEN 1 AND 7
    )
);

CREATE TABLE dbo.FinancialEvent
(
    FinancialEventId BIGINT IDENTITY(1,1) NOT NULL,
    UserId           BIGINT NOT NULL,
    EventType        VARCHAR(20) NOT NULL,
    IncomeId         BIGINT NULL,
    ExpenseId        BIGINT NULL,
    StandAloneId     BIGINT NULL,
    ExpectedDate     DATE NOT NULL,
    ActualDate       DATE NULL,
    ExpectedAmount   DECIMAL(19,4) NULL,
    ActualAmount     DECIMAL(19,4) NULL,
    EventStatus      VARCHAR(20) NOT NULL,
    CreatedAt        DATETIME2(3) NOT NULL CONSTRAINT DF_FinancialEvent_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy        BIGINT NULL,
    UpdatedAt        DATETIME2(3) NULL,
    UpdatedBy        BIGINT NULL,
    DeletedAt        DATETIME2(3) NULL,
    DeletedBy        BIGINT NULL,
    CONSTRAINT PK_FinancialEvent PRIMARY KEY (FinancialEventId),
    CONSTRAINT CK_FinancialEvent_Source CHECK (
        (IncomeId IS NOT NULL AND ExpenseId IS NULL AND StandAloneId IS NULL)
        OR
        (IncomeId IS NULL AND ExpenseId IS NOT NULL AND StandAloneId IS NULL)
        OR
        (IncomeId IS NULL AND ExpenseId IS NULL AND StandAloneId IS NOT NULL)
    ),
    CONSTRAINT CK_FinancialEvent_EventType CHECK (EventType IN ('INCOME','EXPENSE')),
    CONSTRAINT CK_FinancialEvent_EventStatus CHECK (EventStatus IN ('EXPECTED','CONFIRMED')),
    CONSTRAINT CK_FinancialEvent_ExpectedState CHECK (
        EventStatus <> 'EXPECTED'
        OR (ActualDate IS NULL AND ActualAmount IS NULL)
    ),
    CONSTRAINT CK_FinancialEvent_ConfirmedState CHECK (
        EventStatus <> 'CONFIRMED'
        OR (ActualDate IS NOT NULL AND ActualAmount IS NOT NULL)
    )
);

COMMIT TRANSACTION;
