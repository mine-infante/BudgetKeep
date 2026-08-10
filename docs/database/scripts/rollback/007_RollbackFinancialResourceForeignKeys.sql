/*
    BudgetKeep
    Domain: Financial Resources
    Script: Rollback Foreign Keys
    Order: 007
*/

SET NOCOUNT ON;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_FinancialResource_DeletedBy_User'
)
    ALTER TABLE dbo.FinancialResource
    DROP CONSTRAINT FK_FinancialResource_DeletedBy_User;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_FinancialResource_UpdatedBy_User'
)
    ALTER TABLE dbo.FinancialResource
    DROP CONSTRAINT FK_FinancialResource_UpdatedBy_User;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_FinancialResource_CreatedBy_User'
)
    ALTER TABLE dbo.FinancialResource
    DROP CONSTRAINT FK_FinancialResource_CreatedBy_User;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_FinancialResource_Currency'
)
    ALTER TABLE dbo.FinancialResource
    DROP CONSTRAINT FK_FinancialResource_Currency;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_FinancialResource_User'
)
    ALTER TABLE dbo.FinancialResource
    DROP CONSTRAINT FK_FinancialResource_User;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_Currency_UpdatedBy_User'
)
    ALTER TABLE dbo.Currency
    DROP CONSTRAINT FK_Currency_UpdatedBy_User;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = N'FK_Currency_CreatedBy_User'
)
    ALTER TABLE dbo.Currency
    DROP CONSTRAINT FK_Currency_CreatedBy_User;
GO