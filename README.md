#  HR Analytics: A Deep Dive into Workforce Dynamics  

## 🎯 Project Objective  
The primary objective of this project is to analyze a comprehensive HR dataset to uncover key insights into workforce composition, employee turnover, and demographic distribution. By leveraging SQL for data analysis and transformation, this project aims to provide the HR department with actionable data to support strategic decision-making, improve employee retention, and foster a more diverse and inclusive workplace.

The primary objective of this project:  
- Workforce composition  
- Employee turnover  
- Demographic distribution

---

## 🛠️ Tools & Technologies  
- **Database:** MySQL  
- **Data Analysis:** SQL  
- **Visualization:** Power BI (interactive dashboards built on cleaned data)
- 
---

## 🔄 Project Workflow  
1. **Data Loading** – The initial raw hr.csv dataset was loaded into a MySQL database.  
2. **Data Cleaning & Transformation** – Rigorous data cleaning was performed to handle inconsistencies, format errors, and missing values, ensuring data integrity for analysis.  
3. **Exploratory Data Analysis (EDA)** – A series of strategic questions were formulated to guide the analysis. SQL queries were written to explore the data and answer these questions.  
4. **Insight Generation & Dashboarding** – The findings from the analysis were synthesized to derive key insights, which form the basis for a multi-page interactive **Power BI dashboard.**

---

## 🧹 Data Cleaning & Transformation  
The raw dataset contained several inconsistencies that needed to be addressed before analysis. The following steps were performed using the HR_analytics_data_cleaning.sql script: 
- **Standardized Column Names** – Renamed the ï»¿id column, which contained a problematic byte order mark (BOM) character, to a clean id. 
- **Date Formatting** – The birthdate and hire_date columns contained mixed formats (e.g., MM/DD/YYYY and YYYY-MM-DD). These were standardized and converted to a consistent DATE data type..  
- **Termination Date Handling** – The termdate field, which contained timestamps, was cleaned and converted to a standard DATE format.
Invalid future termination dates, which represented data entry errors, were set to NULL to accurately reflect active employees.  
- **Feature Engineering** – A new age column was created by calculating the difference between the current date and the employee's birthdate. This new feature is critical for performing age-based demographic and retention analysis.  

---

## 🔎 Exploratory Data Analysis (SQL Insights):  Key Questions & SQL Queries  

### 1️⃣ Workforce Demographics  
- **Gender Breakdown:** The analysis reveals a nearly balanced gender distribution, with **males comprising approximately 52%** and **females 48%** of the workforce.
- **Race & Ethnicity:** The workforce is predominantly composed of **White (55%), Black or African American (14%)**, and **Asian (10%)** employees. This provides a baseline for diversity and inclusion initiatives.
- **Age Distribution:** The largest cohort of employees falls within the 34-43 age group, followed by the 24-33 and 44-53 age groups.
The youngest employee is 21 years old, and the oldest is 58. This indicates a mature workforce with a blend of experience levels.

### 2️⃣ Employment & Location  
- **Work Location:** A significant majority of **employees (72%) work at the Headquarters**, while **28% work remotely**. This has major implications for company culture, resource allocation, and retention strategies.
- **Job Titles:** The most common job titles across the company are **Business Analyst** and **Auditor**, suggesting these roles are central to the company's operations.
- **Geographic Presence:** The company has the largest employee presence in **California**, with significant numbers in **Texas, New York** and **Colorado**.
### 3️⃣ Employee Tenure & Turnover  
- **Average Tenure (terminated employees):**The average length of employment for employees who have left the company is approximately 5 years. This suggests that turnover is not primarily an issue with new hires but may be related to mid-career stagnation or external opportunities for experienced staff. 
- **Turnover Rate by Department (critical insight):**  
  -The analysis pinpoints a critical area of concern: the **Service department** exhibits the highest turnover rate by a significant margin.
  -Following Service, the **Hr, Accounts,** and **Training departments** also show above-average turnover rates.
  -Conversely, departments like **It** and **Marketing** have the lowest turnover, indicating high stability 
- **Growth Trend:** Net positive headcount growth, but rising terminations (2019–2022)  

---

## 💡 Actionable Insights & Recommendations 
Based on the analysis, the following strategic recommendations can be made to the HR department:

1. **Target the Auditing Department**  
   - Action: Immediately conduct targeted exit interviews and manager feedback sessions within the Auditing department to identify the root causes of high turnover. Investigate factors such as workload, career progression paths, and management style.
2. **Retention for Mid-Career Employees**  
   - **Action:** Since the average tenure of departing employees is over 5 years, focus on creating clear career development and upskilling opportunities for experienced staff to prevent them from seeking external growth.
3. **Support Remote Workforce**  
   - **Action:** With 28% of the workforce being remote, HR should analyze if turnover rates differ between remote and in-office employees, especially within high-turnover departments, to ensure remote workers are fully integrated and supported.
4. **Strengthen Diversity & Inclusion (D&I)**  
   - **Action:** Use the demographic data as a benchmark to set and track D&I goals. Launch targeted recruitment campaigns to attract talent from underrepresented groups and ensure equitable promotion processes.  

---

## ⚙️ How to Reproduce This Project  
1. **Set up the Database:**
   -Create a new database in your MySQL instance (e.g., hr_analytics).
2. **Create the Table:**
   -Create a table (hr) with a structure that matches the columns in the hr.csv file.
3. **Load the Data:**
   -Import the hr.csv file into the hr table using a data import tool.
4. **Run the Scripts:**
    -Execute the HR_analytics_data_cleaning.sql script to clean and transform the data.
    -Execute the HR_Analytics.sql script to run the analysis queries and generate insights.
