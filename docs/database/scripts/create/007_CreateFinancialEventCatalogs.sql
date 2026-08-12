/*
    BudgetKeep
    Financial Events - Supporting Catalog Tables

    Creates only the catalog tables required by Financial Events:
      - IncomeType
      - ExpenseCategory
      - RecurrenceType

    Currency is NOT created here because it already belongs to the existing
    Catalogs implementation.

    User is an existing dependency.
*/

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

CREATE TABLE dbo.IncomeType
(
    IncomeTypeId BIGINT IDENTITY(1,1) NOT NULL,
    Code         VARCHAR(50) NOT NULL,
    Name         NVARCHAR(150) NOT NULL,
    Description  NVARCHAR(500) NULL,
    IsActive     BIT NOT NULL
        CONSTRAINT DF_IncomeType_IsActive DEFAULT (1),
    CreatedAt    DATETIME2(3) NOT NULL
        CONSTRAINT DF_IncomeType_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy    BIGINT NULL,
    UpdatedAt    DATETIME2(3) NULL,
    UpdatedBy    BIGINT NULL,
    DeletedAt    DATETIME2(3) NULL,
    DeletedBy    BIGINT NULL,

    CONSTRAINT PK_IncomeType
        PRIMARY KEY (IncomeTypeId),

    CONSTRAINT UQ_IncomeType_Code
        UNIQUE (Code)
);

CREATE TABLE dbo.ExpenseCategory
(
    ExpenseCategoryId BIGINT IDENTITY(1,1) NOT NULL,
    Code              VARCHAR(50) NOT NULL,
    Name              NVARCHAR(150) NOT NULL,
    Description       NVARCHAR(500) NULL,
    IsActive          BIT NOT NULL
        CONSTRAINT DF_ExpenseCategory_IsActive DEFAULT (1),
    CreatedAt         DATETIME2(3) NOT NULL
        CONSTRAINT DF_ExpenseCategory_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy         BIGINT NULL,
    UpdatedAt         DATETIME2(3) NULL,
    UpdatedBy         BIGINT NULL,
    DeletedAt         DATETIME2(3) NULL,
    DeletedBy         BIGINT NULL,

    CONSTRAINT PK_ExpenseCategory
        PRIMARY KEY (ExpenseCategoryId),

    CONSTRAINT UQ_ExpenseCategory_Code
        UNIQUE (Code)
);

CREATE TABLE dbo.RecurrenceType
(
    RecurrenceTypeId BIGINT IDENTITY(1,1) NOT NULL,
    Code             VARCHAR(50) NOT NULL,
    Name             NVARCHAR(150) NOT NULL,
    Description      NVARCHAR(500) NULL,
    IsActive         BIT NOT NULL
        CONSTRAINT DF_RecurrenceType_IsActive DEFAULT (1),
    CreatedAt        DATETIME2(3) NOT NULL
        CONSTRAINT DF_RecurrenceType_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy        BIGINT NULL,
    UpdatedAt        DATETIME2(3) NULL,
    UpdatedBy        BIGINT NULL,

    CONSTRAINT PK_RecurrenceType
        PRIMARY KEY (RecurrenceTypeId),

    CONSTRAINT UQ_RecurrenceType_Code
        UNIQUE (Code)
);

COMMIT TRANSACTION;
