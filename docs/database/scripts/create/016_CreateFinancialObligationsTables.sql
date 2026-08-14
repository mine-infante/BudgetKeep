/*
 BudgetKeep | DB-001 | Financial Obligations
 CREATE - Tables
*/
SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

CREATE TABLE dbo.FinancialObligationType
(
    FinancialObligationTypeId BIGINT IDENTITY(1,1) NOT NULL,
    OwnerUserId BIGINT NULL,
    Code VARCHAR(50) NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500) NULL,
    IsActive BIT NOT NULL,
    CreatedAt DATETIME2(3) NOT NULL CONSTRAINT DF_FinancialObligationType_CreatedAt DEFAULT SYSUTCDATETIME(),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,
    CONSTRAINT PK_FinancialObligationType PRIMARY KEY (FinancialObligationTypeId)
);

CREATE TABLE dbo.DebtType
(
    DebtTypeId BIGINT IDENTITY(1,1) NOT NULL,
    OwnerUserId BIGINT NULL,
    Code VARCHAR(50) NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500) NULL,
    IsActive BIT NOT NULL,
    CreatedAt DATETIME2(3) NOT NULL CONSTRAINT DF_DebtType_CreatedAt DEFAULT SYSUTCDATETIME(),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,
    CONSTRAINT PK_DebtType PRIMARY KEY (DebtTypeId)
);

CREATE TABLE dbo.FinancialPriority
(
    FinancialPriorityId BIGINT IDENTITY(1,1) NOT NULL,
    UserId BIGINT NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Level INT NOT NULL,
    Description NVARCHAR(500) NULL,
    LifecycleStatus VARCHAR(20) NOT NULL,
    CreatedAt DATETIME2(3) NOT NULL CONSTRAINT DF_FinancialPriority_CreatedAt DEFAULT SYSUTCDATETIME(),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    CONSTRAINT PK_FinancialPriority PRIMARY KEY (FinancialPriorityId)
);

CREATE TABLE dbo.RelatedEntityType
(
    RelatedEntityTypeId BIGINT IDENTITY(1,1) NOT NULL,
    OwnerUserId BIGINT NULL,
    Code VARCHAR(50) NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500) NULL,
    IsActive BIT NOT NULL,
    CreatedAt DATETIME2(3) NOT NULL CONSTRAINT DF_RelatedEntityType_CreatedAt DEFAULT SYSUTCDATETIME(),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,
    CONSTRAINT PK_RelatedEntityType PRIMARY KEY (RelatedEntityTypeId)
);

CREATE TABLE dbo.RelatedEntity
(
    RelatedEntityId BIGINT IDENTITY(1,1) NOT NULL,
    UserId BIGINT NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    RelatedEntityTypeId BIGINT NOT NULL,
    LifecycleStatus VARCHAR(20) NOT NULL,
    Notes NVARCHAR(500) NULL,
    CreatedAt DATETIME2(3) NOT NULL CONSTRAINT DF_RelatedEntity_CreatedAt DEFAULT SYSUTCDATETIME(),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,
    CONSTRAINT PK_RelatedEntity PRIMARY KEY (RelatedEntityId)
);

CREATE TABLE dbo.Debt
(
    DebtId BIGINT IDENTITY(1,1) NOT NULL,
    UserId BIGINT NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    DebtTypeId BIGINT NOT NULL,
    RelatedEntityId BIGINT NULL,
    InitialAmount DECIMAL(19,4) NULL,
    OutstandingBalance DECIMAL(19,4) NOT NULL,
    CurrencyId BIGINT NOT NULL,
    InterestRate DECIMAL(9,6) NULL,
    LifecycleStatus VARCHAR(20) NOT NULL,
    Notes NVARCHAR(500) NULL,
    CreatedAt DATETIME2(3) NOT NULL CONSTRAINT DF_Debt_CreatedAt DEFAULT SYSUTCDATETIME(),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,
    CONSTRAINT PK_Debt PRIMARY KEY (DebtId),
    CONSTRAINT CK_Debt_OutstandingBalance CHECK (OutstandingBalance >= 0)
);

CREATE TABLE dbo.FinancialObligation
(
    FinancialObligationId BIGINT IDENTITY(1,1) NOT NULL,
    UserId BIGINT NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    FinancialObligationTypeId BIGINT NOT NULL,
    DebtId BIGINT NULL,
    Amount DECIMAL(19,4) NOT NULL,
    CurrencyId BIGINT NOT NULL,
    FinancialPriorityId BIGINT NULL,
    DueDate DATE NULL,
    LifecycleStatus VARCHAR(20) NOT NULL,
    CreatedAt DATETIME2(3) NOT NULL CONSTRAINT DF_FinancialObligation_CreatedAt DEFAULT SYSUTCDATETIME(),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,
    CONSTRAINT PK_FinancialObligation PRIMARY KEY (FinancialObligationId),
    CONSTRAINT CK_FinancialObligation_Amount CHECK (Amount >= 0)
);

CREATE TABLE dbo.FinancialObligationRecurrenceConfiguration
(
    FinancialObligationRecurrenceConfigurationId BIGINT IDENTITY(1,1) NOT NULL,
    FinancialObligationId BIGINT NOT NULL,
    RecurrenceTypeId BIGINT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    DayOfMonth INT NULL,
    DayOfWeek INT NULL,
    AnchorDate DATE NULL,
    IsActive BIT NOT NULL,
    CreatedAt DATETIME2(3) NOT NULL CONSTRAINT DF_FinancialObligationRecurrenceConfiguration_CreatedAt DEFAULT SYSUTCDATETIME(),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,
    CONSTRAINT PK_FinancialObligationRecurrenceConfiguration PRIMARY KEY (FinancialObligationRecurrenceConfigurationId),
    CONSTRAINT CK_FinancialObligationRecurrenceConfiguration_DateRange CHECK (EndDate IS NULL OR EndDate >= StartDate)
);

CREATE TABLE dbo.Payment
(
    PaymentId BIGINT IDENTITY(1,1) NOT NULL,
    UserId BIGINT NOT NULL,
    FinancialObligationId BIGINT NOT NULL,
    FinancialEventId BIGINT NOT NULL,
    CreatedAt DATETIME2(3) NOT NULL CONSTRAINT DF_Payment_CreatedAt DEFAULT SYSUTCDATETIME(),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,
    CONSTRAINT PK_Payment PRIMARY KEY (PaymentId)
);

CREATE TABLE dbo.PaymentResource
(
    PaymentResourceId BIGINT IDENTITY(1,1) NOT NULL,
    PaymentId BIGINT NOT NULL,
    FinancialResourceId BIGINT NOT NULL,
    AmountUsed DECIMAL(19,4) NOT NULL,
    ExchangeRate DECIMAL(19,8) NOT NULL,
    AppliedAmount DECIMAL(19,4) NOT NULL,
    CreatedAt DATETIME2(3) NOT NULL CONSTRAINT DF_PaymentResource_CreatedAt DEFAULT SYSUTCDATETIME(),
    CreatedBy BIGINT NULL,
    CONSTRAINT PK_PaymentResource PRIMARY KEY (PaymentResourceId),
    CONSTRAINT CK_PaymentResource_AmountUsed CHECK (AmountUsed > 0),
    CONSTRAINT CK_PaymentResource_ExchangeRate CHECK (ExchangeRate > 0),
    CONSTRAINT CK_PaymentResource_AppliedAmount CHECK (AppliedAmount > 0)
);

COMMIT TRANSACTION;
