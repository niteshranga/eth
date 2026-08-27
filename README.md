## 📌 Project Overview

An analytics engineering project built with **dbt Core and Snowflake** to transform Ethereum blockchain data into trusted, analytics-ready models for transaction activity, token transfers, smart-contract analysis, stablecoin monitoring, and fraud investigation.

The project is designed around a modular dbt workflow: raw blockchain tables are standardized through staging models, enriched for analytical use cases, and materialized into dedicated analytics and fraud marts.

<p align="center">
  <img src="https://raw.githubusercontent.com/niteshranga/nr-analytics/main/img/etherium_blockchain.png" alt="Ethereum Blockchain Analytics — dbt and Snowflake data engineering project" width="100%">
</p>

Ethereum blockchain data is highly relational but has domain-specific behavior that differs from conventional business data.

A single Ethereum transaction can transfer ETH, interact with a smart contract, and trigger multiple token-transfer events. The project therefore models three core blockchain entities:

- **Transactions** — Ethereum transactions recorded on the blockchain.
- **Token Transfers** — ERC-20 token movement events associated with transactions.
- **Contracts** — Smart contracts deployed and interacted with on Ethereum.

The dbt project converts these source tables into reusable models for:

- Daily Ethereum activity analysis
- Transaction and wallet activity
- Token-transfer analysis
- Stablecoin activity monitoring
- Smart-contract analytics
- Fraud investigation and confirmed-fraud analysis

The project also incorporates dbt testing, reusable macros, seeds, CI/CD workflows, and environment-specific schema management.

## 🎯 Project Goals

The project demonstrates practical analytics engineering capabilities through:

1. **Model blockchain-native data**
   - Represent relationships between transactions, token transfers, and smart contracts.
   - Preserve the one-to-many relationship between a transaction and its associated token-transfer events.

2. **Build modular dbt transformations**
   - Separate base/staging logic from analytical models.
   - Create reusable enriched models for downstream use cases.

3. **Create analytics-ready marts**
   - Produce daily Ethereum activity metrics.
   - Analyze stablecoin activity.
   - Support wallet and token-transfer analysis.
   - Create dedicated fraud-analysis outputs.

4. **Implement data quality controls**
   - Schema and column-level tests.
   - Relationship validation.
   - Accepted-value validation.
   - Positive-value assertions.
   - Singular SQL tests.

5. **Automate the dbt workflow**
   - Use GitHub Actions for CI/CD.
   - Validate changes before deployment.
   - Automate deployment and environment cleanup workflows.

6. **Make the project maintainable**
   - Reusable Jinja/dbt macros.
   - Source definitions and model documentation.
   - Package management.
   - Environment-aware schema generation.

## 🔑 Key Features

### 1. Blockchain-Native Data Modeling

The project explicitly models the relationship between:

```text
Ethereum Transaction
        │
        ├───────────────┐
        │               │
        ▼               ▼
Smart Contract     Token Transfers
                        │
                        ├── Token
                        ├── Sender
                        ├── Receiver
                        └── Transfer Value
```

A single transaction can generate multiple token-transfer events, making the transaction hash a critical relationship key for analytical modeling.

### 2. Modular dbt Model Layers

The project separates transformations into:

```text
Raw Blockchain Tables
        ↓
Base / Staging Models
        ↓
Enriched Analytical Models
        ↓
Analytics Marts
        ↓
Fraud Marts
```

Core staging models include:

- `stg_transactions.sql`
- `stg_token_transfers.sql`
- `stg_contracts.sql`

An enriched transaction model is also used for downstream analytics:

- `transactions_enriched.sql`

### 3. Ethereum Activity Analytics

The analytics layer includes:

- `eth_activity_per_day.sql`
- `stablecoin_activity_per_day.sql`

These models support analysis of blockchain activity over time and provide a foundation for monitoring token and network behavior.

### 4. Stablecoin Analytics

A dedicated stablecoin seed is maintained in:

```text
seeds/
└── stablecoins.csv
```

This allows token classification to be maintained separately from transformation logic and reused by downstream stablecoin models.

### 5. Fraud Detection

The project contains a dedicated fraud modeling path:

```text
models/
├── staging/
│   └── fraud/
│       └── stg_fraud.sql
│
└── marts/
    └── fraud/
        └── confirmed_frauds.sql
```

This separates fraud-specific preparation and business logic from general blockchain analytics.

### 6. Data Quality Testing

The project includes multiple types of dbt validation, including:

- Schema tests
- Relationship tests
- Accepted-value tests
- Positive-value tests
- Singular SQL tests
- Custom generic test macros

Examples include validation of token-transfer relationships and positive transaction values.

### 7. Reusable dbt Macros

Reusable macros are maintained separately from model SQL, including:

```text
macros/
├── ci_schema_cleanup.sql
├── conversion_util.sql
├── generic_test_value_is_positive.sql
└── random.sql
```

This keeps repeated logic centralized and makes the project easier to maintain.

### 8. CI/CD with GitHub Actions

The repository contains dedicated GitHub Actions workflows:

```text
.github/
└── workflows/
    ├── dbt-ci.yml
    ├── dbt-cd-deploy.yml
    └── cleanup.yml
```

The workflow structure supports automated validation, deployment, and environment cleanup.

## 🚀 Quick Start Guide (5 Minutes)

The quickest path assumes the three raw Ethereum source tables have already been loaded into Snowflake.

### Prerequisites

- Python 3.9+
- Snowflake account
- Git
- dbt Core
- Access to the project's Snowflake database/schema

### Step 1 — Clone the Repository

```bash
git clone https://github.com/niteshranga/eth.git
cd eth
```

### Step 2 — Create a Python Environment

Windows:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

macOS/Linux:

```bash
python -m venv .venv
source .venv/bin/activate
```

### Step 3 — Install dbt

```bash
pip install dbt-core dbt-snowflake
```

Verify:

```bash
dbt --version
```

### Step 4 — Configure Snowflake

Configure a dbt profile for the project with your Snowflake credentials.

Your profile should provide:

- Snowflake account
- Username
- Password or authentication method
- Role
- Warehouse
- Database
- Schema

Do not commit credentials or secrets to GitHub.

### Step 5 — Install dbt Packages

```bash
dbt deps
```

### Step 6 — Validate the Connection

```bash
dbt debug
```

### Step 7 — Build the Project

```bash
dbt build
```

`dbt build` runs the relevant models and tests according to the project's dependency graph.

### Step 8 — Review the Generated Lineage

```bash
dbt docs generate
dbt docs serve
```

This opens the generated dbt documentation and model lineage locally.

## 📊 Dataset

The project works with Ethereum blockchain data represented through three primary source domains:

| Source | Description | Analytical Role |
|---|---|---|
| `transactions` | Ethereum transaction-level blockchain records | Network activity, wallets, ETH transfers and transaction behavior |
| `token_transfers` | Token movement events generated by blockchain activity | ERC-20/token activity and transfer analysis |
| `contracts` | Smart-contract records | Contract deployment and interaction analysis |

### Core Relationship

The key relationship is:

```text
transactions
     │
     │ transaction_hash
     ▼
token_transfers
```

The relationship is **one-to-many** because one Ethereum transaction can contain multiple token-transfer events.

Smart contracts are related through transaction and contract addresses, allowing transaction-level activity to be connected to contract interactions.

## 🏗️ Architecture

### High-Level Architecture

```text
                 ETHEREUM BLOCKCHAIN DATA
                           │
                           ▼
              ┌─────────────────────────┐
              │     Snowflake RAW       │
              │                         │
              │  • Transactions         │
              │  • Token Transfers      │
              │  • Contracts            │
              └────────────┬────────────┘
                           │
                           ▼
              ┌─────────────────────────┐
              │      dbt BASE            │
              │                         │
              │  stg_transactions       │
              │  stg_token_transfers    │
              │  stg_contracts          │
              └────────────┬────────────┘
                           │
                           ▼
              ┌─────────────────────────┐
              │    dbt STAGING           │
              │                         │
              │  transactions_enriched  │
              │  stg_fraud              │
              └────────────┬────────────┘
                           │
                 ┌─────────┴─────────┐
                 ▼                   ▼
       ┌──────────────────┐  ┌──────────────────┐
       │ ANALYTICS MARTS  │  │   FRAUD MARTS    │
       │                  │  │                  │
       │ ETH activity     │  │ Confirmed frauds │
       │ Stablecoins      │  │ Fraud analysis   │
       │ Token activity   │  │                  │
       └──────────────────┘  └──────────────────┘
```

### Transformation Flow

```text
RAW
 │
 ├── transactions
 ├── token_transfers
 └── contracts
       │
       ▼
BASE
 │
 ├── stg_transactions
 ├── stg_token_transfers
 └── stg_contracts
       │
       ├──────────────────────┐
       ▼                      ▼
ANALYTICS STAGING        FRAUD STAGING
 │                      │
 └── transactions_      └── stg_fraud
     enriched                 │
       │                      │
       ▼                      ▼
ANALYTICS MARTS          FRAUD MARTS
 │                      │
 ├── eth_activity       └── confirmed_frauds
 ├── stablecoin_activity
 └── token activity
```

### Data Quality Flow

```text
Source Data
    ↓
dbt Schema Tests
    ↓
Relationship / Accepted Values
    ↓
Custom Generic Tests
    ↓
Singular SQL Tests
    ↓
Analytics Models
```

### CI/CD Flow

```text
GitHub Commit / Pull Request
             ↓
      GitHub Actions
             ↓
         dbt CI
             ↓
      Tests + Validation
             ↓
      Deployment Workflow
             ↓
       Target Environment
```

## 📁 Project Structure

The repository is organized as a standard dbt project with dedicated analytics and fraud domains:

```text
eth/
│
├── .gitignore
├── dbt_project.yml
├── packages.yml
├── package-lock.yml
├── README.md
│
├── .dbt/
│   └── profiles.yml
│
├── .github/
│   └── workflows/
│       ├── cleanup.yml
│       ├── dbt-cd-deploy.yml
│       └── dbt-ci.yml
│
├── analyses/
│   ├── generate_schema.sql
│   ├── relation.sql
│   └── test.sql
│
├── macros/
│   ├── ci_schema_cleanup.sql
│   ├── conversion_util.sql
│   ├── generic_test_value_is_positive.sql
│   └── random.sql
│
├── models/
│   ├── base/
│   │   ├── stg_contracts.sql
│   │   ├── stg_token_transfers.sql
│   │   └── stg_transactions.sql
│   │
│   ├── staging/
│   │   ├── analytics/
│   │   │   └── transactions_enriched.sql
│   │   └── fraud/
│   │       └── stg_fraud.sql
│   │
│   ├── marts/
│   │   ├── analytics/
│   │   │   ├── eth_activity_per_day.sql
│   │   │   ├── stablecoin_activity_per_day.sql
│   │   │   ├── stablecoin_activity_per_day_v1.sql
│   │   │   └── stablecoin_activity_per_day_v2.sql
│   │   │
│   │   └── fraud/
│   │       ├── confirmed_frauds.sql
│   │       ├── test.sql
│   │       └── test_v1.sql
│   │
│   ├── groups.yml
│   ├── schema.yml
│   ├── sources.yml
│   └── transactions.md
│
├── seeds/
│   └── stablecoins.csv
│
├── snapshots/
│   └── airbnb.yml
│
└── tests/
    └── singular_test_amt_is_positive.sql
```

> **Note:** `dbt_packages/`, `target/`, logs, compiled SQL, and other generated artifacts are intentionally omitted from the logical project structure above because they are build/runtime outputs rather than core source code.

## 🧰 Technology Stack

| Layer | Technology | Purpose |
|---|---|---|
| Data Warehouse | **Snowflake** | Store and query blockchain data |
| Transformation | **dbt Core** | SQL-based ELT and model orchestration |
| Programming | **SQL / Jinja** | Transformations and reusable macros |
| Version Control | **GitHub** | Source control and collaboration |
| CI/CD | **GitHub Actions** | Automated testing, deployment and cleanup |
| Development | **VS Code** | dbt/SQL development environment |
| Package Management | **dbt Packages** | Reusable dbt functionality |

## 🔍 What Makes This Project Different?

Unlike a conventional analytics warehouse, this project models **event-driven blockchain data**.

The key analytical challenge is understanding that:

```text
1 Ethereum Transaction
        ↓
   Can trigger
        ↓
Many Token Transfers
        ↓
Associated with
        ↓
Tokens / Wallets / Contracts
```

This allows the project to move beyond simple transaction reporting and support higher-level questions such as:

- How does Ethereum activity change over time?
- Which wallets participate in token-transfer activity?
- How much stablecoin activity occurs each day?
- Which smart contracts are involved in transaction activity?
- Which transaction patterns warrant fraud investigation?

The combination of blockchain-specific modeling, modular dbt transformations, reusable macros, automated tests, dedicated analytics/fraud marts, and GitHub Actions makes the project representative of a modern analytics engineering workflow.

