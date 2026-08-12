/*
    BudgetKeep
    Financial Events
    Rollback Indexes
*/

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

DROP INDEX IF EXISTS UQ_RecurrenceConfiguration_IncomeId
    ON dbo.RecurrenceConfiguration;

DROP INDEX IF EXISTS UQ_RecurrenceConfiguration_ExpenseId
    ON dbo.RecurrenceConfiguration;

DROP INDEX IF EXISTS IX_RecurrenceConfiguration_RecurrenceTypeId
    ON dbo.RecurrenceConfiguration;

DROP INDEX IF EXISTS IX_FinancialEvent_UserId_ExpectedDate
    ON dbo.FinancialEvent;

DROP INDEX IF EXISTS IX_FinancialEvent_UserId_EventStatus
    ON dbo.FinancialEvent;

DROP INDEX IF EXISTS IX_FinancialEvent_IncomeId
    ON dbo.FinancialEvent;

DROP INDEX IF EXISTS IX_FinancialEvent_ExpenseId
    ON dbo.FinancialEvent;

DROP INDEX IF EXISTS IX_FinancialEvent_StandAloneId
    ON dbo.FinancialEvent;

DROP INDEX IF EXISTS IX_Income_UserId ON dbo.Income;
DROP INDEX IF EXISTS IX_Income_IncomeTypeId ON dbo.Income;
DROP INDEX IF EXISTS IX_Income_CurrencyId ON dbo.Income;

DROP INDEX IF EXISTS IX_Expense_UserId ON dbo.Expense;
DROP INDEX IF EXISTS IX_Expense_ExpenseCategoryId ON dbo.Expense;
DROP INDEX IF EXISTS IX_Expense_CurrencyId ON dbo.Expense;

DROP INDEX IF EXISTS IX_StandAlone_UserId ON dbo.StandAlone;
DROP INDEX IF EXISTS IX_StandAlone_CurrencyId ON dbo.StandAlone;

COMMIT TRANSACTION;
