/*
    BudgetKeep
    Financial Events
    Rollback Foreign Keys
*/

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

ALTER TABLE dbo.FinancialEvent DROP CONSTRAINT IF EXISTS FK_FinancialEvent_DeletedBy;
ALTER TABLE dbo.FinancialEvent DROP CONSTRAINT IF EXISTS FK_FinancialEvent_UpdatedBy;
ALTER TABLE dbo.FinancialEvent DROP CONSTRAINT IF EXISTS FK_FinancialEvent_CreatedBy;
ALTER TABLE dbo.FinancialEvent DROP CONSTRAINT IF EXISTS FK_FinancialEvent_StandAlone;
ALTER TABLE dbo.FinancialEvent DROP CONSTRAINT IF EXISTS FK_FinancialEvent_Expense;
ALTER TABLE dbo.FinancialEvent DROP CONSTRAINT IF EXISTS FK_FinancialEvent_Income;
ALTER TABLE dbo.FinancialEvent DROP CONSTRAINT IF EXISTS FK_FinancialEvent_User;

ALTER TABLE dbo.RecurrenceConfiguration DROP CONSTRAINT IF EXISTS FK_RecurrenceConfiguration_DeletedBy;
ALTER TABLE dbo.RecurrenceConfiguration DROP CONSTRAINT IF EXISTS FK_RecurrenceConfiguration_UpdatedBy;
ALTER TABLE dbo.RecurrenceConfiguration DROP CONSTRAINT IF EXISTS FK_RecurrenceConfiguration_CreatedBy;
ALTER TABLE dbo.RecurrenceConfiguration DROP CONSTRAINT IF EXISTS FK_RecurrenceConfiguration_RecurrenceType;
ALTER TABLE dbo.RecurrenceConfiguration DROP CONSTRAINT IF EXISTS FK_RecurrenceConfiguration_Expense;
ALTER TABLE dbo.RecurrenceConfiguration DROP CONSTRAINT IF EXISTS FK_RecurrenceConfiguration_Income;

ALTER TABLE dbo.StandAlone DROP CONSTRAINT IF EXISTS FK_StandAlone_DeletedBy;
ALTER TABLE dbo.StandAlone DROP CONSTRAINT IF EXISTS FK_StandAlone_UpdatedBy;
ALTER TABLE dbo.StandAlone DROP CONSTRAINT IF EXISTS FK_StandAlone_CreatedBy;
ALTER TABLE dbo.StandAlone DROP CONSTRAINT IF EXISTS FK_StandAlone_Currency;
ALTER TABLE dbo.StandAlone DROP CONSTRAINT IF EXISTS FK_StandAlone_User;

ALTER TABLE dbo.Expense DROP CONSTRAINT IF EXISTS FK_Expense_DeletedBy;
ALTER TABLE dbo.Expense DROP CONSTRAINT IF EXISTS FK_Expense_UpdatedBy;
ALTER TABLE dbo.Expense DROP CONSTRAINT IF EXISTS FK_Expense_CreatedBy;
ALTER TABLE dbo.Expense DROP CONSTRAINT IF EXISTS FK_Expense_Currency;
ALTER TABLE dbo.Expense DROP CONSTRAINT IF EXISTS FK_Expense_ExpenseCategory;
ALTER TABLE dbo.Expense DROP CONSTRAINT IF EXISTS FK_Expense_User;

ALTER TABLE dbo.Income DROP CONSTRAINT IF EXISTS FK_Income_DeletedBy;
ALTER TABLE dbo.Income DROP CONSTRAINT IF EXISTS FK_Income_UpdatedBy;
ALTER TABLE dbo.Income DROP CONSTRAINT IF EXISTS FK_Income_CreatedBy;
ALTER TABLE dbo.Income DROP CONSTRAINT IF EXISTS FK_Income_Currency;
ALTER TABLE dbo.Income DROP CONSTRAINT IF EXISTS FK_Income_IncomeType;
ALTER TABLE dbo.Income DROP CONSTRAINT IF EXISTS FK_Income_User;

COMMIT TRANSACTION;
