# Marketing Analytics Platform — ETL, Analytics Engineering & Executive Dashboards

## Overview

This repository contains a **production-style Marketing Analytics platform** designed to help senior leadership make **data-driven budget and growth decisions** across paid marketing channels.

The system ingests raw marketing performance data, transforms it using analytics engineering best practices, enforces data quality, and exposes **decision-ready metrics** through executive dashboards.

The project is intentionally scoped and implemented to reflect **real-world FAANG analytics standards**, not a toy or demo setup.

---

## Business Context

The business runs large-scale paid marketing campaigns across multiple channels (Search, Social, Display).  
Despite significant spend, leadership lacked clear answers to fundamental questions:

- Which campaigns are *actually* profitable?
- Where does performance break down in the funnel?
- Are we scaling efficiently or buying unprofitable growth?
- Where should budget be reallocated right now?

### Core Problems Identified
- Fragmented data exports from ad platforms
- Inconsistent definitions of funnel metrics
- No enforced data quality or modeling standards
- Dashboards optimized for reporting, not decision-making

---

## Solution Summary

This project delivers a **centralized Marketing Analytics Command Center** by:

- Building a reliable **ETL pipeline** for paid marketing data
- Modeling data using a **proper star schema**
- Enforcing **data quality checks** at the warehouse level
- Creating **executive-grade dashboards** aligned to real business decisions

The result is a system that supports **continuous optimization**, not just retrospective reporting.

---

## High-Level Architecture

Raw Marketing Data (CSV / Ad Platform Exports)
↓
Python ETL (Extract → Clean → Load)
↓
PostgreSQL (Staging Layer)
↓
dbt Core (Transformations + Tests)
↓
Analytics Warehouse (Star Schema)
↓
Metabase Dashboards (Decision Layer)

---

## Repository Structure

marketing-analytics-etl/
│
├── data/
│ ├── raw/ # Raw marketing data exports
│ └── processed/ # Cleaned intermediate data
│
├── etl/
│ ├── extract.py # Data ingestion logic
│ ├── transform.py # Cleaning & normalization
│ ├── load.py # Load into PostgreSQL
│ └── run_pipeline.py # End-to-end ETL runner
│
├── dbt/
│ ├── models/
│ │ ├── staging/ # Source-aligned staging models
│ │ └── marts/ # Fact & dimension tables
│ ├── tests/ # Data quality tests
│ └── dbt_project.yml
│
├── dashboards/
│ └── metabase/ # Dashboard definitions
│
├── screenshots/ # Dashboard screenshots
│
├── docker-compose.yml # PostgreSQL container
├── requirements.txt
└── README.md

---

## Data Modeling Approach

The analytics warehouse follows a **star schema**, optimized for BI performance and analytical clarity.

### Fact Table
**fact_marketing_performance**

**Grain**  
`ad_id × campaign × device × location × date`

**Metrics**
- impressions
- clicks
- leads *(aggregated mid-funnel intent events)*
- conversions *(purchases)*
- cost
- sale_amount

### Dimension Tables
- dim_campaign
- dim_device
- dim_location
- dim_keyword
- dim_date

### Design Principles
- Surrogate primary keys in dimensions
- Foreign keys in the fact table
- Descriptive attributes kept out of the fact
- Business-readable dimensions exposed to BI tools

This structure mirrors how marketing analytics is modeled in large-scale production environments.

---

## Funnel Definition & Assumptions

The marketing funnel is explicitly defined as:

Impressions → Clicks → Leads → Conversions


**Important clarification:**
- *Leads* are modeled as **aggregated platform-reported intent events**
- They are **not CRM leads** and do not represent individual users
- This choice reflects the granularity of ad-platform data and is appropriate for performance analytics

All funnel metrics (CPL, conversion rates, drop-offs) are derived consistently from this definition.

---

## Data Quality & Testing

Data reliability is enforced using **dbt tests**, including:

- Not-null constraints on critical fields
- Primary key uniqueness in dimension tables
- Referential integrity between fact and dimensions
- Metric-level sanity checks

This ensures that dashboards are built on **trusted, auditable data**.

---

## Dashboard Suite

### Dashboard 1 — Executive Overview
**Audience:** CMO, VP Growth  
**Purpose:** Assess overall marketing health and ROI

Key metrics:
- Total Spend
- Total Revenue
- Profit
- ROAS
- CAC



---

### Dashboard 2 — Funnel & Conversion Analysis
**Audience:** Growth, Product, Analytics  
**Purpose:** Identify structural funnel drop-offs and friction

Key insights:
- End-to-end funnel visualization
- Conversion rates by stage
- Time-based funnel trends



---

### Dashboard 3 — Campaign & Optimization Performance
**Audience:** Performance Marketing Teams  
**Purpose:** Drive budget reallocation and optimization

Key insights:
- Best and worst performing campaigns
- ROAS by device and location
- Cost efficiency by keyword
- Profit contribution analysis



---

## Technology Stack

| Layer | Tool |
|-----|-----|
| ETL | Python, Pandas |
| Warehouse | PostgreSQL (Docker) |
| Transformations | dbt Core |
| Data Quality | dbt Tests |
| BI & Dashboards | Metabase |
| Version Control | Git & GitHub |

All tools used are **free and open-source**, mirroring cost-conscious production setups.

---

## Running the Project Locally

### Start PostgreSQL
```bash
docker compose up -d
```
### Run ETL
```bash
python etl/run_pipeline.py
```
### Build & Test Models
```bash
dbt run
dbt test
```
### Open Metabase
http://localhost:3000

## Business Impact

This platform enables leadership to:

- Reallocate marketing spend based on **true profitability**, not vanity metrics  
- Detect **funnel inefficiencies early** before they impact revenue  
- Identify **scalable vs. wasteful campaigns** with confidence  
- Shift from **reactive reporting** to **proactive, data-driven optimization**

---

## Why This Project

This repository demonstrates:

- **Real-world analytics engineering rigor** aligned with FAANG standards  
- **Clear business framing and explicit assumptions**, not just technical execution  
- **Decision-focused dashboards** built for executives, not analysts alone  
- **Production-style data modeling and quality enforcement** suitable for scaling teams
