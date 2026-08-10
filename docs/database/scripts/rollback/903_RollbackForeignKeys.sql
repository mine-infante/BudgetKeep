/*
BudgetKeep
Domain: Identity & Security
Script: 903_RollbackForeignKeys.sql
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql = @sql +
    N'ALTER TABLE ' +
    QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id)) + N'.' +
    QUOTENAME(OBJECT_NAME(parent_object_id)) +
    N' DROP CONSTRAINT ' + QUOTENAME(name) + N';' + CHAR(13) + CHAR(10)
FROM sys.foreign_keys
WHERE schema_id = SCHEMA_ID('dbo')
  AND parent_object_id IN
  (
      OBJECT_ID('dbo.User'),
      OBJECT_ID('dbo.UserSecurity'),
      OBJECT_ID('dbo.UserPreference'),
      OBJECT_ID('dbo.Role'),
      OBJECT_ID('dbo.Module'),
      OBJECT_ID('dbo.Permission'),
      OBJECT_ID('dbo.ModulePermission'),
      OBJECT_ID('dbo.UserRole'),
      OBJECT_ID('dbo.RolePermission'),
      OBJECT_ID('dbo.SystemConfiguration'),
      OBJECT_ID('dbo.ConfigurationDataType'),
      OBJECT_ID('dbo.Language'),
      OBJECT_ID('dbo.TimeZone')
  );

IF @sql <> N''
    EXEC sys.sp_executesql @sql;

COMMIT TRANSACTION;
