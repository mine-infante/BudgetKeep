/*
    BudgetKeep
    Domain: Financial Planning
    Script: Create Indexes
    Order: 015
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

CREATE UNIQUE INDEX UX_FinancialStrategyItem_Strategy_SequenceNumber
    ON dbo.FinancialStrategyItem
    (
        FinancialStrategyId,
        SequenceNumber
    );

CREATE INDEX IX_FinancialStrategy_UserId
    ON dbo.FinancialStrategy
    (
        UserId
    );


CREATE UNIQUE INDEX UX_FinancialPlanItem_Plan_SequenceNumber_Active
    ON dbo.FinancialPlanItem
    (
        FinancialPlanId,
        SequenceNumber
    )
    WHERE DeletedAt IS NULL;

CREATE INDEX IX_FinancialStrategyItem_FinancialStrategyId
    ON dbo.FinancialStrategyItem
    (
        FinancialStrategyId
    );


CREATE INDEX IX_FinancialPlan_UserId
    ON dbo.FinancialPlan
    (
        UserId
    );

CREATE INDEX IX_FinancialPlan_LifecycleStatus
    ON dbo.FinancialPlan
    (
        LifecycleStatus
    );

CREATE INDEX IX_FinancialPlanItem_FinancialPlanId
    ON dbo.FinancialPlanItem
    (
        FinancialPlanId
    );


CREATE INDEX IX_FinancialPlanStrategy_FinancialStrategyId
    ON dbo.FinancialPlanStrategy
    (
        FinancialStrategyId
    );


CREATE INDEX IX_FinancialPlanResource_FinancialResourceId
    ON dbo.FinancialPlanResource
    (
        FinancialResourceId
    );


CREATE INDEX IX_FinancialPlanItemEvent_FinancialEventId
    ON dbo.FinancialPlanItemEvent
    (
        FinancialEventId
    );

COMMIT TRANSACTION;
GO