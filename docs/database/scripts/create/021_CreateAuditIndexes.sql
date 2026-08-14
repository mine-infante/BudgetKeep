/*
BudgetKeep
DB-001 | Audit
CREATE | Indexes
*/
SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

CREATE INDEX IX_AuditLog_UserId_OccurredAt
    ON dbo.AuditLog (UserId, OccurredAt);

CREATE INDEX IX_AuditLog_EntityName_EntityId_OccurredAt
    ON dbo.AuditLog (EntityName, EntityId, OccurredAt);

CREATE INDEX IX_AuditLog_ActionType_OccurredAt
    ON dbo.AuditLog (ActionType, OccurredAt);

CREATE INDEX IX_AuditLog_CorrelationId
    ON dbo.AuditLog (CorrelationId);

COMMIT TRANSACTION;
