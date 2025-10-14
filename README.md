# Razorpay Data Modeling Project

This project demonstrates a comprehensive data modeling approach for a payment processing platform like Razorpay, implementing the modern data architecture using Bronze-Silver-Gold layers with Data Vault 2.0 methodology.

## 📋 Overview

The project creates a complete data pipeline that transforms raw payment data through multiple layers:

1. **Bronze Layer**: Raw data ingestion from simulated payment transactions
2. **Silver Layer**: Data Vault 2.0 implementation for scalable data warehousing
3. **Gold Layer**: Kimball dimensional model for analytics and reporting

## 🏗️ Architecture

### Bronze Layer (Raw Data)
- `raw_merchant_profiles`: Merchant registration and status information
- `raw_merchant_subscriptions`: Pricing plans and subscription history
- `raw_merchant_transactions`: Payment transaction records

### Silver Layer (Data Vault 2.0)
**Hubs** (Business Keys):
- `HUB_MERCHANT`: Unique merchant identifiers
- `HUB_TRANSACTION`: Unique transaction identifiers  
- `HUB_SUBSCRIPTION`: Unique subscription identifiers

**Satellites** (Descriptive Data):
- `SAT_MERCHANT_PROFILE`: Merchant details (name, status, signup date)
- `SAT_SUBSCRIPTION_DETAILS`: Subscription information (tier, fees, dates)

**Links** (Relationships):
- `LNK_MERCHANT_SUBSCRIPTION`: Merchant-to-subscription relationships
- `LNK_MERCHANT_TRANSACTION`: Merchant-to-transaction relationships

### Gold Layer (Dimensional Model)
**Dimensions**:
- `DIM_MERCHANT`: Merchant dimension table
- `DIM_SUBSCRIPTION`: Subscription dimension table

**Facts**:
- `FACT_PAYMENT_REVENUE`: Revenue metrics and transaction facts


## 📊 Sample Data Generation

The project generates realistic synthetic data using the Faker library:

- **100 merchants** with realistic company names and signup dates
- **~200 subscription records** across different pricing tiers (Starter: 2.9%, Pro: 1.5%, Enterprise: 1.0%)
- **10,000 transactions** with various payment methods (Card, UPI, Wallet, Net Banking)


## 🛠️ Technical Implementation

### Data Vault 2.0 Features
- **Hash Keys**: SHA-256 hashing for surrogate keys
- **Audit Columns**: Load datetime and record source tracking  
- **Business Key Storage**: Preservation of original business identifiers
- **Hash Diff**: Change detection for satellite records

### Dimensional Model Features
- **Slowly Changing Dimensions**: Historical subscription changes
- **Fact Table Bridging**: Linking transactions to active subscriptions
- **Revenue Calculations**: Platform fee computation based on subscription tiers

## 📁 Project Structure

```
razorpay_data_modeling/
├── data-modeling.ipynb    # Main notebook with complete pipeline
├── Dockerfile            # Container configuration
└── README.md            # This file
```



## 📈 Key Metrics & Insights

The project demonstrates several important data warehousing concepts:

- **Scalability**: Data Vault 2.0 approach supports high-volume, high-velocity data
- **Flexibility**: Easily accommodate new data sources and business requirements
- **Auditability**: Complete data lineage and historical tracking
- **Performance**: Optimized dimensional model for analytical queries

## 🚧 Next Steps

- **Define Delta Tables**: Physically create Delta Lake tables for all Silver (Hubs, Satellites, Links) and Gold (Dimensions, Fact) entities.
- **Enrich and Validate Bronze**:
    - Add metadata columns such as `file_name` and `file_timestamp` to support data lineage.
    - Implement data quality checks and a quarantine zone to isolate and reject bad data (e.g., negative amounts, null business keys).
- **Build Incremental Load Logic**:
    - Use Delta Lake's `MERGE` statement for efficient, incremental loading of all tables.
    - For Hubs and Links, merge to insert only new records.
    - For Satellites, use `HASH_DIFF` to detect changes and insert new records only when a change is detected.
- **Automate and Monitor**:
    - Schedule and orchestrate the pipeline from Bronze to Gold using a tool like Databricks Workflows or Airflow.
    - Set up monitoring and alerts to flag job failures and data quality issues.
