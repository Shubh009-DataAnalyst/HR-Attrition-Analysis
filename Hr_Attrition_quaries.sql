create database hr_attrition_db;
use hr_attrition_db;
select * from hr_attrition;

-- Q.1 How many employees left the company overall?
select count(*) as total_employees, sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left,
round(sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0/count(*),2) as attrition_percentage
from hr_attrition;

-- Q.2 Which department has the highest attrition?
select department, count(*) as total_employees,
sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left
from hr_attrition
group by department order by employees_left desc;

-- Q.3 Is attrition higher for males or females?
select gender, count(*) as total_employees,
sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left
from hr_attrition group by gender;

-- Q.4 Do employees with lower income leave more?
select attrition, round(avg(monthly_income),0) as avg_monthly_income
from hr_attrition group by attrition;

-- Q.5 Does job satisfaction affect attrition?
select job_satisfaction, count(*) as total_employees,
sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left
from hr_attrition group by job_satisfaction
order by job_satisfaction;

-- Q.6 Does overtime increase attrition?
select over_time, count(*) as total_employees,
sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left
from hr_attrition group by over_time;

-- Q.7 Do low or high performers leave more?
select performance_rating, count(*) as total_employees,
sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left
from hr_attrition group by performance_rating order by performance_rating;

-- Q.8 Do new employees leave more than experienced ones?
select years_at_company, count(*) as total_employees,
sum(case when Attrition = 'Yes' then 1 else 0 end) as employees_left
from hr_attrition group by years_at_company order by years_at_company;



