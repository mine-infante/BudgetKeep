/*
BudgetKeep
Domain: Identity & Security
Script: 003_CreateIndexes.sql
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

CREATE INDEX IX_UserRole_RoleId
    ON dbo.UserRole(RoleId);

CREATE INDEX IX_ModulePermission_PermissionId
    ON dbo.ModulePermission(PermissionId);

CREATE INDEX IX_RolePermission_ModulePermission
    ON dbo.RolePermission(ModuleId, PermissionId);

COMMIT TRANSACTION;
