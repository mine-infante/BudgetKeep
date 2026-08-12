/*
    BudgetKeep
    Financial Events - Rollback Supporting Catalog Foreign Keys
*/

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

IF OBJECT_ID(N'dbo.IncomeType', N'U') IS NOT NULL
BEGIN
    IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_IncomeType_CreatedBy')
        ALTER TABLE dbo.IncomeType DROP CONSTRAINT FK_IncomeType_CreatedBy;
    IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_IncomeType_UpdatedBy')
        ALTER TABLE dbo.IncomeType DROP CONSTRAINT FK_IncomeType_UpdatedBy;
    IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_IncomeType_DeletedBy')
        ALTER TABLE dbo.IncomeType DROP CONSTRAINT FK_IncomeType_DeletedBy;
END;

IF OBJECT_ID(N'dbo.ExpenseCategory', N'U') IS NOT NULL
BEGIN
    IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_ExpenseCategory_CreatedBy')
        ALTER TABLE dbo.ExpenseCategory DROP CONSTRAINT FK_ExpenseCategory_CreatedBy;
    IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_ExpenseCategory_UpdatedBy')
        ALTER TABLE dbo.ExpenseCategory DROP CONSTRAINT FK_ExpenseCategory_UpdatedBy;
    IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_ExpenseCategory_DeletedBy')
        ALTER TABLE dbo.ExpenseCategory DROP CONSTRAINT FK_ExpenseCategory_DeletedBy;
END;

IF OBJECT_ID(N'dbo.RecurrenceType', N'U') IS NOT NULL
BEGIN
    IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_RecurrenceType_CreatedBy')
        ALTER TABLE dbo.RecurrenceType DROP CONSTRAINT FK_RecurrenceType_CreatedBy;
    IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_RecurrenceType_UpdatedBy')
        ALTER TABLE dbo.RecurrenceType DROP CONSTRAINT FK_RecurrenceType_UpdatedBy;
END;

COMMIT TRANSACTION;
