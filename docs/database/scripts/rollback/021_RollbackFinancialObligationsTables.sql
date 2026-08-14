/*
 BudgetKeep | DB-001 | Financial Obligations
 ROLLBACK - Tables
*/
SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

DROP TABLE IF EXISTS dbo.PaymentResource;
DROP TABLE IF EXISTS dbo.Payment;
DROP TABLE IF EXISTS dbo.FinancialObligationRecurrenceConfiguration;
DROP TABLE IF EXISTS dbo.FinancialObligation;
DROP TABLE IF EXISTS dbo.Debt;
DROP TABLE IF EXISTS dbo.RelatedEntity;
DROP TABLE IF EXISTS dbo.RelatedEntityType;
DROP TABLE IF EXISTS dbo.FinancialPriority;
DROP TABLE IF EXISTS dbo.DebtType;
DROP TABLE IF EXISTS dbo.FinancialObligationType;

COMMIT TRANSACTION;
