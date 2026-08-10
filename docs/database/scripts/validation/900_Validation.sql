/*
BudgetKeep
Domain: Identity & Security
Script: 900_Validation.sql

Purpose:
Validate physical structure, constraints, indexes and defined seed data.
Run after scripts 001, 002, 003 and 004.
*/

SET NOCOUNT ON;

-- 1. Tables
SELECT
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables t
INNER JOIN sys.schemas s ON s.schema_id = t.schema_id
WHERE s.name = 'dbo'
  AND t.name IN
  (
      'User','UserSecurity','Role','Module','Permission',
      'ModulePermission','UserRole','RolePermission',
      'UserPreference','SystemConfiguration',
      'ConfigurationDataType','Language','TimeZone'
  )
ORDER BY t.name;

-- 2. Columns
SELECT
    t.name AS TableName,
    c.column_id,
    c.name AS ColumnName,
    ty.name AS DataType,
    CASE
        WHEN ty.name IN ('varchar','nvarchar','char','nchar')
            THEN c.max_length
        ELSE NULL
    END AS MaxLengthBytes,
    c.is_nullable,
    c.is_identity,
    dc.name AS DefaultConstraint
FROM sys.tables t
INNER JOIN sys.columns c ON c.object_id = t.object_id
INNER JOIN sys.types ty ON ty.user_type_id = c.user_type_id
LEFT JOIN sys.default_constraints dc
    ON dc.parent_object_id = c.object_id
   AND dc.parent_column_id = c.column_id
WHERE t.schema_id = SCHEMA_ID('dbo')
  AND t.name IN
  (
      'User','UserSecurity','Role','Module','Permission',
      'ModulePermission','UserRole','RolePermission',
      'UserPreference','SystemConfiguration',
      'ConfigurationDataType','Language','TimeZone'
  )
ORDER BY t.name, c.column_id;

-- 3. Primary / Unique / Check constraints
SELECT
    t.name AS TableName,
    kc.name AS ConstraintName,
    kc.type_desc
FROM sys.key_constraints kc
INNER JOIN sys.tables t ON t.object_id = kc.parent_object_id
WHERE t.schema_id = SCHEMA_ID('dbo')
  AND t.name IN
  (
      'User','UserSecurity','Role','Module','Permission',
      'ModulePermission','UserRole','RolePermission',
      'UserPreference','SystemConfiguration',
      'ConfigurationDataType','Language','TimeZone'
  )
ORDER BY t.name, kc.type_desc, kc.name;

SELECT
    t.name AS TableName,
    cc.name AS ConstraintName,
    cc.definition
FROM sys.check_constraints cc
INNER JOIN sys.tables t ON t.object_id = cc.parent_object_id
WHERE t.schema_id = SCHEMA_ID('dbo')
ORDER BY t.name, cc.name;

-- 4. Foreign Keys
SELECT
    fk.name AS ForeignKeyName,
    OBJECT_NAME(fk.parent_object_id) AS ChildTable,
    OBJECT_NAME(fk.referenced_object_id) AS ParentTable,
    fk.delete_referential_action_desc AS OnDelete,
    fk.update_referential_action_desc AS OnUpdate
FROM sys.foreign_keys fk
WHERE fk.schema_id = SCHEMA_ID('dbo')
ORDER BY ChildTable, ForeignKeyName;

-- 5. Secondary indexes
SELECT
    OBJECT_NAME(i.object_id) AS TableName,
    i.name AS IndexName,
    i.type_desc
FROM sys.indexes i
WHERE i.object_id IN
(
    OBJECT_ID('dbo.UserRole'),
    OBJECT_ID('dbo.ModulePermission'),
    OBJECT_ID('dbo.RolePermission')
)
  AND i.name IS NOT NULL
ORDER BY TableName, IndexName;

-- 6. Defined seed data
SELECT
    Code, Name, IsActive
FROM dbo.ConfigurationDataType
WHERE Code IN ('INT','DECIMAL','BOOLEAN','STRING','DATETIME2')
ORDER BY Code;

SELECT
    Code, Value, IsActive
FROM dbo.SystemConfiguration
WHERE Code IN
(
    'SECURITY_MAX_FAILED_LOGIN_ATTEMPTS',
    'SECURITY_LOCKOUT_DURATION_MINUTES',
    'SECURITY_MAX_LOCKOUT_COUNT',
    'SECURITY_LOCKOUT_COUNT_WINDOW_DAYS'
)
ORDER BY Code;

-- 7. Basic orphan checks
SELECT 'UserSecurity orphan rows' AS CheckName, COUNT(*) AS Violations
FROM dbo.UserSecurity us
LEFT JOIN dbo.[User] u ON u.UserId = us.UserId
WHERE u.UserId IS NULL

UNION ALL

SELECT 'UserPreference orphan rows', COUNT(*)
FROM dbo.UserPreference up
LEFT JOIN dbo.[User] u ON u.UserId = up.UserId
WHERE u.UserId IS NULL

UNION ALL

SELECT 'UserRole orphan rows', COUNT(*)
FROM dbo.UserRole ur
LEFT JOIN dbo.[User] u ON u.UserId = ur.UserId
LEFT JOIN dbo.Role r ON r.RoleId = ur.RoleId
WHERE u.UserId IS NULL OR r.RoleId IS NULL

UNION ALL

SELECT 'RolePermission orphan rows', COUNT(*)
FROM dbo.RolePermission rp
LEFT JOIN dbo.Role r ON r.RoleId = rp.RoleId
LEFT JOIN dbo.ModulePermission mp
    ON mp.ModuleId = rp.ModuleId
   AND mp.PermissionId = rp.PermissionId
WHERE r.RoleId IS NULL OR mp.ModuleId IS NULL;

SELECT
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables t
INNER JOIN sys.schemas s
    ON s.schema_id = t.schema_id
WHERE s.name = 'dbo'
  AND t.name IN
  (
      'User','UserSecurity','Role','Module','Permission',
      'ModulePermission','UserRole','RolePermission',
      'UserPreference','SystemConfiguration',
      'ConfigurationDataType','Language','TimeZone'
  )
ORDER BY t.name;