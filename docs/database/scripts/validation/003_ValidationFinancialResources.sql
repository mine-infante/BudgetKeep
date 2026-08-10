/*
    BudgetKeep
    Domain: Financial Resources
    Script: Validation
    Order: 003
*/

SET NOCOUNT ON;
GO

/* ============================================================
   1. Tables
   ============================================================ */

IF OBJECT_ID(N'dbo.Currency', N'U') IS NULL
    THROW 51001, 'Validation failed: dbo.Currency does not exist.', 1;

IF OBJECT_ID(N'dbo.FinancialResource', N'U') IS NULL
    THROW 51002, 'Validation failed: dbo.FinancialResource does not exist.', 1;


/* ============================================================
   2. Primary Keys
   ============================================================ */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.key_constraints
    WHERE name = N'PK_Currency'
      AND parent_object_id = OBJECT_ID(N'dbo.Currency')
)
    THROW 51003, 'Validation failed: PK_Currency is missing.', 1;

IF NOT EXISTS
(
    SELECT 1
    FROM sys.key_constraints
    WHERE name = N'PK_FinancialResource'
      AND parent_object_id = OBJECT_ID(N'dbo.FinancialResource')
)
    THROW 51004, 'Validation failed: PK_FinancialResource is missing.', 1;


/* ============================================================
   3. Unique Constraint
   ============================================================ */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.key_constraints
    WHERE name = N'UQ_Currency_Code'
      AND parent_object_id = OBJECT_ID(N'dbo.Currency')
)
    THROW 51005, 'Validation failed: UQ_Currency_Code is missing.', 1;


/* ============================================================
   4. Foreign Keys
   ============================================================ */

DECLARE @ExpectedForeignKeys TABLE
(
    ConstraintName SYSNAME
);

INSERT INTO @ExpectedForeignKeys
VALUES
    (N'FK_Currency_CreatedBy_User'),
    (N'FK_Currency_UpdatedBy_User'),
    (N'FK_FinancialResource_User'),
    (N'FK_FinancialResource_Currency'),
    (N'FK_FinancialResource_CreatedBy_User'),
    (N'FK_FinancialResource_UpdatedBy_User'),
    (N'FK_FinancialResource_DeletedBy_User');

IF EXISTS
(
    SELECT 1
    FROM @ExpectedForeignKeys E
    LEFT JOIN sys.foreign_keys F
        ON F.name = E.ConstraintName
    WHERE F.object_id IS NULL
)
    THROW 51006, 'Validation failed: one or more Financial Resources foreign keys are missing.', 1;


/* ============================================================
   5. Secondary Indexes
   ============================================================ */

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_FinancialResource_UserId'
      AND object_id = OBJECT_ID(N'dbo.FinancialResource')
)
    THROW 51007, 'Validation failed: IX_FinancialResource_UserId is missing.', 1;

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_FinancialResource_CurrencyId'
      AND object_id = OBJECT_ID(N'dbo.FinancialResource')
)
    THROW 51008, 'Validation failed: IX_FinancialResource_CurrencyId is missing.', 1;


/* ============================================================
   6. Currency Seed
   ============================================================ */

IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Currency
    WHERE Code = 'MXN'
      AND Name = N'Peso mexicano'
      AND Symbol = N'$'
      AND IsActive = 1
)
    THROW 51009, 'Validation failed: MXN currency seed is missing or incorrect.', 1;

IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Currency
    WHERE Code = 'USD'
      AND Name = N'US Dollar'
      AND Symbol = N'$'
      AND IsActive = 1
)
    THROW 51010, 'Validation failed: USD currency seed is missing or incorrect.', 1;

IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Currency
    WHERE Code = 'EUR'
      AND Name = N'Euro'
      AND Symbol = N'€'
      AND IsActive = 1
)
    THROW 51011, 'Validation failed: EUR currency seed is missing or incorrect.', 1;


/* ============================================================
   7. Final result
   ============================================================ */

SELECT
    'Financial Resources validation completed.' AS ValidationResult;
GO