# 📊 RFM Analysis Project

This project performs **RFM (Recency, Frequency, Monetary) analysis** on customer transaction data using **Excel**.  
It includes **data cleaning, calculation of RFM scores (0–9), customer segmentation into 9 groups, and visualizations**.

---

## 📂 Project Structure
- `RFM_Analysis.xlsx` – Excel file with Raw, cleaned data, RFM calculations, pivot tables, and segmentation  
  > ⚠️ **Note:** This file is large (~69 MB) and tracked with **Git LFS**. Make sure Git LFS is installed to clone or download it properly.  
- `README.md` – Project documentation  

---

## 🛠 Steps in Analysis

### 1️⃣ Data Cleaning
- Convert transaction dates to proper datetime format  
- Remove duplicates and invalid entries  
- Remove negative or zero quantities and unit prices  
- Calculate `Revenue = Quantity × UnitPrice`  

### 2️⃣ RFM Calculation
- **Recency:** Days since last purchase  
- **Frequency:** Number of unique invoices per customer  
- **Monetary:** Total revenue per customer  
- Normalize last purchase date and compute `Recency` relative to dataset max date  

### 3️⃣ RFM Scoring
- Scores assigned **from 0 to 9** for each metric  
- Recency: Lower is better → higher score for recent purchases  
- Frequency & Monetary: Higher is better → higher score for larger values  

### 4️⃣ Customer Segmentation
- Customers are segmented into **9 groups** based on RFM scores:  
  - 🏆 CHAMPION  
  - ❄️ HIBERNATING  
  - ⚠️ NEED ATTENTION  
  - 🌱 POTENTIAL LOYALIST  
  - 🆕 NEW CUSTOMER  
  - ✨ PROMISING  
  - 🔻 AT RISK  
  - 💖 LOYAL CUSTOMER  
  - 📝 OTHER  

### 5️⃣ Visualization
- Bar charts and treemaps to show customer distribution across segments  

---

## 💻 Tools Used
- Microsoft Excel
- Git LFS (for large Excel file)
