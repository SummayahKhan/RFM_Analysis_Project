# 📊 RFM & CLV Analysis using SQL

This project performs **RFM (Recency, Frequency, Monetary) analysis** and **Customer Lifetime Value (CLV) calculation** on customer transaction data using **SQL**.  

- RFM analysis is done in the table `RFM_Using_SubQuery`.  
- CLV calculation is done in `CLV_using_Subquery`.  

---

## 📂 Project Structure
- `create_database_and_its_table.sql` – SQL script to create the required databases and tables  
- `RFM_Using_SubQuery.sql` – SQL script to calculate RFM metrics per customer using subqueries  
- `CLV_using_Subquery.sql` – SQL script to calculate Customer Lifetime Value (CLV) per customer using subqueries  
- `README.md` – Project documentation  

---

## 🛠 Workflow / Steps

1. **Create database and tables**  
   Run `create_database_and_its_table.sql` first to set up all required databases and tables.

2. **RFM Analysis**  
   Run `RFM_Using_SubQuery.sql` to calculate **Recency, Frequency, and Monetary metrics** per customer.

3. **Customer Lifetime Value (CLV)**  
   Run `CLV_using_Subquery.sql` to calculate **CLV per customer**, optionally using the RFM metrics.

---

## 💻 Tools Used
- SQL (MySQL / PostgreSQL / SQL Server)  
- GitHub for version control  

---

## 🔗 How to Run
1. Open your SQL environment (MySQL Workbench, SQL Server Management Studio, or pgAdmin).  
2. Run `create_database_and_its_table.sql` to create databases and tables.  
3. Run `RFM_Using_SubQuery.sql` to calculate RFM metrics.  
4. Run `CLV_using_Subquery.sql` to calculate CLV.  
5. Replace dataset if needed with your actual transaction data.

---

## 📈 Notes
- All queries use **subqueries**, making them adaptable to different SQL platforms.  
- The workflow ensures that databases and tables exist before calculating RFM and CLV.

