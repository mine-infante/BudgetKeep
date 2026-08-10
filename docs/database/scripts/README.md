# BudgetKeep — Identity & Security SQL

Target: Azure SQL Database

## Forward execution

1. `create/001_CreateTables.sql`
2. `create/002_CreateForeignKeys.sql`
3. `create/003_CreateIndexes.sql`
4. `seed/004_Seed.sql`
5. `validation/900_Validation.sql`

## Rollback

Execute only against the intended BudgetKeep database:

1. `rollback/901_RollbackSeed.sql`
2. `rollback/902_RollbackIndexes.sql`
3. `rollback/903_RollbackForeignKeys.sql`
4. `rollback/904_DropTables.sql`

## Seed scope

The current DDS explicitly defines only:
- ConfigurationDataType: INT, DECIMAL, BOOLEAN, STRING, DATETIME2
- SystemConfiguration:
  - SECURITY_MAX_FAILED_LOGIN_ATTEMPTS = 5
  - SECURITY_LOCKOUT_DURATION_MINUTES = 15
  - SECURITY_MAX_LOCKOUT_COUNT = 3
  - SECURITY_LOCKOUT_COUNT_WINDOW_DAYS = 30

No Role, Module, Permission, Language, TimeZone or User seed records are invented by these scripts.

Those records require explicit definition before being added to Seed.
