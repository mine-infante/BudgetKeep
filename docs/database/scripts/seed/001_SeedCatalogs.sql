/*
BudgetKeep
Domain: Catalogs
Script: 001_SeedCatalogs.sql
Target: Azure SQL Database

Purpose:
Insert the approved initial catalog values for Language and TimeZone.

Prerequisite:
Language and TimeZone tables must already exist.
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

DECLARE @SeedCreatedAt DATETIME2(3) = SYSUTCDATETIME();

INSERT INTO dbo.Language
(
    Code,
    Name,
    IsActive,
    CreatedAt
)
SELECT
    v.Code,
    v.Name,
    1,
    @SeedCreatedAt
FROM
(
    VALUES
        ('en', N'English'),
        ('es', N'Español')
) AS v(Code, Name)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.Language l
    WHERE l.Code = v.Code
);

INSERT INTO dbo.TimeZone
(
    Code,
    Name,
    IsActive,
    CreatedAt
)
SELECT
    v.Code,
    v.Name,
    1,
    @SeedCreatedAt
FROM
(
    VALUES
        ('America/Mexico_City', N'Mexico City'),
        ('UTC', N'Coordinated Universal Time')
) AS v(Code, Name)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.TimeZone tz
    WHERE tz.Code = v.Code
);

COMMIT TRANSACTION;