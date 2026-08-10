/*
    BudgetKeep
    Domain: Financial Resources
    Script: Create Foreign Keys
    Order: 005
*/

SET NOCOUNT ON;
GO

ALTER TABLE dbo.Currency
ADD CONSTRAINT FK_Currency_CreatedBy_User
    FOREIGN KEY (CreatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.Currency
ADD CONSTRAINT FK_Currency_UpdatedBy_User
    FOREIGN KEY (UpdatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.FinancialResource
ADD CONSTRAINT FK_FinancialResource_User
    FOREIGN KEY (UserId)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.FinancialResource
ADD CONSTRAINT FK_FinancialResource_Currency
    FOREIGN KEY (CurrencyId)
    REFERENCES dbo.Currency(CurrencyId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.FinancialResource
ADD CONSTRAINT FK_FinancialResource_CreatedBy_User
    FOREIGN KEY (CreatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.FinancialResource
ADD CONSTRAINT FK_FinancialResource_UpdatedBy_User
    FOREIGN KEY (UpdatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.FinancialResource
ADD CONSTRAINT FK_FinancialResource_DeletedBy_User
    FOREIGN KEY (DeletedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
GO