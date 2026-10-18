# Automated Database Audit Pipeline

A Python and MySQL project designed to track database changes, preserve historical records, and analyze data activity through an interactive dashboard.

## Overview

The Automated Database Audit Pipeline captures changes made to a MySQL database using triggers. It records INSERT, UPDATE, and DELETE operations in a dedicated audit table, preserving previous and updated values for historical analysis.

The project is being developed incrementally, starting with MySQL-based change tracking and progressing toward Python automation, data analysis, and interactive reporting.

## Current Features

- **Automatic Change Tracking:** Captures INSERT, UPDATE, and DELETE operations using MySQL triggers.
- **Historical Data Preservation:** Stores previous and updated row values for auditing.
- **JSON-Based Logging:** Uses `JSON_OBJECT()` to maintain structured records of database changes.
- **Centralized Audit History:** Stores captured events in a dedicated `trigger_report` table.

## Technology Stack

- MySQL
- SQL Triggers
- JSON Functions
- Python *(planned)*
- Pandas *(planned)*
- Streamlit *(planned)*

## Database Design

The project uses two primary tables:

| Table | Purpose |
|---|---|
| `customer_orders` | Stores the original order data. |
| `trigger_report` | Stores the history of database changes. |

### Audit Record Structure

| Column | Description |
|---|---|
| `record_id` | ID of the affected order |
| `table_name` | Name of the source table |
| `customer_name` | Associated customer |
| `action_type` | INSERT, UPDATE, or DELETE |
| `old_data` | Previous row values in JSON format, or NULL |
| `new_data` | New row values in JSON format, or NULL |

## Audit Logic

| Operation | `old_data` | `new_data` |
|---|---|---|
| INSERT | NULL | Newly inserted row |
| UPDATE | Previous row values | Updated row values |
| DELETE | Deleted row values | NULL |

## Development Roadmap

- [x] Create the database and audit table structure.
- [x] Implement INSERT, UPDATE, and DELETE triggers.
- [ ] Test trigger behavior with different database operations.
- [ ] Connect Python to MySQL.
- [ ] Extract and analyze audit records using Pandas.
- [ ] Track changes since the previous successful run.
- [ ] Develop an interactive Streamlit dashboard.
- [ ] Add filtering, reporting, error handling, and automated tests.

## Project Objective

Build a reliable database auditing system that automatically records data changes and makes historical activity easier to inspect, analyze, and report.

## Project Status

**In Progress** — MySQL trigger-based change tracking is implemented in the initial development stage. Python integration, audit analysis, and dashboard development are upcoming milestones.

## Author

Ajay Singh
