/*
BudgetKeep
DB-001 | Audit
VALIDATION
*/
SET NOCOUNT ON;

DECLARE @TableExists BIT =
    CASE WHEN OBJECT_ID('dbo.AuditLog', 'U') IS NOT NULL THEN 1 ELSE 0 END;

DECLARE @MissingColumns INT =
(
    SELECT COUNT(*)
    FROM
    (
        VALUES
        ('AuditLogId'), ('UserId'), ('ActionType'), ('EntityName'),
        ('EntityId'), ('OccurredAt'), ('CorrelationId'), ('OldValues'),
        ('NewValues'), ('Metadata')
    ) v(ColumnName)
    LEFT JOIN sys.columns c
        ON c.object_id = OBJECT_ID('dbo.AuditLog')
       AND c.name = v.ColumnName
    WHERE c.column_id IS NULL
);

DECLARE @PrimaryKeyOK BIT =
    CASE WHEN EXISTS
    (
        SELECT 1
        FROM sys.key_constraints
        WHERE parent_object_id = OBJECT_ID('dbo.AuditLog')
          AND name = 'PK_AuditLog'
          AND type = 'PK'
    ) THEN 1 ELSE 0 END;

DECLARE @ForeignKeyOK BIT =
    CASE WHEN EXISTS
    (
        SELECT 1
        FROM sys.foreign_keys fk
        INNER JOIN sys.foreign_key_columns fkc
            ON fkc.constraint_object_id = fk.object_id
        WHERE fk.parent_object_id = OBJECT_ID('dbo.AuditLog')
          AND fk.name = 'FK_AuditLog_User'
          AND fk.referenced_object_id = OBJECT_ID('dbo.[User]')
          AND COL_NAME(fkc.parent_object_id, fkc.parent_column_id) = 'UserId'
          AND COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) = 'UserId'
    ) THEN 1 ELSE 0 END;

DECLARE @UnexpectedForeignKeys INT =
(
    SELECT COUNT(*)
    FROM sys.foreign_keys
    WHERE parent_object_id = OBJECT_ID('dbo.AuditLog')
      AND name <> 'FK_AuditLog_User'
);

DECLARE @IndexesOK BIT =
    CASE WHEN
        EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.AuditLog') AND name = 'IX_AuditLog_UserId_OccurredAt')
        AND EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.AuditLog') AND name = 'IX_AuditLog_EntityName_EntityId_OccurredAt')
        AND EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.AuditLog') AND name = 'IX_AuditLog_ActionType_OccurredAt')
        AND EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.AuditLog') AND name = 'IX_AuditLog_CorrelationId')
      THEN 1 ELSE 0 END;

DECLARE @DefaultOK BIT =
    CASE WHEN EXISTS
    (
        SELECT 1
        FROM sys.default_constraints dc
        INNER JOIN sys.columns c
            ON c.object_id = dc.parent_object_id
           AND c.column_id = dc.parent_column_id
        WHERE dc.parent_object_id = OBJECT_ID('dbo.AuditLog')
          AND c.name = 'OccurredAt'
    ) THEN 1 ELSE 0 END;

SELECT
    CASE
        WHEN @TableExists = 1
         AND @MissingColumns = 0
         AND @PrimaryKeyOK = 1
         AND @ForeignKeyOK = 1
         AND @UnexpectedForeignKeys = 0
         AND @IndexesOK = 1
         AND @DefaultOK = 1
        THEN 'PASS'
        ELSE 'FAIL'
    END AS ValidationStatus;

SELECT
    @TableExists AS AuditLogTableExists,
    @MissingColumns AS MissingColumns,
    CASE WHEN @PrimaryKeyOK = 1 THEN 'PASS' ELSE 'FAIL' END AS PrimaryKeyStatus,
    CASE WHEN @ForeignKeyOK = 1 THEN 'PASS' ELSE 'FAIL' END AS UserForeignKeyStatus,
    @UnexpectedForeignKeys AS UnexpectedForeignKeys,
    CASE WHEN @IndexesOK = 1 THEN 'PASS' ELSE 'FAIL' END AS IndexStatus,
    CASE WHEN @DefaultOK = 1 THEN 'PASS' ELSE 'FAIL' END AS OccurredAtDefaultStatus;

SELECT
    c.column_id,
    c.name AS ColumnName,
    TYPE_NAME(c.user_type_id) AS DataType,
    c.max_length AS MaxLength,
    c.precision,
    c.scale,
    c.is_nullable,
    c.is_identity
FROM sys.columns c
WHERE c.object_id = OBJECT_ID('dbo.AuditLog')
ORDER BY c.column_id;

SELECT
    fk.name AS ForeignKeyName,
    OBJECT_NAME(fk.parent_object_id) AS ChildTable,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS ChildColumn,
    OBJECT_NAME(fk.referenced_object_id) AS ParentTable,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS ParentColumn
FROM sys.foreign_keys fk
INNER JOIN sys.foreign_key_columns fkc
    ON fkc.constraint_object_id = fk.object_id
WHERE fk.parent_object_id = OBJECT_ID('dbo.AuditLog');

SELECT
    i.name AS IndexName,
    i.is_unique,
    i.type_desc
FROM sys.indexes i
WHERE i.object_id = OBJECT_ID('dbo.AuditLog')
  AND i.name IS NOT NULL
ORDER BY i.name;

SELECT COUNT(*) AS InvalidUserReferences
FROM dbo.AuditLog al
LEFT JOIN dbo.[User] u
    ON u.UserId = al.UserId
WHERE al.UserId IS NOT NULL
  AND u.UserId IS NULL;
