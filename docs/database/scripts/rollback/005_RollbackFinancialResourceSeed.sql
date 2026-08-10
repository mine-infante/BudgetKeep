/*
    BudgetKeep
    Domain: Financial Resources
    Script: Rollback Currency Seed
    Order: 005
*/

SET NOCOUNT ON;
GO

DELETE FROM dbo.Currency
WHERE Code IN
(
    'MXN',
    'USD',
    'EUR'
);
GO