# 📞 Complaint-management-and-escalation-system

A fully-featured Oracle SQL & PL/SQL-based Complaint Management System designed to automate customer complaint tracking, technician assignment, status logging, and escalation handling.

---

## 🔧 Tech Stack

- Oracle SQL
- PL/SQL (Procedures, Triggers,  Cursors)
- DBMS_SCHEDULER
- Analytical Views
- Error Logging Tables

---

## 📚 Project Description

This system streamlines the end-to-end complaint lifecycle — from logging to resolution — by managing technician assignments, logging status changes, and auto-escalating unresolved complaints. It's built using core and advanced Oracle features like triggers, procedures, and scheduled jobs.

---

## 🧩 Features

- 🔄 **Automatic Technician Assignment** using PL/SQL procedure
- 🛠️ **Complaint Escalation** after 2 days of inactivity using `DBMS_SCHEDULER`
- 🧾 **Status Audit Trail** with Triggers & Log Table
- 📊 **Analytical Views** for performance reporting
- 🧪 Centralized **Error Logging Table** for traceability

---

## 📁 Tables Used

- `CUSTOMERS`
- `TECHNICIANS`
- `COMPLAINTS`
- `STATUS_LOG`
- `ESCALATIONS`


---

## ER Diagram
   (https://dbdiagram.io/d/PROJECT_1-684a9b6ea463a450da391d71`


## 🧪 How to Use

1. **Create Tables**: Run the `tables.sql` script to create all necessary tables.
2. **Insert Sample Data**: Use `dummy_data.sql` for quick testing.
3. **Create Procedures & Triggers**: Execute `procedures.sql` and `triggers.sql`.
4. **Run Test Cases**: Simulate workflows like new complaint entry, technician assignment, and escalation.
5. **Schedule Jobs**: Use DBMS_SCHEDULER to automate escalation logic.
6. **Query Views**: Use predefined views to generate performance reports.

---

## 📝 Example SQL Scripts

> Sample procedures and triggers:
- `assign_technician`: Assigns available tech based on zone.
- `escalate_complaints`: Escalates complaints not resolved in 2 days.
- `log_status_change`: Trigger to log every status update.

---

## 📈 Analytics Views

| View Name         | Purpose                                 |
|-------------------|------------------------------------------|
| `complaint_summary_view` | Shows complaint status per technician |
| `avg_resolution_time`    | Average time taken for resolutions   |
| `zone_load_view`         | Zone-wise complaint volume           |

---

## 🧠 Concepts Applied

- Cursor-based loops
- Error handling 
- `BEFORE INSERT`/`AFTER UPDATE` triggers
- Date functions (`SYSDATE`, intervals)
- Window functions (`RANK`, `ROW_NUMBER`)
- Modular PL/SQL design

---


## 👨‍💻 Author

Atharv Kumbhar  
📧 katharv925@gmail.com  
🌐 [atharvkumbhar.space](https://atharvkumbhar.space)

---
