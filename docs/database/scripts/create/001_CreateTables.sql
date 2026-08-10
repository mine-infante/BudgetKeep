/*
BudgetKeep
Domain: Identity & Security
Script: 001_CreateTables.sql
Target: Azure SQL Database
Purpose: Create physical tables only.
Execution: First script. Execute against a clean BudgetKeep database.
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

CREATE TABLE dbo.[User]
(
    UserId BIGINT IDENTITY(1,1) NOT NULL,
    SupportId VARCHAR(32) NOT NULL,
    Username VARCHAR(100) NOT NULL,
    Email VARCHAR(254) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(150) NOT NULL,
    PhoneNumber VARCHAR(30) NOT NULL,
    IsActive BIT NOT NULL
        CONSTRAINT DF_User_IsActive DEFAULT (1),
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_User_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,

    CONSTRAINT PK_User PRIMARY KEY (UserId),
    CONSTRAINT UQ_User_SupportId UNIQUE (SupportId),
    CONSTRAINT UQ_User_Username UNIQUE (Username),
    CONSTRAINT UQ_User_Email UNIQUE (Email)
);

CREATE TABLE dbo.Role
(
    RoleId BIGINT IDENTITY(1,1) NOT NULL,
    Code VARCHAR(50) NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500) NULL,
    IsSystemRole BIT NOT NULL
        CONSTRAINT DF_Role_IsSystemRole DEFAULT (0),
    IsActive BIT NOT NULL
        CONSTRAINT DF_Role_IsActive DEFAULT (1),
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_Role_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,

    CONSTRAINT PK_Role PRIMARY KEY (RoleId),
    CONSTRAINT UQ_Role_Code UNIQUE (Code)
);

CREATE TABLE dbo.Module
(
    ModuleId BIGINT IDENTITY(1,1) NOT NULL,
    Code VARCHAR(50) NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500) NULL,
    IsActive BIT NOT NULL
        CONSTRAINT DF_Module_IsActive DEFAULT (1),
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_Module_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,

    CONSTRAINT PK_Module PRIMARY KEY (ModuleId),
    CONSTRAINT UQ_Module_Code UNIQUE (Code)
);

CREATE TABLE dbo.Permission
(
    PermissionId BIGINT IDENTITY(1,1) NOT NULL,
    Code VARCHAR(50) NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500) NULL,
    IsActive BIT NOT NULL
        CONSTRAINT DF_Permission_IsActive DEFAULT (1),
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_Permission_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,

    CONSTRAINT PK_Permission PRIMARY KEY (PermissionId),
    CONSTRAINT UQ_Permission_Code UNIQUE (Code)
);

CREATE TABLE dbo.ConfigurationDataType
(
    ConfigurationDataTypeId BIGINT IDENTITY(1,1) NOT NULL,
    Code VARCHAR(50) NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500) NULL,
    IsActive BIT NOT NULL
        CONSTRAINT DF_ConfigurationDataType_IsActive DEFAULT (1),
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_ConfigurationDataType_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,

    CONSTRAINT PK_ConfigurationDataType PRIMARY KEY (ConfigurationDataTypeId),
    CONSTRAINT UQ_ConfigurationDataType_Code UNIQUE (Code)
);

CREATE TABLE dbo.Language
(
    LanguageId BIGINT IDENTITY(1,1) NOT NULL,
    Code VARCHAR(50) NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    IsActive BIT NOT NULL
        CONSTRAINT DF_Language_IsActive DEFAULT (1),
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_Language_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,

    CONSTRAINT PK_Language PRIMARY KEY (LanguageId),
    CONSTRAINT UQ_Language_Code UNIQUE (Code)
);

CREATE TABLE dbo.TimeZone
(
    TimeZoneId BIGINT IDENTITY(1,1) NOT NULL,
    Code VARCHAR(50) NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    IsActive BIT NOT NULL
        CONSTRAINT DF_TimeZone_IsActive DEFAULT (1),
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_TimeZone_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,

    CONSTRAINT PK_TimeZone PRIMARY KEY (TimeZoneId),
    CONSTRAINT UQ_TimeZone_Code UNIQUE (Code)
);

CREATE TABLE dbo.UserSecurity
(
    UserId BIGINT NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    FailedLoginAttempts INT NOT NULL
        CONSTRAINT DF_UserSecurity_FailedLoginAttempts DEFAULT (0),
    LockoutUntil DATETIME2(3) NULL,
    LockoutCount INT NOT NULL
        CONSTRAINT DF_UserSecurity_LockoutCount DEFAULT (0),
    LockoutWindowStart DATETIME2(3) NULL,
    LastLoginDate DATETIME2(3) NULL,
    PasswordChangedDate DATETIME2(3) NULL,
    RequiresSupport BIT NOT NULL
        CONSTRAINT DF_UserSecurity_RequiresSupport DEFAULT (0),

    CONSTRAINT PK_UserSecurity PRIMARY KEY (UserId),
    CONSTRAINT CK_UserSecurity_FailedLoginAttempts
        CHECK (FailedLoginAttempts >= 0),
    CONSTRAINT CK_UserSecurity_LockoutCount
        CHECK (LockoutCount >= 0),
    CONSTRAINT CK_UserSecurity_RequiresSupport_LockoutUntil
        CHECK (RequiresSupport = 0 OR LockoutUntil IS NULL)
);

CREATE TABLE dbo.UserPreference
(
    UserId BIGINT NOT NULL,
    PreferredLanguageId BIGINT NOT NULL,
    TimeZoneId BIGINT NOT NULL,
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_UserPreference_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,

    CONSTRAINT PK_UserPreference PRIMARY KEY (UserId)
);

CREATE TABLE dbo.SystemConfiguration
(
    SystemConfigurationId BIGINT IDENTITY(1,1) NOT NULL,
    Code VARCHAR(50) NOT NULL,
    Value NVARCHAR(500) NOT NULL,
    ConfigurationDataTypeId BIGINT NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    IsActive BIT NOT NULL
        CONSTRAINT DF_SystemConfiguration_IsActive DEFAULT (1),
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_SystemConfiguration_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,

    CONSTRAINT PK_SystemConfiguration PRIMARY KEY (SystemConfigurationId),
    CONSTRAINT UQ_SystemConfiguration_Code UNIQUE (Code)
);

CREATE TABLE dbo.ModulePermission
(
    ModuleId BIGINT NOT NULL,
    PermissionId BIGINT NOT NULL,
    IsActive BIT NOT NULL
        CONSTRAINT DF_ModulePermission_IsActive DEFAULT (1),
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_ModulePermission_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,
    DeletedAt DATETIME2(3) NULL,
    DeletedBy BIGINT NULL,

    CONSTRAINT PK_ModulePermission PRIMARY KEY (ModuleId, PermissionId)
);

CREATE TABLE dbo.UserRole
(
    UserId BIGINT NOT NULL,
    RoleId BIGINT NOT NULL,
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_UserRole_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,

    CONSTRAINT PK_UserRole PRIMARY KEY (UserId, RoleId)
);

CREATE TABLE dbo.RolePermission
(
    RoleId BIGINT NOT NULL,
    ModuleId BIGINT NOT NULL,
    PermissionId BIGINT NOT NULL,
    CreatedAt DATETIME2(3) NOT NULL
        CONSTRAINT DF_RolePermission_CreatedAt DEFAULT (SYSUTCDATETIME()),
    CreatedBy BIGINT NULL,
    UpdatedAt DATETIME2(3) NULL,
    UpdatedBy BIGINT NULL,

    CONSTRAINT PK_RolePermission PRIMARY KEY (RoleId, ModuleId, PermissionId)
);

COMMIT TRANSACTION;
