# BudgetKeep

# Decision Log

**Version:** 1.0

**Status:** Approved

**Classification:** Project Governance Document

**Document ID:** BK-DL-001

**Owner:** Project Office

**Approval Date:** 2026-07-25

---

# Introduction

This document records the strategic decisions that shape the evolution of BudgetKeep.

Its purpose is to preserve the rationale behind the most important product decisions so that future discussions, analyses, designs and implementations remain consistent with the original vision.

Every decision recorded here is considered official unless it is explicitly superseded by a later approved decision.

---

# Decision BK-DEC-001

## Title

BudgetKeep Product Identity

## Status

Approved

## Decision

BudgetKeep is not a money management system.

BudgetKeep is a system designed to reduce financial uncertainty through a reliable representation of the user's financial reality and strategic guidance that helps the user decide the next best step.

## Rationale

The purpose of the product is not to register financial transactions.

Its purpose is to reduce uncertainty and improve decision making.

## Source

Product_Vision_v1.0.md

---

# Decision BK-DEC-002

## Title

Financial Reality Model

## Status

Approved

## Decision

The Financial Reality Model becomes the official business concept that represents the user's financial reality.

All recommendations, analyses and strategic guidance must be based on this model.

## Rationale

The user's trust depends on BudgetKeep representing reality as accurately as possible.

## Source

Product_Vision_v1.0.md

---

# Decision BK-DEC-003

## Title

Artificial Intelligence Role

## Status

Approved

## Decision

Artificial Intelligence recommends.

The user decides.

The AI must never make financial decisions on behalf of the user.

## Rationale

BudgetKeep is an assistant, not a decision maker.

## Source

Product_Vision_v1.0.md

---

# Decision BK-DEC-004

## Title

MVP Focus

## Status

Approved

## Decision

The MVP focuses on helping users recover control of payments and due dates.

Other financial capabilities will be incorporated progressively.

## Rationale

Solving one important problem exceptionally well is preferable to solving many problems poorly.

## Source

Product_Vision_v1.0.md

---

# Decision BK-DEC-005

## Title

Feature Acceptance Rule

## Status

Approved

## Decision

Every new feature proposed for BudgetKeep must contribute directly or indirectly to reducing the user's financial uncertainty.

Features that do not support this objective should not be included in the product.

## Rationale

This rule preserves the identity and strategic focus of BudgetKeep.

## Source

Product_Vision_v1.0.md

---

# Decision BK-DEC-006

## Title

Payment and Financial Obligation Relationship

## Status

Approved

## Decision

A Payment shall attend exactly one Financial Obligation.

A Financial Obligation may receive multiple Payments, allowing partial
payments.

If a single financial operation or transfer of funds is intended to attend
multiple Financial Obligations, a separate Payment shall be registered for
each Financial Obligation attended.

A Transfer between Financial Resources is a distinct financial event and
does not by itself constitute the fulfillment of a Financial Obligation.

## Rationale

BudgetKeep must maintain each Financial Obligation as an independent unit
of control so that the User can determine clearly whether an obligation has
been fully or partially attended, how much has been paid and when the
payment was applied.

Separating Transfers from Payments also preserves the distinction between
moving money between the User's Financial Resources and applying money to
fulfill a Financial Obligation.

This model allows a single Financial Obligation to receive multiple
Payments while avoiding unnecessary many-to-many persistence between
Payments and Financial Obligations.

## Source

User clarification during Database Design — Financial Obligations domain.

---

# Decision BK-DEC-007

## Title

Financial Event Historical Currency and Payment Resource Conversion

## Status

Approved

## Decision

Financial Event shall preserve the Currency of the financial occurrence.

The User's Base Currency is a configurable presentation and analysis
preference and shall not modify the historical currency of financial data.

A Payment shall attend a Financial Obligation in the Currency defined by
that obligation.

A Payment may use one or more Financial Resources, including Resources
with different currencies.

Each Payment Resource allocation shall preserve:

- the amount actually used from the Financial Resource;
- the Currency of the Financial Resource;
- the Exchange Rate actually applied to convert that amount to the Currency
  of the Financial Obligation;
- the resulting amount applied to the Financial Obligation.

The actual Exchange Rate applied to a Payment Resource is historical
financial reality and shall not be recalculated when the User changes the
Base Currency.

Reference Exchange Rates shall be maintained separately for future
Budget, Forecast and presentation purposes and shall never replace the
historical Exchange Rate actually applied to a Payment Resource.

## Rationale

BudgetKeep must preserve the financial reality exactly as it occurred,
independently of the User's current preferred presentation currency.

A Payment may be funded by multiple Financial Resources and those Resources
may use different currencies. Therefore, the conversion belongs to each
Payment Resource allocation rather than to Payment as a single global
conversion.

Separating actual conversion rates from reference exchange rates prevents
historical financial facts from being altered by later changes in currency
preferences or market rates.

## Source

User clarification during Database Design — Financial Obligations domain.

# BK-DEC-008 — Audit History Structure

**Status:** Approved

**Date:** 2026-08-13

## Decision

BudgetKeep will preserve relevant historical and security audit events in a
centralized `AuditLog` structure.

`AuditLog` will identify the affected entity and record through
`EntityName` and `EntityId`.

`AuditLog` will maintain the actor, action type, occurrence timestamp,
correlation identifier, and optional previous/new values and metadata.

`AuditLog` will have a Foreign Key only to `User`.

`AuditLog` will not have Foreign Keys to the business entities being
audited.

`AuditLog` will not replace the operational audit attributes already
present in the business entities, such as `CreatedAt`, `CreatedBy`,
`UpdatedAt`, `UpdatedBy`, `DeletedAt`, and `DeletedBy`.

From the application perspective, `AuditLog` records will be append-only.

## Rationale

A centralized audit structure provides historical traceability across the
solution without creating structural coupling between Audit and every
business entity.

Using `EntityName` and `EntityId` allows the audit mechanism to identify
different types of audited records without introducing polymorphic Foreign
Key relationships into the business data model.

Separating AuditLog from the operational audit attributes preserves the
distinction between the current audit state of a record and its historical
audit trail.

## Impact

The Audit domain introduces:

- `AuditLog`;
- a Foreign Key from `AuditLog.UserId` to `User.UserId`;
- indexes supporting queries by User, entity, action, occurrence time and
  correlation;
- no Foreign Keys from `AuditLog` to audited business entities.

## Source

Database Design decision for the Audit domain.