/*
    BudgetKeep
    Financial Events - Supporting Catalog Foreign Keys

    Audit relationships only.
    Functional relationships to Income, Expense and
    RecurrenceConfiguration are created in the Financial Events FK script.
*/

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

ALTER TABLE dbo.IncomeType
ADD CONSTRAINT FK_IncomeType_CreatedBy
    FOREIGN KEY (CreatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.IncomeType
ADD CONSTRAINT FK_IncomeType_UpdatedBy
    FOREIGN KEY (UpdatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.IncomeType
ADD CONSTRAINT FK_IncomeType_DeletedBy
    FOREIGN KEY (DeletedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.ExpenseCategory
ADD CONSTRAINT FK_ExpenseCategory_CreatedBy
    FOREIGN KEY (CreatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.ExpenseCategory
ADD CONSTRAINT FK_ExpenseCategory_UpdatedBy
    FOREIGN KEY (UpdatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.ExpenseCategory
ADD CONSTRAINT FK_ExpenseCategory_DeletedBy
    FOREIGN KEY (DeletedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.RecurrenceType
ADD CONSTRAINT FK_RecurrenceType_CreatedBy
    FOREIGN KEY (CreatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.RecurrenceType
ADD CONSTRAINT FK_RecurrenceType_UpdatedBy
    FOREIGN KEY (UpdatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

COMMIT TRANSACTION;
