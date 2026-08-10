/*
BudgetKeep
Domain: Identity & Security
Script: 902_RollbackIndexes.sql
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

DROP INDEX IF EXISTS IX_RolePermission_ModulePermission ON dbo.RolePermission;
DROP INDEX IF EXISTS IX_ModulePermission_PermissionId ON dbo.ModulePermission;
DROP INDEX IF EXISTS IX_UserRole_RoleId ON dbo.UserRole;

COMMIT TRANSACTION;
