/*
    BudgetKeep
    Domain: Financial Resources
    Script: Create Tables
    Order: 004
*/

SET NOCOUNT ON;
GO

CREATE TABLE dbo.Currency
(
    CurrencyId BIGINT IDENTITY(1,1) NOT NULL,
    Code VARCHAR(50) NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Symbol NVARCHAR(10) NOT NULL,
    IsActive BIT NOT NULL
        CONSTRAINT DF_Currency_IsActive DEFAULT (1),
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_Currency_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,

    CONSTRAINT PK_Currency
        PRIMARY KEY (CurrencyId),

    CONSTRAINT UQ_Currency_Code
        UNIQUE (Code)
);
GO

CREATE TABLE dbo.FinancialResource
(
    FinancialResourceId BIGINT IDENTITY(1,1) NOT NULL,
    UserId BIGINT NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    ResourceType VARCHAR(50) NOT NULL,
    CurrencyId BIGINT NOT NULL,
    AvailableAmount DECIMAL(19,4) NOT NULL,
    IsActive BIT NOT NULL
        CONSTRAINT DF_FinancialResource_IsActive DEFAULT (1),
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_FinancialResource_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,

    CONSTRAINT PK_FinancialResource
        PRIMARY KEY (FinancialResourceId)
);
GO