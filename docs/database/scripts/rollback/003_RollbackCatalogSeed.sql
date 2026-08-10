/*
BudgetKeep
Domain: Catalogs
Script: 003_RollbackCatalogSeed.sql

Purpose:
Remove only the approved Catalogs Seed records.

Important:
This script does NOT drop Language or TimeZone tables.
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

DELETE FROM dbo.TimeZone
WHERE Code IN
(
    'America/Mexico_City',
    'UTC'
);

DELETE FROM dbo.Language
WHERE Code IN
(
    'en',
    'es'
);

COMMIT TRANSACTION;