/*
    BudgetKeep
    Financial Events
    Create Foreign Keys
*/

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

ALTER TABLE dbo.Income ADD CONSTRAINT FK_Income_User
    FOREIGN KEY (UserId) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.Income ADD CONSTRAINT FK_Income_IncomeType
    FOREIGN KEY (IncomeTypeId) REFERENCES dbo.IncomeType(IncomeTypeId);

ALTER TABLE dbo.Income ADD CONSTRAINT FK_Income_Currency
    FOREIGN KEY (CurrencyId) REFERENCES dbo.Currency(CurrencyId);

ALTER TABLE dbo.Income ADD CONSTRAINT FK_Income_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.Income ADD CONSTRAINT FK_Income_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.Income ADD CONSTRAINT FK_Income_DeletedBy
    FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.Expense ADD CONSTRAINT FK_Expense_User
    FOREIGN KEY (UserId) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.Expense ADD CONSTRAINT FK_Expense_ExpenseCategory
    FOREIGN KEY (ExpenseCategoryId) REFERENCES dbo.ExpenseCategory(ExpenseCategoryId);

ALTER TABLE dbo.Expense ADD CONSTRAINT FK_Expense_Currency
    FOREIGN KEY (CurrencyId) REFERENCES dbo.Currency(CurrencyId);

ALTER TABLE dbo.Expense ADD CONSTRAINT FK_Expense_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.Expense ADD CONSTRAINT FK_Expense_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.Expense ADD CONSTRAINT FK_Expense_DeletedBy
    FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.StandAlone ADD CONSTRAINT FK_StandAlone_User
    FOREIGN KEY (UserId) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.StandAlone ADD CONSTRAINT FK_StandAlone_Currency
    FOREIGN KEY (CurrencyId) REFERENCES dbo.Currency(CurrencyId);

ALTER TABLE dbo.StandAlone ADD CONSTRAINT FK_StandAlone_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.StandAlone ADD CONSTRAINT FK_StandAlone_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.StandAlone ADD CONSTRAINT FK_StandAlone_DeletedBy
    FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.RecurrenceConfiguration ADD CONSTRAINT FK_RecurrenceConfiguration_Income
    FOREIGN KEY (IncomeId) REFERENCES dbo.Income(IncomeId);

ALTER TABLE dbo.RecurrenceConfiguration ADD CONSTRAINT FK_RecurrenceConfiguration_Expense
    FOREIGN KEY (ExpenseId) REFERENCES dbo.Expense(ExpenseId);

ALTER TABLE dbo.RecurrenceConfiguration ADD CONSTRAINT FK_RecurrenceConfiguration_RecurrenceType
    FOREIGN KEY (RecurrenceTypeId) REFERENCES dbo.RecurrenceType(RecurrenceTypeId);

ALTER TABLE dbo.RecurrenceConfiguration ADD CONSTRAINT FK_RecurrenceConfiguration_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.RecurrenceConfiguration ADD CONSTRAINT FK_RecurrenceConfiguration_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.RecurrenceConfiguration ADD CONSTRAINT FK_RecurrenceConfiguration_DeletedBy
    FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.FinancialEvent ADD CONSTRAINT FK_FinancialEvent_User
    FOREIGN KEY (UserId) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.FinancialEvent ADD CONSTRAINT FK_FinancialEvent_Income
    FOREIGN KEY (IncomeId) REFERENCES dbo.Income(IncomeId);

ALTER TABLE dbo.FinancialEvent ADD CONSTRAINT FK_FinancialEvent_Expense
    FOREIGN KEY (ExpenseId) REFERENCES dbo.Expense(ExpenseId);

ALTER TABLE dbo.FinancialEvent ADD CONSTRAINT FK_FinancialEvent_StandAlone
    FOREIGN KEY (StandAloneId) REFERENCES dbo.StandAlone(StandAloneId);

ALTER TABLE dbo.FinancialEvent ADD CONSTRAINT FK_FinancialEvent_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.FinancialEvent ADD CONSTRAINT FK_FinancialEvent_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.FinancialEvent ADD CONSTRAINT FK_FinancialEvent_DeletedBy
    FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId);

COMMIT TRANSACTION;
