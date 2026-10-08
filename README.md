# HR Employee Attrition Analysis Project

## Summary
**Business Problem:** The goal of this project was to find out why employees are leaving the company, so that HR can take some real action to reduce attrition instead of just guessing.

**Approach & Hypotheses:** Before touching the data, I thought about which factors usually affect attrition in any company — things like department, overtime, job satisfaction, salary, and how long someone has worked there. I made these my starting hypotheses, then used SQL to actually test each one against the data instead of just assuming they were true.

**Key Findings:**
- Overall attrition rate: **36%** (426 out of 1,200 employees left)
- **Operations** has the highest attrition rate (**40.4%**) — not Sales, even though Sales had more employees leave in raw numbers
- Overtime employees actually have a slightly **lower** attrition rate (32.0%) than non-overtime employees (37.8%) — this surprised me, I expected the opposite
- Job Satisfaction doesn't really affect attrition much — all four satisfaction levels are close to each other (around 34-36%)
- Employees with **6 years** at the company have the highest attrition rate (45.95%), not new joiners like I first assumed

**Tools Used:** Excel, Power Query, SQL, Power BI

---

## Project Overview
This project looks at employee attrition data to figure out what's actually driving people to leave the company. Attrition is expensive for any business — hiring new people takes time and money, and you lose people who already knew how things work. So I took a raw, messy HR dataset, cleaned it, ran SQL queries to answer specific questions about attrition, and built a Power BI dashboard to show the results. I also went back and double-checked my own numbers at one point because something looked off, which I've explained below.

---

## Data Cleaning

The raw data had 1,200 rows and had the kind of problems you'd expect from a real, unclean dataset — inconsistent spelling (like "it" instead of "IT"), Y/N mixed with Yes/No, and missing values in basically every column (anywhere from 8% to 21% missing per column). I cleaned this in Power Query.

For filling missing values, I didn't use the same method everywhere — I picked based on the type of column:
- For number columns like Age, Monthly Income, and Years at Company, I used the **mean**, because I checked and the data wasn't skewed (no extreme outliers pulling the average in one direction).
- For text/category columns like Department, Gender, Over Time, and Attrition, I used the **mode** (most common value), since you can't average text.
- For Job Satisfaction and Performance Rating (these are rating scales, 1 to 4), I also used mode, though thinking about it more, Median probably would've been the more correct choice since these are ranking-type values, not just plain categories. Something I'd do differently next time.

I also standardized all the text so "IT" and "it" aren't treated as two different departments, and "Y"/"Yes" mean the same thing everywhere.

---

## A Mistake I Found and Fixed

While building the dashboard, I noticed something weird — a couple of my charts were showing results that didn't make sense once I thought about them more. I dug into it and realized the problem was connected to how I filled in missing values.

Here's what happened: for `Years_At_Company`, 91 values were missing, and I'd filled all of them with the mean, which rounded to 7. So when I built a chart using raw counts, "Year 7" looked like it had way more people leaving than any other year — but that's just because 91 fake "7"s got dumped into that one bucket along with the real ones. It wasn't a real pattern, it was just my own missing-value filling making that bucket artificially bigger.

Once I switched my charts to show **Attrition Rate %** instead of raw counts, this problem mostly went away, because rate is calculated against each group's own total, so a bucket being artificially bigger doesn't throw off the percentage as badly. With this fix, I found that Year 6 actually has the highest attrition rate (45.95%), not Year 7.

This also changed my Over Time finding. I originally thought overtime employees were leaving a lot more because, in raw numbers, 64% of people who left had worked overtime. But that's misleading — it's just because there are more non-overtime employees overall, so naturally more of the people who left came from that bigger group. Once I calculated the actual rate within each group separately, non-overtime employees actually have a slightly higher attrition rate (37.8%) than overtime employees (32.0%).

So the biggest lesson from this project for me wasn't really about attrition — it was realizing that how you fill missing data and whether you use count or rate can completely change your conclusion, sometimes even flip it in the opposite direction. I now check this on every chart before trusting it.

---

## SQL Analysis

I could've built all the charts directly in Power BI without SQL, so I want to be upfront about why I used SQL anyway: it let me calculate and double check the exact numbers myself first, before trusting whatever Power BI was showing. It also forced me to write down the actual business question before building anything, instead of just dragging fields around and seeing what comes out.

The main technique I used across queries was `SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)` — SQL doesn't have a direct COUNTIF like Excel, so this is the standard way to count rows that match a condition.

**Questions I answered with SQL:**
1. What's the overall attrition rate?
2. Which departments have the most attrition?
3. Does gender affect attrition?
4. Do people who leave earn less on average?
5. Does job satisfaction affect attrition?
6. Does overtime affect attrition?
7. Does performance rating affect attrition?
8. Does how long someone's worked here affect attrition?

I picked these because each one points to something HR could actually act on. I skipped testing things that wouldn't lead to any real action even if they showed a pattern.

To make sure I wasn't making mistakes, I checked that the numbers from my grouped queries added up to the same overall total from query 1. I also went back and recalculated a few of these using rate instead of count after I found the imputation issue above.

---

## Power BI Dashboard

![dashboard](images/image.png)

**KPI Cards:** Total Employees, Attrition Rate %, Average Monthly Income, Employees Left

**Charts (all using Attrition Rate %, not raw count):**
- Attrition Rate % by Department — horizontal bar
- Attrition Rate % by Over Time — column chart
- Attrition Rate % by Monthly Income — line chart
- Attrition Rate % by Job Satisfaction — column chart
- Attrition Rate % by Years at Company — column chart

I kept everything on Attrition Rate % across the board once I understood the count-vs-rate issue, so every chart is measuring the same thing the same way and nothing's accidentally skewed by group size anymore.

---

## Key Insights

- Operations has the highest attrition rate (40.4%), even though Sales lost more people in total headcount — if HR only looked at raw numbers, they'd focus on the wrong department.
- Overtime isn't actually the big attrition driver I originally expected — the difference between overtime and non-overtime attrition rates is small, and slightly in the opposite direction.
- Job Satisfaction barely moves the needle on attrition in this data — all four levels sit around 34-36%.
- Six years in is when attrition risk is highest, not right when someone joins, which is what I assumed going in.

---

## Conclusion
Beyond the specific numbers, this project taught me that data cleaning choices aren't just a technical formality — they can actually change what your analysis tells you, sometimes by a lot. I caught this myself by double-checking count vs rate on every chart, which is something I'll do by default on every project going forward, not just when something looks off.

---

## Tools & Technologies Used
- Power Query – Data cleaning and transformation
- SQL – Data analysis and business questions
- Power BI – Dashboard building and DAX measures

---

## Author
**Shubham Bhatt**
Aspiring Data Analyst
Skills: Excel | Power Query | SQL | Power BI | DAX
