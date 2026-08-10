/*
    BudgetKeep
    Domain: Financial Resources
    Script: Seed Currency
    Order: 005
*/

SET NOCOUNT ON;
GO

INSERT INTO dbo.Currency
(
    Code,
    Name,
    Symbol,
    IsActive
)
SELECT
    V.Code,
    V.Name,
    V.Symbol,
    V.IsActive
FROM
(
    VALUES
        ('MXN', N'Peso mexicano', N'$', CAST(1 AS BIT)),
        ('USD', N'US Dollar',     N'$', CAST(1 AS BIT)),
        ('EUR', N'Euro',          N'€', CAST(1 AS BIT))
) AS V(Code, Name, Symbol, IsActive)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.Currency C
    WHERE C.Code = V.Code
);
GO