/*
    BudgetKeep
    Domain: Financial Planning
    Script: Create Tables
    Order: 013
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

CREATE TABLE dbo.FinancialStrategy
(
    FinancialStrategyId BIGINT IDENTITY(1,1) NOT NULL,
    UserId              BIGINT NOT NULL,
    Name                NVARCHAR(150) NOT NULL,
    Objective           NVARCHAR(500) NOT NULL,
    Description         NVARCHAR(500) NOT NULL,
    RecommendedPriority INT NULL,
    ExpectedBenefits    NVARCHAR(500) NULL,
    Considerations      NVARCHAR(500) NULL,
    CreatedAt           DATETIME2(3) NOT NULL
        CONSTRAINT DF_FinancialStrategy_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy           BIGINT NULL,

    CONSTRAINT PK_FinancialStrategy
        PRIMARY KEY (FinancialStrategyId),

);

CREATE TABLE dbo.FinancialStrategyItem
(
    FinancialStrategyItemId BIGINT IDENTITY(1,1) NOT NULL,
    FinancialStrategyId     BIGINT NOT NULL,
    SequenceNumber          INT NOT NULL,
    Description             NVARCHAR(500) NOT NULL,
    CreatedAt               DATETIME2(3) NOT NULL
        CONSTRAINT DF_FinancialStrategyItem_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy               BIGINT NULL,

    CONSTRAINT PK_FinancialStrategyItem
        PRIMARY KEY (FinancialStrategyItemId),

    CONSTRAINT CK_FinancialStrategyItem_SequenceNumber
        CHECK (SequenceNumber > 0)
);

CREATE TABLE dbo.FinancialPlan
(
    FinancialPlanId   BIGINT IDENTITY(1,1) NOT NULL,
    UserId            BIGINT NOT NULL,
    Name              NVARCHAR(150) NOT NULL,
    Objective         NVARCHAR(500) NOT NULL,
    StartDate         DATE NOT NULL,
    ReviewDate        DATE NULL,
    LifecycleStatus   VARCHAR(20) NOT NULL,
    UserNotes         NVARCHAR(500) NULL,
    CreatedAt         DATETIME2(3) NOT NULL
        CONSTRAINT DF_FinancialPlan_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy         BIGINT NULL,
    UpdatedAt         DATETIME2(3) NULL,
    UpdatedBy         BIGINT NULL,

    CONSTRAINT PK_FinancialPlan
        PRIMARY KEY (FinancialPlanId),

    CONSTRAINT CK_FinancialPlan_LifecycleStatus
        CHECK (LifecycleStatus IN ('ACTIVE', 'FINALIZED')),

    CONSTRAINT CK_FinancialPlan_ReviewDate
        CHECK (
            ReviewDate IS NULL
            OR ReviewDate >= StartDate
        )
);

CREATE TABLE dbo.FinancialPlanItem
(
    FinancialPlanItemId BIGINT IDENTITY(1,1) NOT NULL,
    FinancialPlanId     BIGINT NOT NULL,
    SequenceNumber      INT NOT NULL,
    Description         NVARCHAR(500) NOT NULL,
    CreatedAt           DATETIME2(3) NOT NULL
        CONSTRAINT DF_FinancialPlanItem_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy           BIGINT NULL,
    UpdatedAt           DATETIME2(3) NULL,
    UpdatedBy           BIGINT NULL,
    DeletedAt           DATETIME2(3) NULL,
    DeletedBy           BIGINT NULL,

    CONSTRAINT PK_FinancialPlanItem
        PRIMARY KEY (FinancialPlanItemId),

    CONSTRAINT CK_FinancialPlanItem_SequenceNumber
        CHECK (SequenceNumber > 0)
);

CREATE TABLE dbo.FinancialPlanStrategy
(
    FinancialPlanId       BIGINT NOT NULL,
    FinancialStrategyId   BIGINT NOT NULL,
    CreatedAt             DATETIME2(3) NOT NULL
        CONSTRAINT DF_FinancialPlanStrategy_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy             BIGINT NULL,

    CONSTRAINT PK_FinancialPlanStrategy
        PRIMARY KEY (FinancialPlanId, FinancialStrategyId)
);

CREATE TABLE dbo.FinancialPlanResource
(
    FinancialPlanId       BIGINT NOT NULL,
    FinancialResourceId   BIGINT NOT NULL,
    CreatedAt             DATETIME2(3) NOT NULL
        CONSTRAINT DF_FinancialPlanResource_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy             BIGINT NULL,

    CONSTRAINT PK_FinancialPlanResource
        PRIMARY KEY (FinancialPlanId, FinancialResourceId)
);

CREATE TABLE dbo.FinancialPlanItemEvent
(
    FinancialPlanItemId BIGINT NOT NULL,
    FinancialEventId    BIGINT NOT NULL,
    CreatedAt           DATETIME2(3) NOT NULL
        CONSTRAINT DF_FinancialPlanItemEvent_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy           BIGINT NULL,

    CONSTRAINT PK_FinancialPlanItemEvent
        PRIMARY KEY (FinancialPlanItemId, FinancialEventId)
);

COMMIT TRANSACTION;
GO