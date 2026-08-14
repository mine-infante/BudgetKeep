/*
BudgetKeep
DB-001 | Audit
ROLLBACK | Foreign Keys
*/
SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

IF EXISTS
(
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_AuditLog_User'
      AND parent_object_id = OBJECT_ID('dbo.AuditLog')
)
BEGIN
    ALTER TABLE dbo.AuditLog
    DROP CONSTRAINT FK_AuditLog_User;
END;

COMMIT TRANSACTION;
