/*
BudgetKeep
Domain: Identity & Security
Script: 004_Seed.sql
Target: Azure SQL Database

Only seed values explicitly defined by the current DDS are included here.
No Role, Module, Permission, Language, TimeZone or User records are invented.
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRANSACTION;

DECLARE @SeedCreatedAt DATETIME2(3) = SYSUTCDATETIME();

INSERT INTO dbo.ConfigurationDataType
(
    Code, Name, Description, IsActive, CreatedAt
)
SELECT v.Code, v.Name, v.Description, 1, @SeedCreatedAt
FROM
(
    VALUES
        ('INT',      N'Integer',  N'Integer configuration value'),
        ('DECIMAL',  N'Decimal', N'Decimal configuration value'),
        ('BOOLEAN',  N'Boolean', N'Boolean configuration value'),
        ('STRING',   N'String',  N'String configuration value'),
        ('DATETIME2',N'DateTime2',N'Date and time configuration value')
) AS v(Code, Name, Description)
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.ConfigurationDataType t
    WHERE t.Code = v.Code
);

INSERT INTO dbo.SystemConfiguration
(
    Code,
    Value,
    ConfigurationDataTypeId,
    Description,
    IsActive,
    CreatedAt
)
SELECT
    v.Code,
    v.Value,
    t.ConfigurationDataTypeId,
    v.Description,
    1,
    @SeedCreatedAt
FROM
(
    VALUES
        ('SECURITY_MAX_FAILED_LOGIN_ATTEMPTS',
         N'5',
         'INT',
         N'Maximum failed login attempts before temporary lockout.'),
        ('SECURITY_LOCKOUT_DURATION_MINUTES',
         N'15',
         'INT',
         N'Duration in minutes of a temporary account lockout.'),
        ('SECURITY_MAX_LOCKOUT_COUNT',
         N'3',
         'INT',
         N'Maximum number of counted lockouts within the security window.'),
        ('SECURITY_LOCKOUT_COUNT_WINDOW_DAYS',
         N'30',
         'INT',
         N'Duration in days of the lockout counting window.')
) AS v(Code, Value, DataTypeCode, Description)
INNER JOIN dbo.ConfigurationDataType t
    ON t.Code = v.DataTypeCode
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.SystemConfiguration c
    WHERE c.Code = v.Code
);

COMMIT TRANSACTION;
