/*
    BudgetKeep
    Financial Events
    Drop Tables
*/

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

DROP TABLE IF EXISTS dbo.FinancialEvent;
DROP TABLE IF EXISTS dbo.RecurrenceConfiguration;
DROP TABLE IF EXISTS dbo.StandAlone;
DROP TABLE IF EXISTS dbo.Expense;
DROP TABLE IF EXISTS dbo.Income;

COMMIT TRANSACTION;
