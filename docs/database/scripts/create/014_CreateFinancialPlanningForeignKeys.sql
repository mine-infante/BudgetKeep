/*
    BudgetKeep
    Financial Planning
    Create Foreign Keys
*/

SET XACT_ABORT ON;
SET NOCOUNT ON;

BEGIN TRANSACTION;

ALTER TABLE dbo.FinancialStrategy
ADD CONSTRAINT FK_FinancialStrategy_User
    FOREIGN KEY (UserId)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.FinancialStrategy
ADD CONSTRAINT FK_FinancialStrategy_CreatedBy
    FOREIGN KEY (CreatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


ALTER TABLE dbo.FinancialStrategyItem
ADD CONSTRAINT FK_FinancialStrategyItem_FinancialStrategy
    FOREIGN KEY (FinancialStrategyId)
    REFERENCES dbo.FinancialStrategy(FinancialStrategyId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.FinancialStrategyItem
ADD CONSTRAINT FK_FinancialStrategyItem_CreatedBy
    FOREIGN KEY (CreatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


ALTER TABLE dbo.FinancialPlan
ADD CONSTRAINT FK_FinancialPlan_User
    FOREIGN KEY (UserId)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.FinancialPlan
ADD CONSTRAINT FK_FinancialPlan_CreatedBy
    FOREIGN KEY (CreatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.FinancialPlan
ADD CONSTRAINT FK_FinancialPlan_UpdatedBy
    FOREIGN KEY (UpdatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


ALTER TABLE dbo.FinancialPlanItem
ADD CONSTRAINT FK_FinancialPlanItem_FinancialPlan
    FOREIGN KEY (FinancialPlanId)
    REFERENCES dbo.FinancialPlan(FinancialPlanId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.FinancialPlanItem
ADD CONSTRAINT FK_FinancialPlanItem_CreatedBy
    FOREIGN KEY (CreatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.FinancialPlanItem
ADD CONSTRAINT FK_FinancialPlanItem_UpdatedBy
    FOREIGN KEY (UpdatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.FinancialPlanItem
ADD CONSTRAINT FK_FinancialPlanItem_DeletedBy
    FOREIGN KEY (DeletedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


ALTER TABLE dbo.FinancialPlanStrategy
ADD CONSTRAINT FK_FinancialPlanStrategy_FinancialPlan
    FOREIGN KEY (FinancialPlanId)
    REFERENCES dbo.FinancialPlan(FinancialPlanId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.FinancialPlanStrategy
ADD CONSTRAINT FK_FinancialPlanStrategy_FinancialStrategy
    FOREIGN KEY (FinancialStrategyId)
    REFERENCES dbo.FinancialStrategy(FinancialStrategyId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.FinancialPlanStrategy
ADD CONSTRAINT FK_FinancialPlanStrategy_CreatedBy
    FOREIGN KEY (CreatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


ALTER TABLE dbo.FinancialPlanResource
ADD CONSTRAINT FK_FinancialPlanResource_FinancialPlan
    FOREIGN KEY (FinancialPlanId)
    REFERENCES dbo.FinancialPlan(FinancialPlanId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.FinancialPlanResource
ADD CONSTRAINT FK_FinancialPlanResource_FinancialResource
    FOREIGN KEY (FinancialResourceId)
    REFERENCES dbo.FinancialResource(FinancialResourceId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.FinancialPlanResource
ADD CONSTRAINT FK_FinancialPlanResource_CreatedBy
    FOREIGN KEY (CreatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


ALTER TABLE dbo.FinancialPlanItemEvent
ADD CONSTRAINT FK_FinancialPlanItemEvent_FinancialPlanItem
    FOREIGN KEY (FinancialPlanItemId)
    REFERENCES dbo.FinancialPlanItem(FinancialPlanItemId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.FinancialPlanItemEvent
ADD CONSTRAINT FK_FinancialPlanItemEvent_FinancialEvent
    FOREIGN KEY (FinancialEventId)
    REFERENCES dbo.FinancialEvent(FinancialEventId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE dbo.FinancialPlanItemEvent
ADD CONSTRAINT FK_FinancialPlanItemEvent_CreatedBy
    FOREIGN KEY (CreatedBy)
    REFERENCES dbo.[User](UserId)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

COMMIT TRANSACTION;
GO