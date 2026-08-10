/*
    BudgetKeep
    Domain: Financial Resources
    Script: Rollback Secondary Indexes
    Order: 006
*/

SET NOCOUNT ON;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_FinancialResource_CurrencyId'
      AND object_id = OBJECT_ID(N'dbo.FinancialResource')
)
    DROP INDEX IX_FinancialResource_CurrencyId
    ON dbo.FinancialResource;
GO

IF EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_FinancialResource_UserId'
      AND object_id = OBJECT_ID(N'dbo.FinancialResource')
)
    DROP INDEX IX_FinancialResource_UserId
    ON dbo.FinancialResource;
GO