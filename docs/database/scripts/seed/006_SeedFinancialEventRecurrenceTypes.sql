/*
    BudgetKeep
    Financial Events - RecurrenceType Seed
*/

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

INSERT INTO dbo.RecurrenceType
(
    Code,
    Name,
    Description,
    IsActive
)
SELECT
    v.Code,
    v.Name,
    v.Description,
    1
FROM
(
    VALUES
        ('MONTHLY_DAY',
         N'Día específico mensual',
         N'Un día específico de cada mes.'),
        ('MONTHLY_15_LAST',
         N'Día 15 y último día del mes',
         N'Día 15 y último día de cada mes.'),
        ('WEEKLY_WEEKDAY',
         N'Día específico de la semana',
         N'Un día específico de la semana cada semana.'),
        ('BIWEEKLY_WEEKDAY',
         N'Día específico de la semana cada dos semanas',
         N'Un día específico de la semana cada dos semanas, determinado mediante una fecha de referencia.'),
        ('ANNUAL_DATE',
         N'Fecha específica anual',
         N'Una fecha específica de cada año.')
) AS v(Code, Name, Description)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.RecurrenceType rt
    WHERE rt.Code = v.Code
);

COMMIT TRANSACTION;
