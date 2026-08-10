/*
BudgetKeep
Domain: Catalogs
Script: 002_ValidationCatalogs.sql

Purpose:
Validate the physical implementation and approved Seed data
for Language and TimeZone.
*/

SET NOCOUNT ON;

-- Language
SELECT
    LanguageId,
    Code,
    Name,
    IsActive,
    CreatedAt,
    CreatedBy,
    UpdatedAt,
    UpdatedBy
FROM dbo.Language
ORDER BY LanguageId;

-- TimeZone
SELECT
    TimeZoneId,
    Code,
    Name,
    IsActive,
    CreatedAt,
    CreatedBy,
    UpdatedAt,
    UpdatedBy
FROM dbo.TimeZone
ORDER BY TimeZoneId;

-- Expected Seed counts
SELECT
    'Language' AS Catalog,
    COUNT(*) AS ExpectedRows
FROM dbo.Language
WHERE Code IN ('en', 'es')

UNION ALL

SELECT
    'TimeZone',
    COUNT(*)
FROM dbo.TimeZone
WHERE Code IN ('America/Mexico_City', 'UTC');

-- Verify unique codes
SELECT
    'Language duplicate codes' AS CheckName,
    COUNT(*) AS Violations
FROM
(
    SELECT Code
    FROM dbo.Language
    GROUP BY Code
    HAVING COUNT(*) > 1
) d

UNION ALL

SELECT
    'TimeZone duplicate codes',
    COUNT(*)
FROM
(
    SELECT Code
    FROM dbo.TimeZone
    GROUP BY Code
    HAVING COUNT(*) > 1
) d;

PRINT 'Catalogs validation completed.';