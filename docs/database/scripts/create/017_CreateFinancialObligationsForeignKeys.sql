/*
 BudgetKeep | DB-001 | Financial Obligations
 CREATE - Foreign Keys
*/
SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

ALTER TABLE dbo.FinancialObligationType ADD CONSTRAINT FK_FinancialObligationType_OwnerUser FOREIGN KEY (OwnerUserId) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.FinancialObligationType ADD CONSTRAINT FK_FinancialObligationType_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.FinancialObligationType ADD CONSTRAINT FK_FinancialObligationType_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.FinancialObligationType ADD CONSTRAINT FK_FinancialObligationType_DeletedBy FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.DebtType ADD CONSTRAINT FK_DebtType_OwnerUser FOREIGN KEY (OwnerUserId) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.DebtType ADD CONSTRAINT FK_DebtType_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.DebtType ADD CONSTRAINT FK_DebtType_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.DebtType ADD CONSTRAINT FK_DebtType_DeletedBy FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.FinancialPriority ADD CONSTRAINT FK_FinancialPriority_User FOREIGN KEY (UserId) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.FinancialPriority ADD CONSTRAINT FK_FinancialPriority_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.FinancialPriority ADD CONSTRAINT FK_FinancialPriority_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.RelatedEntityType ADD CONSTRAINT FK_RelatedEntityType_OwnerUser FOREIGN KEY (OwnerUserId) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.RelatedEntityType ADD CONSTRAINT FK_RelatedEntityType_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.RelatedEntityType ADD CONSTRAINT FK_RelatedEntityType_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.RelatedEntityType ADD CONSTRAINT FK_RelatedEntityType_DeletedBy FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.RelatedEntity ADD CONSTRAINT FK_RelatedEntity_User FOREIGN KEY (UserId) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.RelatedEntity ADD CONSTRAINT FK_RelatedEntity_Type FOREIGN KEY (RelatedEntityTypeId) REFERENCES dbo.RelatedEntityType(RelatedEntityTypeId);
ALTER TABLE dbo.RelatedEntity ADD CONSTRAINT FK_RelatedEntity_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.RelatedEntity ADD CONSTRAINT FK_RelatedEntity_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.RelatedEntity ADD CONSTRAINT FK_RelatedEntity_DeletedBy FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.Debt ADD CONSTRAINT FK_Debt_User FOREIGN KEY (UserId) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.Debt ADD CONSTRAINT FK_Debt_Type FOREIGN KEY (DebtTypeId) REFERENCES dbo.DebtType(DebtTypeId);
ALTER TABLE dbo.Debt ADD CONSTRAINT FK_Debt_RelatedEntity FOREIGN KEY (RelatedEntityId) REFERENCES dbo.RelatedEntity(RelatedEntityId);
ALTER TABLE dbo.Debt ADD CONSTRAINT FK_Debt_Currency FOREIGN KEY (CurrencyId) REFERENCES dbo.Currency(CurrencyId);
ALTER TABLE dbo.Debt ADD CONSTRAINT FK_Debt_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.Debt ADD CONSTRAINT FK_Debt_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.Debt ADD CONSTRAINT FK_Debt_DeletedBy FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.FinancialObligation ADD CONSTRAINT FK_FinancialObligation_User FOREIGN KEY (UserId) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.FinancialObligation ADD CONSTRAINT FK_FinancialObligation_Type FOREIGN KEY (FinancialObligationTypeId) REFERENCES dbo.FinancialObligationType(FinancialObligationTypeId);
ALTER TABLE dbo.FinancialObligation ADD CONSTRAINT FK_FinancialObligation_Debt FOREIGN KEY (DebtId) REFERENCES dbo.Debt(DebtId);
ALTER TABLE dbo.FinancialObligation ADD CONSTRAINT FK_FinancialObligation_Currency FOREIGN KEY (CurrencyId) REFERENCES dbo.Currency(CurrencyId);
ALTER TABLE dbo.FinancialObligation ADD CONSTRAINT FK_FinancialObligation_Priority FOREIGN KEY (FinancialPriorityId) REFERENCES dbo.FinancialPriority(FinancialPriorityId);
ALTER TABLE dbo.FinancialObligation ADD CONSTRAINT FK_FinancialObligation_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.FinancialObligation ADD CONSTRAINT FK_FinancialObligation_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.FinancialObligation ADD CONSTRAINT FK_FinancialObligation_DeletedBy FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.FinancialObligationRecurrenceConfiguration ADD CONSTRAINT FK_FinancialObligationRecurrenceConfiguration_Obligation FOREIGN KEY (FinancialObligationId) REFERENCES dbo.FinancialObligation(FinancialObligationId);
ALTER TABLE dbo.FinancialObligationRecurrenceConfiguration ADD CONSTRAINT FK_FinancialObligationRecurrenceConfiguration_RecurrenceType FOREIGN KEY (RecurrenceTypeId) REFERENCES dbo.RecurrenceType(RecurrenceTypeId);
ALTER TABLE dbo.FinancialObligationRecurrenceConfiguration ADD CONSTRAINT FK_FinancialObligationRecurrenceConfiguration_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.FinancialObligationRecurrenceConfiguration ADD CONSTRAINT FK_FinancialObligationRecurrenceConfiguration_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.FinancialObligationRecurrenceConfiguration ADD CONSTRAINT FK_FinancialObligationRecurrenceConfiguration_DeletedBy FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.Payment ADD CONSTRAINT FK_Payment_User FOREIGN KEY (UserId) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.Payment ADD CONSTRAINT FK_Payment_FinancialObligation FOREIGN KEY (FinancialObligationId) REFERENCES dbo.FinancialObligation(FinancialObligationId);
ALTER TABLE dbo.Payment ADD CONSTRAINT FK_Payment_FinancialEvent FOREIGN KEY (FinancialEventId) REFERENCES dbo.FinancialEvent(FinancialEventId);
ALTER TABLE dbo.Payment ADD CONSTRAINT FK_Payment_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.Payment ADD CONSTRAINT FK_Payment_UpdatedBy FOREIGN KEY (UpdatedBy) REFERENCES dbo.[User](UserId);
ALTER TABLE dbo.Payment ADD CONSTRAINT FK_Payment_DeletedBy FOREIGN KEY (DeletedBy) REFERENCES dbo.[User](UserId);

ALTER TABLE dbo.PaymentResource ADD CONSTRAINT FK_PaymentResource_Payment FOREIGN KEY (PaymentId) REFERENCES dbo.Payment(PaymentId);
ALTER TABLE dbo.PaymentResource ADD CONSTRAINT FK_PaymentResource_FinancialResource FOREIGN KEY (FinancialResourceId) REFERENCES dbo.FinancialResource(FinancialResourceId);
ALTER TABLE dbo.PaymentResource ADD CONSTRAINT FK_PaymentResource_CreatedBy FOREIGN KEY (CreatedBy) REFERENCES dbo.[User](UserId);

COMMIT TRANSACTION;
