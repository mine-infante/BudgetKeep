/*
    BudgetKeep
    Financial Events - Supporting Catalog Indexes

    The unique constraints on Code already create the required unique
    indexes for these catalog tables.

    No additional nonclustered indexes are required at this stage.
*/

SET NOCOUNT ON;

SELECT
    'Catalog indexes are provided by UQ_*_Code constraints.' AS Result;
