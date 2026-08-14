/*
 BudgetKeep | DB-001 | Financial Obligations
 ROLLBACK - Indexes
*/
SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

DROP INDEX IF EXISTS UX_Payment_FinancialEventId ON dbo.Payment;
DROP INDEX IF EXISTS IX_Payment_FinancialObligationId ON dbo.Payment;
DROP INDEX IF EXISTS IX_Payment_UserId ON dbo.Payment;
DROP INDEX IF EXISTS IX_PaymentResource_FinancialResourceId ON dbo.PaymentResource;
DROP INDEX IF EXISTS IX_PaymentResource_PaymentId ON dbo.PaymentResource;
DROP INDEX IF EXISTS IX_FinancialObligationRecurrenceConfiguration_RecurrenceTypeId ON dbo.FinancialObligationRecurrenceConfiguration;
DROP INDEX IF EXISTS UX_FinancialObligationRecurrenceConfiguration_FinancialObligationId ON dbo.FinancialObligationRecurrenceConfiguration;
DROP INDEX IF EXISTS IX_FinancialObligation_LifecycleStatus ON dbo.FinancialObligation;
DROP INDEX IF EXISTS IX_FinancialObligation_DueDate ON dbo.FinancialObligation;
DROP INDEX IF EXISTS IX_FinancialObligation_FinancialPriorityId ON dbo.FinancialObligation;
DROP INDEX IF EXISTS IX_FinancialObligation_CurrencyId ON dbo.FinancialObligation;
DROP INDEX IF EXISTS IX_FinancialObligation_DebtId ON dbo.FinancialObligation;
DROP INDEX IF EXISTS IX_FinancialObligation_UserId ON dbo.FinancialObligation;
DROP INDEX IF EXISTS IX_Debt_CurrencyId ON dbo.Debt;
DROP INDEX IF EXISTS IX_Debt_RelatedEntityId ON dbo.Debt;
DROP INDEX IF EXISTS IX_Debt_DebtTypeId ON dbo.Debt;
DROP INDEX IF EXISTS IX_Debt_UserId ON dbo.Debt;
DROP INDEX IF EXISTS IX_RelatedEntity_RelatedEntityTypeId ON dbo.RelatedEntity;
DROP INDEX IF EXISTS IX_RelatedEntity_UserId ON dbo.RelatedEntity;
DROP INDEX IF EXISTS IX_RelatedEntityType_OwnerUserId ON dbo.RelatedEntityType;
DROP INDEX IF EXISTS UX_RelatedEntityType_OwnerUserId_Code ON dbo.RelatedEntityType;
DROP INDEX IF EXISTS IX_FinancialPriority_UserId ON dbo.FinancialPriority;
DROP INDEX IF EXISTS IX_DebtType_OwnerUserId ON dbo.DebtType;
DROP INDEX IF EXISTS UX_DebtType_OwnerUserId_Code ON dbo.DebtType;
DROP INDEX IF EXISTS IX_FinancialObligationType_OwnerUserId ON dbo.FinancialObligationType;
DROP INDEX IF EXISTS UX_FinancialObligationType_OwnerUserId_Code ON dbo.FinancialObligationType;

COMMIT TRANSACTION;
