/*
    BudgetKeep
    Domain: Financial Planning
    Script: Rollback Indexes
    Order: 016
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

DROP INDEX IF EXISTS UX_FinancialStrategyItem_Strategy_SequenceNumber
    ON dbo.FinancialStrategyItem;

DROP INDEX IF EXISTS IX_FinancialStrategy_UserId
    ON dbo.FinancialStrategy;

DROP INDEX IF EXISTS UX_FinancialPlanItem_Plan_SequenceNumber_Active
    ON dbo.FinancialPlanItem;

DROP INDEX IF EXISTS IX_FinancialStrategyItem_FinancialStrategyId
    ON dbo.FinancialStrategyItem;

DROP INDEX IF EXISTS IX_FinancialPlan_UserId
    ON dbo.FinancialPlan;

DROP INDEX IF EXISTS IX_FinancialPlan_LifecycleStatus
    ON dbo.FinancialPlan;

DROP INDEX IF EXISTS IX_FinancialPlanItem_FinancialPlanId
    ON dbo.FinancialPlanItem;

DROP INDEX IF EXISTS IX_FinancialPlanStrategy_FinancialStrategyId
    ON dbo.FinancialPlanStrategy;

DROP INDEX IF EXISTS IX_FinancialPlanResource_FinancialResourceId
    ON dbo.FinancialPlanResource;

DROP INDEX IF EXISTS IX_FinancialPlanItemEvent_FinancialEventId
    ON dbo.FinancialPlanItemEvent;

COMMIT TRANSACTION;
GO