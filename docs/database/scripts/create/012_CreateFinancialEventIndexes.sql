/*
    BudgetKeep
    Financial Events
    Create Indexes
*/

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

CREATE INDEX IX_Income_UserId ON dbo.Income(UserId);
CREATE INDEX IX_Income_IncomeTypeId ON dbo.Income(IncomeTypeId);
CREATE INDEX IX_Income_CurrencyId ON dbo.Income(CurrencyId);

CREATE INDEX IX_Expense_UserId ON dbo.Expense(UserId);
CREATE INDEX IX_Expense_ExpenseCategoryId ON dbo.Expense(ExpenseCategoryId);
CREATE INDEX IX_Expense_CurrencyId ON dbo.Expense(CurrencyId);

CREATE INDEX IX_StandAlone_UserId ON dbo.StandAlone(UserId);
CREATE INDEX IX_StandAlone_CurrencyId ON dbo.StandAlone(CurrencyId);

CREATE UNIQUE INDEX UQ_RecurrenceConfiguration_IncomeId
    ON dbo.RecurrenceConfiguration(IncomeId)
    WHERE IncomeId IS NOT NULL;

CREATE UNIQUE INDEX UQ_RecurrenceConfiguration_ExpenseId
    ON dbo.RecurrenceConfiguration(ExpenseId)
    WHERE ExpenseId IS NOT NULL;

CREATE INDEX IX_RecurrenceConfiguration_RecurrenceTypeId
    ON dbo.RecurrenceConfiguration(RecurrenceTypeId);

CREATE INDEX IX_FinancialEvent_UserId_ExpectedDate
    ON dbo.FinancialEvent(UserId, ExpectedDate);

CREATE INDEX IX_FinancialEvent_UserId_EventStatus
    ON dbo.FinancialEvent(UserId, EventStatus);

CREATE INDEX IX_FinancialEvent_IncomeId
    ON dbo.FinancialEvent(IncomeId)
    WHERE IncomeId IS NOT NULL;

CREATE INDEX IX_FinancialEvent_ExpenseId
    ON dbo.FinancialEvent(ExpenseId)
    WHERE ExpenseId IS NOT NULL;

CREATE INDEX IX_FinancialEvent_StandAloneId
    ON dbo.FinancialEvent(StandAloneId)
    WHERE StandAloneId IS NOT NULL;

COMMIT TRANSACTION;
