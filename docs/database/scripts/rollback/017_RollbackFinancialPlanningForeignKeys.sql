/*
    BudgetKeep
    Domain: Financial Planning
    Script: Rollback Foreign Keys
    Order: 017
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

ALTER TABLE dbo.FinancialPlanItemEvent
DROP CONSTRAINT IF EXISTS FK_FinancialPlanItemEvent_CreatedBy;

ALTER TABLE dbo.FinancialPlanItemEvent
DROP CONSTRAINT IF EXISTS FK_FinancialPlanItemEvent_FinancialEvent;

ALTER TABLE dbo.FinancialPlanItemEvent
DROP CONSTRAINT IF EXISTS FK_FinancialPlanItemEvent_FinancialPlanItem;


ALTER TABLE dbo.FinancialPlanResource
DROP CONSTRAINT IF EXISTS FK_FinancialPlanResource_CreatedBy;

ALTER TABLE dbo.FinancialPlanResource
DROP CONSTRAINT IF EXISTS FK_FinancialPlanResource_FinancialResource;

ALTER TABLE dbo.FinancialPlanResource
DROP CONSTRAINT IF EXISTS FK_FinancialPlanResource_FinancialPlan;


ALTER TABLE dbo.FinancialPlanStrategy
DROP CONSTRAINT IF EXISTS FK_FinancialPlanStrategy_CreatedBy;

ALTER TABLE dbo.FinancialPlanStrategy
DROP CONSTRAINT IF EXISTS FK_FinancialPlanStrategy_FinancialStrategy;

ALTER TABLE dbo.FinancialPlanStrategy
DROP CONSTRAINT IF EXISTS FK_FinancialPlanStrategy_FinancialPlan;


ALTER TABLE dbo.FinancialPlanItem
DROP CONSTRAINT IF EXISTS FK_FinancialPlanItem_DeletedBy;

ALTER TABLE dbo.FinancialPlanItem
DROP CONSTRAINT IF EXISTS FK_FinancialPlanItem_UpdatedBy;

ALTER TABLE dbo.FinancialPlanItem
DROP CONSTRAINT IF EXISTS FK_FinancialPlanItem_CreatedBy;

ALTER TABLE dbo.FinancialPlanItem
DROP CONSTRAINT IF EXISTS FK_FinancialPlanItem_FinancialPlan;


ALTER TABLE dbo.FinancialPlan
DROP CONSTRAINT IF EXISTS FK_FinancialPlan_UpdatedBy;

ALTER TABLE dbo.FinancialPlan
DROP CONSTRAINT IF EXISTS FK_FinancialPlan_CreatedBy;

ALTER TABLE dbo.FinancialPlan
DROP CONSTRAINT IF EXISTS FK_FinancialPlan_User;


ALTER TABLE dbo.FinancialStrategyItem
DROP CONSTRAINT IF EXISTS FK_FinancialStrategyItem_CreatedBy;

ALTER TABLE dbo.FinancialStrategyItem
DROP CONSTRAINT IF EXISTS FK_FinancialStrategyItem_FinancialStrategy;


ALTER TABLE dbo.FinancialStrategy
DROP CONSTRAINT IF EXISTS FK_FinancialStrategy_CreatedBy;

ALTER TABLE dbo.FinancialStrategy
DROP CONSTRAINT IF EXISTS FK_FinancialStrategy_User;

COMMIT TRANSACTION;
GO