/*
    BudgetKeep
    Domain: Financial Planning
    Script: Rollback Tables
    Order: 018
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

DROP TABLE IF EXISTS dbo.FinancialPlanItemEvent;
DROP TABLE IF EXISTS dbo.FinancialPlanResource;
DROP TABLE IF EXISTS dbo.FinancialPlanStrategy;
DROP TABLE IF EXISTS dbo.FinancialPlanItem;
DROP TABLE IF EXISTS dbo.FinancialPlan;
DROP TABLE IF EXISTS dbo.FinancialStrategyItem;
DROP TABLE IF EXISTS dbo.FinancialStrategy;

COMMIT TRANSACTION;
GO