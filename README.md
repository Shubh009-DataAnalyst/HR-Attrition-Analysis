# HR Attrition Dashboard Analysis

## About the Project
Employee attrition is a critical problem for HR teams.  
This project focuses on understanding **why employees leave**, **which groups are most affected**, and **what factors influence attrition** using real-world HR data.

The goal of this project is to help HR and management take **data-driven retention decisions**.

This end-to-end project covers:
- Data cleaning using Excel
- Analysis using SQL
- Interactive dashboard using Power BI

---

## Tools & Skills Used
- **Excel / Power Query** – Data cleaning & preparation  
- **SQL (MySQL)** – Business analysis queries  
- **Power BI** – Dashboard, DAX measures & visuals  

---

## Data Cleaning (Excel)

Before analysis, the raw dataset was cleaned in Excel.

### Cleaning Steps Performed
- Removed duplicate employee records
- Standardized text values (Yes/No, department names)
- Handled blank & null values
- Converted data types (salary, age, years)
- Created bins for income and experience

### Excel Formulas Used

```excel
-- Remove leading & trailing spaces
=TRIM(A2)

-- Convert text to proper case
=PROPER(A2)

-- Handle blank values
=IF(A2="", "Not Provided", A2)

-- Convert Yes/No to standard format
=IF(A2="Y","Yes","No")

-- Income binning
=FLOOR(Monthly_Income,10000)

-- Experience category
=IF(Years_At_Company<=2,"0-2",
 IF(Years_At_Company<=5,"3-5",
 IF(Years_At_Company<=10,"6-10","10+")))

### SQL Quaries Used

-- Total employees
SELECT COUNT(*) AS total_employees
FROM hr_attrition;

-- Employees who left
SELECT COUNT(*) AS employees_left
FROM hr_attrition
WHERE attrition = 'Yes';

-- Attrition by department
SELECT department, COUNT(*) AS attrition_count
FROM hr_attrition
WHERE attrition = 'Yes'
GROUP BY department
ORDER BY attrition_count DESC;

-- Attrition by job satisfaction
SELECT job_satisfaction, COUNT(*) AS attrition_count
FROM hr_attrition
WHERE attrition = 'Yes'
GROUP BY job_satisfaction;

-- Attrition by overtime
SELECT over_time, COUNT(*) AS attrition_count
FROM hr_attrition
WHERE attrition = 'Yes'
GROUP BY over_time;

### Power BI - Measure(DAX)
-- Total Employees
Total Employees =
COUNT(hr_attrition[EmployeeID])

-- Employees Left
Employees Left =
CALCULATE(
    COUNT(hr_attrition[EmployeeID]),
    hr_attrition[Attrition] = "Yes"
)

-- Attrition Rate %
Attrition Rate % =
DIVIDE(
    [Employees Left],
    [Total Employees],
    0
)

-- Average Monthly Income
Average Monthly Income =
AVERAGE(hr_attrition[Monthly_Income])
Dashboard

### Key Insights

-- Sales and IT departments have the highest attrition

-- Employees working overtime leave more frequently

-- Attrition is highest among employees with low job satisfaction

-- Most attrition happens in the first 2 years

-- Lower income employees show higher attrition

### Conclusion

This project demonstrates how HR data can be transformed into actionable insights using Excel, SQL, and Power BI.
The dashboard can help organizations reduce attrition and improve employee retention strategies.

Author

Shubham Bhatt
Aspiring Data Analyst
Skills: Excel | SQL | Power BI

