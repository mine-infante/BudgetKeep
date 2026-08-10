/*
BudgetKeep
Domain: Identity & Security
Script: 002_CreateForeignKeys.sql
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

ALTER TABLE dbo.[User]
ADD CONSTRAINT FK_User_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.[User]
ADD CONSTRAINT FK_User_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.[User]
ADD CONSTRAINT FK_User_DeletedBy
    FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.UserSecurity
ADD CONSTRAINT FK_UserSecurity_User
    FOREIGN KEY (UserId) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.UserPreference
ADD CONSTRAINT FK_UserPreference_User
    FOREIGN KEY (UserId) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.UserPreference
ADD CONSTRAINT FK_UserPreference_Language
    FOREIGN KEY (PreferredLanguageId) REFERENCES dbo.Language(LanguageId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.UserPreference
ADD CONSTRAINT FK_UserPreference_TimeZone
    FOREIGN KEY (TimeZoneId) REFERENCES dbo.TimeZone(TimeZoneId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.SystemConfiguration
ADD CONSTRAINT FK_SystemConfiguration_ConfigurationDataType
    FOREIGN KEY (ConfigurationDataTypeId)
    REFERENCES dbo.ConfigurationDataType(ConfigurationDataTypeId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.ModulePermission
ADD CONSTRAINT FK_ModulePermission_Module
    FOREIGN KEY (ModuleId) REFERENCES dbo.Module(ModuleId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.ModulePermission
ADD CONSTRAINT FK_ModulePermission_Permission
    FOREIGN KEY (PermissionId) REFERENCES dbo.Permission(PermissionId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.UserRole
ADD CONSTRAINT FK_UserRole_User
    FOREIGN KEY (UserId) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.UserRole
ADD CONSTRAINT FK_UserRole_Role
    FOREIGN KEY (RoleId) REFERENCES dbo.Role(RoleId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.RolePermission
ADD CONSTRAINT FK_RolePermission_Role
    FOREIGN KEY (RoleId) REFERENCES dbo.Role(RoleId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.RolePermission
ADD CONSTRAINT FK_RolePermission_ModulePermission
    FOREIGN KEY (ModuleId, PermissionId)
    REFERENCES dbo.ModulePermission(ModuleId, PermissionId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.Role
ADD CONSTRAINT FK_Role_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.Role
ADD CONSTRAINT FK_Role_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.Role
ADD CONSTRAINT FK_Role_DeletedBy
    FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.Module
ADD CONSTRAINT FK_Module_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.Module
ADD CONSTRAINT FK_Module_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.Module
ADD CONSTRAINT FK_Module_DeletedBy
    FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.Permission
ADD CONSTRAINT FK_Permission_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.Permission
ADD CONSTRAINT FK_Permission_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.Permission
ADD CONSTRAINT FK_Permission_DeletedBy
    FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.ModulePermission
ADD CONSTRAINT FK_ModulePermission_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.ModulePermission
ADD CONSTRAINT FK_ModulePermission_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.ModulePermission
ADD CONSTRAINT FK_ModulePermission_DeletedBy
    FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.UserRole
ADD CONSTRAINT FK_UserRole_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.UserRole
ADD CONSTRAINT FK_UserRole_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.RolePermission
ADD CONSTRAINT FK_RolePermission_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.RolePermission
ADD CONSTRAINT FK_RolePermission_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.UserPreference
ADD CONSTRAINT FK_UserPreference_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.UserPreference
ADD CONSTRAINT FK_UserPreference_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.SystemConfiguration
ADD CONSTRAINT FK_SystemConfiguration_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.SystemConfiguration
ADD CONSTRAINT FK_SystemConfiguration_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.ConfigurationDataType
ADD CONSTRAINT FK_ConfigurationDataType_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.ConfigurationDataType
ADD CONSTRAINT FK_ConfigurationDataType_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.Language
ADD CONSTRAINT FK_Language_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.Language
ADD CONSTRAINT FK_Language_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.TimeZone
ADD CONSTRAINT FK_TimeZone_CreatedBy
    FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE dbo.TimeZone
ADD CONSTRAINT FK_TimeZone_UpdatedBy
    FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION ON UPDATE NO ACTION;

COMMIT TRANSACTION;
