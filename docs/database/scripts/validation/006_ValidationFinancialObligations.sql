/*
 BudgetKeep | DB-001 | Financial Obligations
 VALIDATION
*/
SET NOCOUNT ON;

SELECT t.name AS TableName
FROM sys.tables t
WHERE t.name IN
(
 'FinancialObligationType','DebtType','FinancialPriority','RelatedEntityType',
 'RelatedEntity','Debt','FinancialObligation',
 'FinancialObligationRecurrenceConfiguration','Payment','PaymentResource'
)
ORDER BY t.name;

SELECT fk.name AS ForeignKeyName,
       OBJECT_NAME(fk.parent_object_id) AS ChildTable,
       OBJECT_NAME(fk.referenced_object_id) AS ParentTable
FROM sys.foreign_keys fk
WHERE OBJECT_NAME(fk.parent_object_id) IN
(
 'FinancialObligationType','DebtType','FinancialPriority','RelatedEntityType',
 'RelatedEntity','Debt','FinancialObligation',
 'FinancialObligationRecurrenceConfiguration','Payment','PaymentResource'
)
ORDER BY ChildTable, ForeignKeyName;

SELECT OBJECT_NAME(parent_object_id) AS TableName,
       name AS ConstraintName,
       definition
FROM sys.check_constraints
WHERE name IN
(
 'CK_Debt_OutstandingBalance',
 'CK_FinancialObligation_Amount',
 'CK_FinancialObligationRecurrenceConfiguration_DateRange',
 'CK_PaymentResource_AmountUsed',
 'CK_PaymentResource_ExchangeRate',
 'CK_PaymentResource_AppliedAmount'
)
ORDER BY TableName, ConstraintName;

SELECT OBJECT_NAME(i.object_id) AS TableName, i.name AS IndexName, i.is_unique
FROM sys.indexes i
WHERE i.name IN
(
 'UX_FinancialObligationType_OwnerUserId_Code',
 'UX_DebtType_OwnerUserId_Code',
 'UX_RelatedEntityType_OwnerUserId_Code',
 'UX_FinancialObligationRecurrenceConfiguration_FinancialObligationId',
 'UX_Payment_FinancialEventId'
)
ORDER BY TableName, IndexName;

SELECT p.PaymentId, p.FinancialEventId, fe.EventType, fe.EventStatus
FROM dbo.Payment p
JOIN dbo.FinancialEvent fe ON fe.FinancialEventId = p.FinancialEventId
WHERE fe.EventType <> 'EXPENSE'
   OR fe.EventStatus <> 'CONFIRMED';

SELECT PaymentResourceId, AmountUsed, ExchangeRate, AppliedAmount
FROM dbo.PaymentResource
WHERE AmountUsed <= 0
   OR ExchangeRate <= 0
   OR AppliedAmount <= 0;

SELECT FinancialObligationRecurrenceConfigurationId, StartDate, EndDate
FROM dbo.FinancialObligationRecurrenceConfiguration
WHERE EndDate IS NOT NULL
  AND EndDate < StartDate;

SELECT 'FinancialObligation -> Debt owner mismatch' AS CheckName, COUNT(*) AS InvalidRows
FROM dbo.FinancialObligation fo
JOIN dbo.Debt d ON d.DebtId = fo.DebtId
WHERE fo.DebtId IS NOT NULL
  AND fo.UserId <> d.UserId
UNION ALL
SELECT 'Debt -> RelatedEntity owner mismatch', COUNT(*)
FROM dbo.Debt d
JOIN dbo.RelatedEntity re ON re.RelatedEntityId = d.RelatedEntityId
WHERE d.RelatedEntityId IS NOT NULL
  AND d.UserId <> re.UserId
UNION ALL
SELECT 'Payment -> FinancialObligation owner mismatch', COUNT(*)
FROM dbo.Payment p
JOIN dbo.FinancialObligation fo ON fo.FinancialObligationId = p.FinancialObligationId
WHERE p.UserId <> fo.UserId;
