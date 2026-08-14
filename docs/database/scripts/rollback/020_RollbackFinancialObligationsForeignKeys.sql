/*
 BudgetKeep | DB-001 | Financial Obligations
 ROLLBACK - Foreign Keys
*/
SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

ALTER TABLE dbo.PaymentResource DROP CONSTRAINT IF EXISTS FK_PaymentResource_CreatedBy;
ALTER TABLE dbo.PaymentResource DROP CONSTRAINT IF EXISTS FK_PaymentResource_FinancialResource;
ALTER TABLE dbo.PaymentResource DROP CONSTRAINT IF EXISTS FK_PaymentResource_Payment;
ALTER TABLE dbo.Payment DROP CONSTRAINT IF EXISTS FK_Payment_DeletedBy;
ALTER TABLE dbo.Payment DROP CONSTRAINT IF EXISTS FK_Payment_UpdatedBy;
ALTER TABLE dbo.Payment DROP CONSTRAINT IF EXISTS FK_Payment_CreatedBy;
ALTER TABLE dbo.Payment DROP CONSTRAINT IF EXISTS FK_Payment_FinancialEvent;
ALTER TABLE dbo.Payment DROP CONSTRAINT IF EXISTS FK_Payment_FinancialObligation;
ALTER TABLE dbo.Payment DROP CONSTRAINT IF EXISTS FK_Payment_User;
ALTER TABLE dbo.FinancialObligationRecurrenceConfiguration DROP CONSTRAINT IF EXISTS FK_FinancialObligationRecurrenceConfiguration_DeletedBy;
ALTER TABLE dbo.FinancialObligationRecurrenceConfiguration DROP CONSTRAINT IF EXISTS FK_FinancialObligationRecurrenceConfiguration_UpdatedBy;
ALTER TABLE dbo.FinancialObligationRecurrenceConfiguration DROP CONSTRAINT IF EXISTS FK_FinancialObligationRecurrenceConfiguration_CreatedBy;
ALTER TABLE dbo.FinancialObligationRecurrenceConfiguration DROP CONSTRAINT IF EXISTS FK_FinancialObligationRecurrenceConfiguration_RecurrenceType;
ALTER TABLE dbo.FinancialObligationRecurrenceConfiguration DROP CONSTRAINT IF EXISTS FK_FinancialObligationRecurrenceConfiguration_Obligation;
ALTER TABLE dbo.FinancialObligation DROP CONSTRAINT IF EXISTS FK_FinancialObligation_DeletedBy;
ALTER TABLE dbo.FinancialObligation DROP CONSTRAINT IF EXISTS FK_FinancialObligation_UpdatedBy;
ALTER TABLE dbo.FinancialObligation DROP CONSTRAINT IF EXISTS FK_FinancialObligation_CreatedBy;
ALTER TABLE dbo.FinancialObligation DROP CONSTRAINT IF EXISTS FK_FinancialObligation_Priority;
ALTER TABLE dbo.FinancialObligation DROP CONSTRAINT IF EXISTS FK_FinancialObligation_Currency;
ALTER TABLE dbo.FinancialObligation DROP CONSTRAINT IF EXISTS FK_FinancialObligation_Debt;
ALTER TABLE dbo.FinancialObligation DROP CONSTRAINT IF EXISTS FK_FinancialObligation_Type;
ALTER TABLE dbo.FinancialObligation DROP CONSTRAINT IF EXISTS FK_FinancialObligation_User;
ALTER TABLE dbo.Debt DROP CONSTRAINT IF EXISTS FK_Debt_DeletedBy;
ALTER TABLE dbo.Debt DROP CONSTRAINT IF EXISTS FK_Debt_UpdatedBy;
ALTER TABLE dbo.Debt DROP CONSTRAINT IF EXISTS FK_Debt_CreatedBy;
ALTER TABLE dbo.Debt DROP CONSTRAINT IF EXISTS FK_Debt_Currency;
ALTER TABLE dbo.Debt DROP CONSTRAINT IF EXISTS FK_Debt_RelatedEntity;
ALTER TABLE dbo.Debt DROP CONSTRAINT IF EXISTS FK_Debt_Type;
ALTER TABLE dbo.Debt DROP CONSTRAINT IF EXISTS FK_Debt_User;
ALTER TABLE dbo.RelatedEntity DROP CONSTRAINT IF EXISTS FK_RelatedEntity_DeletedBy;
ALTER TABLE dbo.RelatedEntity DROP CONSTRAINT IF EXISTS FK_RelatedEntity_UpdatedBy;
ALTER TABLE dbo.RelatedEntity DROP CONSTRAINT IF EXISTS FK_RelatedEntity_CreatedBy;
ALTER TABLE dbo.RelatedEntity DROP CONSTRAINT IF EXISTS FK_RelatedEntity_Type;
ALTER TABLE dbo.RelatedEntity DROP CONSTRAINT IF EXISTS FK_RelatedEntity_User;
ALTER TABLE dbo.RelatedEntityType DROP CONSTRAINT IF EXISTS FK_RelatedEntityType_DeletedBy;
ALTER TABLE dbo.RelatedEntityType DROP CONSTRAINT IF EXISTS FK_RelatedEntityType_UpdatedBy;
ALTER TABLE dbo.RelatedEntityType DROP CONSTRAINT IF EXISTS FK_RelatedEntityType_CreatedBy;
ALTER TABLE dbo.RelatedEntityType DROP CONSTRAINT IF EXISTS FK_RelatedEntityType_OwnerUser;
ALTER TABLE dbo.FinancialPriority DROP CONSTRAINT IF EXISTS FK_FinancialPriority_UpdatedBy;
ALTER TABLE dbo.FinancialPriority DROP CONSTRAINT IF EXISTS FK_FinancialPriority_CreatedBy;
ALTER TABLE dbo.FinancialPriority DROP CONSTRAINT IF EXISTS FK_FinancialPriority_User;
ALTER TABLE dbo.DebtType DROP CONSTRAINT IF EXISTS FK_DebtType_DeletedBy;
ALTER TABLE dbo.DebtType DROP CONSTRAINT IF EXISTS FK_DebtType_UpdatedBy;
ALTER TABLE dbo.DebtType DROP CONSTRAINT IF EXISTS FK_DebtType_CreatedBy;
ALTER TABLE dbo.DebtType DROP CONSTRAINT IF EXISTS FK_DebtType_OwnerUser;
ALTER TABLE dbo.FinancialObligationType DROP CONSTRAINT IF EXISTS FK_FinancialObligationType_DeletedBy;
ALTER TABLE dbo.FinancialObligationType DROP CONSTRAINT IF EXISTS FK_FinancialObligationType_UpdatedBy;
ALTER TABLE dbo.FinancialObligationType DROP CONSTRAINT IF EXISTS FK_FinancialObligationType_CreatedBy;
ALTER TABLE dbo.FinancialObligationType DROP CONSTRAINT IF EXISTS FK_FinancialObligationType_OwnerUser;

COMMIT TRANSACTION;
