/*
    BudgetKeep
    Financial Events - Validation
    Includes supporting catalog dependencies.
*/

SET NOCOUNT ON;

SELECT
    v.TableName,
    CASE WHEN t.object_id IS NOT NULL THEN 'OK' ELSE 'MISSING' END AS Status
FROM
(
    VALUES
        ('IncomeType'),
        ('ExpenseCategory'),
        ('RecurrenceType'),
        ('Income'),
        ('Expense'),
        ('StandAlone'),
        ('RecurrenceConfiguration'),
        ('FinancialEvent')
) v(TableName)
LEFT JOIN sys.tables t
    ON t.name = v.TableName
    AND SCHEMA_NAME(t.schema_id) = 'dbo'
ORDER BY v.TableName;

SELECT
    rt.Code,
    rt.Name,
    rt.IsActive
FROM dbo.RecurrenceType rt
ORDER BY rt.RecurrenceTypeId;

SELECT
    COUNT(*) AS InvalidFinancialEventSourceCount
FROM dbo.FinancialEvent
WHERE NOT
(
    (IncomeId IS NOT NULL AND ExpenseId IS NULL AND StandAloneId IS NULL)
    OR
    (IncomeId IS NULL AND ExpenseId IS NOT NULL AND StandAloneId IS NULL)
    OR
    (IncomeId IS NULL AND ExpenseId IS NULL AND StandAloneId IS NOT NULL)
);

SELECT
    COUNT(*) AS InvalidFinancialEventStatusCount
FROM dbo.FinancialEvent
WHERE
    (EventStatus = 'EXPECTED'
     AND (ActualDate IS NOT NULL OR ActualAmount IS NOT NULL))
 OR
    (EventStatus = 'CONFIRMED'
     AND (ActualDate IS NULL OR ActualAmount IS NULL));
