/*
    BudgetKeep
    Domain: Financial Resources
    Script: Drop Tables
    Order: 008
*/

SET NOCOUNT ON;
GO

IF OBJECT_ID(N'dbo.FinancialResource', N'U') IS NOT NULL
    DROP TABLE dbo.FinancialResource;
GO

IF OBJECT_ID(N'dbo.Currency', N'U') IS NOT NULL
    DROP TABLE dbo.Currency;
GO