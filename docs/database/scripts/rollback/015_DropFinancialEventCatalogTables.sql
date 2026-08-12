/*
    BudgetKeep
    Financial Events - Rollback Supporting Catalog Tables

    This script must run only after Financial Events objects have been removed
    and after the RecurrenceType seed has been rolled back.
*/

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

IF OBJECT_ID(N'dbo.RecurrenceType', N'U') IS NOT NULL
    DROP TABLE dbo.RecurrenceType;

IF OBJECT_ID(N'dbo.ExpenseCategory', N'U') IS NOT NULL
    DROP TABLE dbo.ExpenseCategory;

IF OBJECT_ID(N'dbo.IncomeType', N'U') IS NOT NULL
    DROP TABLE dbo.IncomeType;

COMMIT TRANSACTION;
