/*
BudgetKeep
DB-001 | Audit
ROLLBACK | Indexes
*/
SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

DROP INDEX IF EXISTS IX_AuditLog_CorrelationId ON dbo.AuditLog;
DROP INDEX IF EXISTS IX_AuditLog_ActionType_OccurredAt ON dbo.AuditLog;
DROP INDEX IF EXISTS IX_AuditLog_EntityName_EntityId_OccurredAt ON dbo.AuditLog;
DROP INDEX IF EXISTS IX_AuditLog_UserId_OccurredAt ON dbo.AuditLog;

COMMIT TRANSACTION;
