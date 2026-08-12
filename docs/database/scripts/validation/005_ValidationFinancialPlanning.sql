/*
    BudgetKeep
    Domain: Financial Planning
    Script: Validation
    Order: 005

    Purpose:
    Validate the physical implementation and integrity rules
    of the Financial Planning domain.
*/

SET NOCOUNT ON;

------------------------------------------------------------
-- 1. Required tables
------------------------------------------------------------

SELECT
    v.TableName,
    CASE
        WHEN t.object_id IS NOT NULL THEN 'OK'
        ELSE 'MISSING'
    END AS Status
FROM
(
    VALUES
        ('FinancialStrategy'),
        ('FinancialStrategyItem'),
        ('FinancialPlan'),
        ('FinancialPlanItem'),
        ('FinancialPlanStrategy'),
        ('FinancialPlanResource'),
        ('FinancialPlanItemEvent')
) v(TableName)
LEFT JOIN sys.tables t
    ON t.name = v.TableName
    AND SCHEMA_NAME(t.schema_id) = 'dbo'
ORDER BY v.TableName;


------------------------------------------------------------
-- 2. Primary Keys
------------------------------------------------------------

SELECT
    t.name AS TableName,
    kc.name AS ConstraintName,
    kc.type_desc AS ConstraintType
FROM sys.key_constraints kc
INNER JOIN sys.tables t
    ON t.object_id = kc.parent_object_id
WHERE t.schema_id = SCHEMA_ID('dbo')
  AND t.name IN
  (
      'FinancialStrategy',
      'FinancialStrategyItem',
      'FinancialPlan',
      'FinancialPlanItem',
      'FinancialPlanStrategy',
      'FinancialPlanResource',
      'FinancialPlanItemEvent'
  )
ORDER BY
    t.name,
    kc.name;


------------------------------------------------------------
-- 3. Check constraints
------------------------------------------------------------

SELECT
    t.name AS TableName,
    cc.name AS ConstraintName,
    cc.definition
FROM sys.check_constraints cc
INNER JOIN sys.tables t
    ON t.object_id = cc.parent_object_id
WHERE t.schema_id = SCHEMA_ID('dbo')
  AND t.name IN
  (
      'FinancialStrategy',
      'FinancialStrategyItem',
      'FinancialPlan',
      'FinancialPlanItem',
      'FinancialPlanStrategy',
      'FinancialPlanResource',
      'FinancialPlanItemEvent'
  )
ORDER BY
    t.name,
    cc.name;


------------------------------------------------------------
-- 4. Foreign Keys
------------------------------------------------------------

SELECT
    fk.name AS ForeignKeyName,
    OBJECT_NAME(fk.parent_object_id) AS ChildTable,
    OBJECT_NAME(fk.referenced_object_id) AS ParentTable,
    fk.delete_referential_action_desc AS OnDelete,
    fk.update_referential_action_desc AS OnUpdate
FROM sys.foreign_keys fk
WHERE
    (
        OBJECT_SCHEMA_NAME(fk.parent_object_id) = 'dbo'
        AND OBJECT_NAME(fk.parent_object_id) IN
        (
            'FinancialStrategy',
            'FinancialStrategyItem',
            'FinancialPlan',
            'FinancialPlanItem',
            'FinancialPlanStrategy',
            'FinancialPlanResource',
            'FinancialPlanItemEvent'
        )
    )
    OR
    (
        OBJECT_SCHEMA_NAME(fk.referenced_object_id) = 'dbo'
        AND OBJECT_NAME(fk.referenced_object_id) IN
        (
            'FinancialStrategy',
            'FinancialStrategyItem',
            'FinancialPlan',
            'FinancialPlanItem',
            'FinancialPlanStrategy',
            'FinancialPlanResource',
            'FinancialPlanItemEvent'
        )
    )
ORDER BY
    ChildTable,
    ForeignKeyName;


------------------------------------------------------------
-- 5. Secondary indexes
------------------------------------------------------------

SELECT
    OBJECT_NAME(i.object_id) AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    i.is_unique AS IsUnique,
    i.has_filter AS HasFilter,
    i.filter_definition AS FilterDefinition
FROM sys.indexes i
WHERE i.object_id IN
(
    OBJECT_ID('dbo.FinancialStrategy'),
    OBJECT_ID('dbo.FinancialStrategyItem'),
    OBJECT_ID('dbo.FinancialPlan'),
    OBJECT_ID('dbo.FinancialPlanItem'),
    OBJECT_ID('dbo.FinancialPlanStrategy'),
    OBJECT_ID('dbo.FinancialPlanResource'),
    OBJECT_ID('dbo.FinancialPlanItemEvent')
)
  AND i.name IS NOT NULL
ORDER BY
    TableName,
    IndexName;


------------------------------------------------------------
-- 6. Invalid FinancialStrategyItem sequence numbers
------------------------------------------------------------

SELECT
    COUNT(*) AS InvalidFinancialStrategyItemSequenceCount
FROM dbo.FinancialStrategyItem
WHERE SequenceNumber <= 0;


------------------------------------------------------------
-- 7. Duplicate FinancialStrategyItem sequence numbers
------------------------------------------------------------

SELECT
    FinancialStrategyId,
    SequenceNumber,
    COUNT(*) AS DuplicateCount
FROM dbo.FinancialStrategyItem
GROUP BY
    FinancialStrategyId,
    SequenceNumber
HAVING COUNT(*) > 1;


------------------------------------------------------------
-- 8. Invalid FinancialPlan lifecycle status
------------------------------------------------------------

SELECT
    COUNT(*) AS InvalidFinancialPlanLifecycleStatusCount
FROM dbo.FinancialPlan
WHERE LifecycleStatus NOT IN
(
    'ACTIVE',
    'FINALIZED'
);


------------------------------------------------------------
-- 9. Invalid FinancialPlan review dates
------------------------------------------------------------

SELECT
    COUNT(*) AS InvalidFinancialPlanReviewDateCount
FROM dbo.FinancialPlan
WHERE ReviewDate IS NOT NULL
  AND ReviewDate < StartDate;


------------------------------------------------------------
-- 10. Invalid FinancialPlanItem sequence numbers
------------------------------------------------------------

SELECT
    COUNT(*) AS InvalidFinancialPlanItemSequenceCount
FROM dbo.FinancialPlanItem
WHERE SequenceNumber <= 0;


------------------------------------------------------------
-- 11. Duplicate active FinancialPlanItem sequence numbers
------------------------------------------------------------

SELECT
    FinancialPlanId,
    SequenceNumber,
    COUNT(*) AS DuplicateActiveCount
FROM dbo.FinancialPlanItem
WHERE DeletedAt IS NULL
GROUP BY
    FinancialPlanId,
    SequenceNumber
HAVING COUNT(*) > 1;


------------------------------------------------------------
-- 12. Orphan FinancialStrategy rows
------------------------------------------------------------

SELECT
    COUNT(*) AS FinancialStrategyUserOrphanCount
FROM dbo.FinancialStrategy fs
LEFT JOIN dbo.[User] u
    ON u.UserId = fs.UserId
WHERE u.UserId IS NULL;


------------------------------------------------------------
-- 13. Orphan FinancialStrategyItem rows
------------------------------------------------------------

SELECT
    COUNT(*) AS FinancialStrategyItemStrategyOrphanCount
FROM dbo.FinancialStrategyItem fsi
LEFT JOIN dbo.FinancialStrategy fs
    ON fs.FinancialStrategyId = fsi.FinancialStrategyId
WHERE fs.FinancialStrategyId IS NULL;


------------------------------------------------------------
-- 14. Orphan FinancialPlan rows
------------------------------------------------------------

SELECT
    COUNT(*) AS FinancialPlanUserOrphanCount
FROM dbo.FinancialPlan fp
LEFT JOIN dbo.[User] u
    ON u.UserId = fp.UserId
WHERE u.UserId IS NULL;


------------------------------------------------------------
-- 15. Orphan FinancialPlanItem rows
------------------------------------------------------------

SELECT
    COUNT(*) AS FinancialPlanItemPlanOrphanCount
FROM dbo.FinancialPlanItem fpi
LEFT JOIN dbo.FinancialPlan fp
    ON fp.FinancialPlanId = fpi.FinancialPlanId
WHERE fp.FinancialPlanId IS NULL;


------------------------------------------------------------
-- 16. Orphan FinancialPlanStrategy rows
------------------------------------------------------------

SELECT
    COUNT(*) AS FinancialPlanStrategyPlanOrphanCount
FROM dbo.FinancialPlanStrategy fps
LEFT JOIN dbo.FinancialPlan fp
    ON fp.FinancialPlanId = fps.FinancialPlanId
LEFT JOIN dbo.FinancialStrategy fs
    ON fs.FinancialStrategyId = fps.FinancialStrategyId
WHERE fp.FinancialPlanId IS NULL
   OR fs.FinancialStrategyId IS NULL;


------------------------------------------------------------
-- 17. Orphan FinancialPlanResource rows
------------------------------------------------------------

SELECT
    COUNT(*) AS FinancialPlanResourceOrphanCount
FROM dbo.FinancialPlanResource fpr
LEFT JOIN dbo.FinancialPlan fp
    ON fp.FinancialPlanId = fpr.FinancialPlanId
LEFT JOIN dbo.FinancialResource fr
    ON fr.FinancialResourceId = fpr.FinancialResourceId
WHERE fp.FinancialPlanId IS NULL
   OR fr.FinancialResourceId IS NULL;


------------------------------------------------------------
-- 18. Orphan FinancialPlanItemEvent rows
------------------------------------------------------------

SELECT
    COUNT(*) AS FinancialPlanItemEventOrphanCount
FROM dbo.FinancialPlanItemEvent fpie
LEFT JOIN dbo.FinancialPlanItem fpi
    ON fpi.FinancialPlanItemId = fpie.FinancialPlanItemId
LEFT JOIN dbo.FinancialEvent fe
    ON fe.FinancialEventId = fpie.FinancialEventId
WHERE fpi.FinancialPlanItemId IS NULL
   OR fe.FinancialEventId IS NULL;


------------------------------------------------------------
-- 19. FinancialPlanStrategy owner consistency
------------------------------------------------------------

SELECT
    COUNT(*) AS InvalidFinancialPlanStrategyOwnerCount
FROM dbo.FinancialPlanStrategy fps
INNER JOIN dbo.FinancialPlan fp
    ON fp.FinancialPlanId = fps.FinancialPlanId
INNER JOIN dbo.FinancialStrategy fs
    ON fs.FinancialStrategyId = fps.FinancialStrategyId
WHERE fp.UserId <> fs.UserId;


------------------------------------------------------------
-- 20. FinancialPlanResource owner consistency
------------------------------------------------------------

SELECT
    COUNT(*) AS InvalidFinancialPlanResourceOwnerCount
FROM dbo.FinancialPlanResource fpr
INNER JOIN dbo.FinancialPlan fp
    ON fp.FinancialPlanId = fpr.FinancialPlanId
INNER JOIN dbo.FinancialResource fr
    ON fr.FinancialResourceId = fpr.FinancialResourceId
WHERE fp.UserId <> fr.UserId;


------------------------------------------------------------
-- 21. FinancialPlanItemEvent owner consistency
------------------------------------------------------------

SELECT
    COUNT(*) AS InvalidFinancialPlanItemEventOwnerCount
FROM dbo.FinancialPlanItemEvent fpie
INNER JOIN dbo.FinancialPlanItem fpi
    ON fpi.FinancialPlanItemId = fpie.FinancialPlanItemId
INNER JOIN dbo.FinancialPlan fp
    ON fp.FinancialPlanId = fpi.FinancialPlanId
INNER JOIN dbo.FinancialEvent fe
    ON fe.FinancialEventId = fpie.FinancialEventId
WHERE fp.UserId <> fe.UserId;


------------------------------------------------------------
-- 22. FinancialPlanItemEvent must not duplicate relationships
------------------------------------------------------------

SELECT
    FinancialPlanItemId,
    FinancialEventId,
    COUNT(*) AS DuplicateCount
FROM dbo.FinancialPlanItemEvent
GROUP BY
    FinancialPlanItemId,
    FinancialEventId
HAVING COUNT(*) > 1;


------------------------------------------------------------
-- 23. FinancialPlanStrategy must not duplicate relationships
------------------------------------------------------------

SELECT
    FinancialPlanId,
    FinancialStrategyId,
    COUNT(*) AS DuplicateCount
FROM dbo.FinancialPlanStrategy
GROUP BY
    FinancialPlanId,
    FinancialStrategyId
HAVING COUNT(*) > 1;


------------------------------------------------------------
-- 24. FinancialPlanResource must not duplicate relationships
------------------------------------------------------------

SELECT
    FinancialPlanId,
    FinancialResourceId,
    COUNT(*) AS DuplicateCount
FROM dbo.FinancialPlanResource
GROUP BY
    FinancialPlanId,
    FinancialResourceId
HAVING COUNT(*) > 1;