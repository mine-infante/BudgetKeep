/*
    BudgetKeep
    Domain: Financial Resources
    Script: Create Secondary Indexes
    Order: 006
*/

SET NOCOUNT ON;
GO

CREATE INDEX IX_FinancialResource_UserId
    ON dbo.FinancialResource(UserId);
GO

CREATE INDEX IX_FinancialResource_CurrencyId
    ON dbo.FinancialResource(CurrencyId);
GO