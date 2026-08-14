/*
 BudgetKeep | DB-001 | Financial Obligations
 CREATE - Indexes
*/
SET NOCOUNT ON;

CREATE UNIQUE INDEX UX_FinancialObligationType_OwnerUserId_Code ON dbo.FinancialObligationType(OwnerUserId, Code);
CREATE INDEX IX_FinancialObligationType_OwnerUserId ON dbo.FinancialObligationType(OwnerUserId);
CREATE UNIQUE INDEX UX_DebtType_OwnerUserId_Code ON dbo.DebtType(OwnerUserId, Code);
CREATE INDEX IX_DebtType_OwnerUserId ON dbo.DebtType(OwnerUserId);
CREATE INDEX IX_FinancialPriority_UserId ON dbo.FinancialPriority(UserId);
CREATE UNIQUE INDEX UX_RelatedEntityType_OwnerUserId_Code ON dbo.RelatedEntityType(OwnerUserId, Code);
CREATE INDEX IX_RelatedEntityType_OwnerUserId ON dbo.RelatedEntityType(OwnerUserId);
CREATE INDEX IX_RelatedEntity_UserId ON dbo.RelatedEntity(UserId);
CREATE INDEX IX_RelatedEntity_RelatedEntityTypeId ON dbo.RelatedEntity(RelatedEntityTypeId);
CREATE INDEX IX_Debt_UserId ON dbo.Debt(UserId);
CREATE INDEX IX_Debt_DebtTypeId ON dbo.Debt(DebtTypeId);
CREATE INDEX IX_Debt_RelatedEntityId ON dbo.Debt(RelatedEntityId);
CREATE INDEX IX_Debt_CurrencyId ON dbo.Debt(CurrencyId);
CREATE INDEX IX_FinancialObligation_UserId ON dbo.FinancialObligation(UserId);
CREATE INDEX IX_FinancialObligation_DebtId ON dbo.FinancialObligation(DebtId);
CREATE INDEX IX_FinancialObligation_CurrencyId ON dbo.FinancialObligation(CurrencyId);
CREATE INDEX IX_FinancialObligation_FinancialPriorityId ON dbo.FinancialObligation(FinancialPriorityId);
CREATE INDEX IX_FinancialObligation_DueDate ON dbo.FinancialObligation(DueDate);
CREATE INDEX IX_FinancialObligation_LifecycleStatus ON dbo.FinancialObligation(LifecycleStatus);
CREATE UNIQUE INDEX UX_FinancialObligationRecurrenceConfiguration_FinancialObligationId ON dbo.FinancialObligationRecurrenceConfiguration(FinancialObligationId);
CREATE INDEX IX_FinancialObligationRecurrenceConfiguration_RecurrenceTypeId ON dbo.FinancialObligationRecurrenceConfiguration(RecurrenceTypeId);
CREATE INDEX IX_Payment_UserId ON dbo.Payment(UserId);
CREATE INDEX IX_Payment_FinancialObligationId ON dbo.Payment(FinancialObligationId);
CREATE UNIQUE INDEX UX_Payment_FinancialEventId ON dbo.Payment(FinancialEventId);
CREATE INDEX IX_PaymentResource_PaymentId ON dbo.PaymentResource(PaymentId);
CREATE INDEX IX_PaymentResource_FinancialResourceId ON dbo.PaymentResource(FinancialResourceId);
