/*
    BudgetKeep
    Financial Events
    Rollback Seed - RecurrenceType

    Removes only the domain-approved seed codes.
    Does not drop the RecurrenceType catalog table.
*/

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

DELETE FROM dbo.RecurrenceType
WHERE Code IN
(
    'MONTHLY_DAY',
    'MONTHLY_15_LAST',
    'WEEKLY_WEEKDAY',
    'BIWEEKLY_WEEKDAY',
    'ANNUAL_DATE'
);

COMMIT TRANSACTION;
