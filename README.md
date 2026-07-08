#  Healthcare Claims Intelligence Platform

An end-to-end Healthcare Claims Intelligence Platform built using **MySQL** and **Power BI** to manage, analyze, and visualize healthcare insurance claim data. This project demonstrates database design, SQL programming, performance optimization, and business intelligence reporting through an interactive dashboard.

---

##  Project Overview

Healthcare organizations process thousands of insurance claims every day. This project simulates a real-world healthcare claims management system by storing and analyzing data related to:

- Patients
- Doctors
- Hospitals
- Insurance Providers
- Appointments
- Claims

The platform provides actionable insights through an interactive Power BI dashboard that helps analyze claim trends, hospital performance, insurance company contributions, diagnosis patterns, and claim approval statistics.

---

##  Features

###  Database Design
- Normalized relational database
- 10+ interconnected tables
- Primary Keys & Foreign Keys
- Data integrity constraints

###  SQL Programming
- Stored Procedures
- User Defined Functions
- Database Triggers
- Indexes for query optimization

###  Business Intelligence Dashboard
- Executive KPI Cards
- Monthly Claim Trends
- Hospital Revenue Analysis
- Insurance Company Analysis
- Diagnosis Analysis
- Claim Status Distribution
- Interactive Slicers

---

# Database Schema

The project consists of the following core tables:

- Patients
- Doctors
- Hospitals
- Departments
- Insurance
- Appointments
- Claims
- Claim Audit

---

# Tech Stack

| Technology | Purpose |
|------------|---------|
| MySQL 8.0 | Database |
| SQL | Queries & Programming |
| Power BI | Dashboard & Visualization |
| DAX | Measures & KPIs |

---

#  Dashboard KPIs

The dashboard provides the following business metrics:

-  Total Claim Amount
-  Total Approved Amount
-  Approval Rate
-  Total Doctors
-  Total Patients
-  Hospital-wise Revenue
-  Monthly Claim Trend
-  Diagnosis Analysis
-  Insurance Company Analysis
-  Claim Status Distribution

---




---

#  SQL Concepts Used

### DDL
- CREATE TABLE
- ALTER TABLE
- DROP

### DML
- INSERT
- UPDATE
- DELETE

### DQL
- SELECT
- GROUP BY
- HAVING
- ORDER BY

### Advanced SQL
- Joins
- Views
- Stored Procedures
- Functions
- Triggers
- Indexes
- Aggregate Functions

---

#  Key Insights

- Identifies hospitals generating the highest claim amounts.
- Tracks monthly claim trends.
- Analyzes insurance company claim distribution.
- Shows diagnosis categories with the highest claims.
- Measures claim approval performance.
- Enables dynamic filtering using slicers.

---





#  How to Run

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/Healthcare-Claims-Intelligence-Platform.git
```

###  Import SQL Files

Execute the SQL files in the following order:

1. schema.sql
2. insert_data.sql
3. procedures.sql
4. functions.sql
5. triggers.sql
6. indexes.sql

### 3. Open Power BI

Open:

```
Healthcare_Claims.pbix
```

Refresh the data source after connecting to your MySQL database.

---

#  Future Enhancements

- Role-based authentication
- Predictive claim approval using Machine Learning
- Fraud detection analytics
- Real-time streaming dashboard
- REST API integration

---

#  Author

**Tanishq Wahal**

B.Tech Computer Science Engineering (AI & ML)

LinkedIn: https://www.linkedin.com/in/tanishqwahal21/

---

#  If you found this project useful, consider giving it a star.
