/*
BudgetKeep
Domain: Identity & Security
Script: 904_DropTables.sql

Execute only after 901, 902 and 903.
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

DROP TABLE IF EXISTS dbo.RolePermission;
DROP TABLE IF EXISTS dbo.UserRole;
DROP TABLE IF EXISTS dbo.ModulePermission;
DROP TABLE IF EXISTS dbo.SystemConfiguration;
DROP TABLE IF EXISTS dbo.UserPreference;
DROP TABLE IF EXISTS dbo.UserSecurity;
DROP TABLE IF EXISTS dbo.TimeZone;
DROP TABLE IF EXISTS dbo.Language;
DROP TABLE IF EXISTS dbo.ConfigurationDataType;
DROP TABLE IF EXISTS dbo.Permission;
DROP TABLE IF EXISTS dbo.Module;
DROP TABLE IF EXISTS dbo.Role;
DROP TABLE IF EXISTS dbo.[User];

COMMIT TRANSACTION;
