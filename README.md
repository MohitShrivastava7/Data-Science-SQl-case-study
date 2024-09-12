Data Science Case Study: Salary Trends and Remote Work Analysis
Project Overview:
This project involved a comprehensive analysis of salary trends, remote work adoption, and compensation insights across different countries, job titles, and experience levels. The goal was to provide actionable insights for decision-makers in HR, compensation analysis, and workforce strategy.

Key Concepts and SQL Queries Utilized:
Remote Work Compensation Analysis for Managers:

Objective: Identify countries offering fully remote positions for managers with salaries exceeding $90,000 USD.
SQL Query: Utilized a SELECT DISTINCT query with filtering conditions based on job titles, salary thresholds, and remote work ratios.
Insight: The query helped pinpoint countries where high-paying remote roles for managers are prominent.
Large Companies Hiring Freshers:

Objective: Identify the top 5 countries with the greatest number of large companies hiring entry-level candidates (freshers).
SQL Query: A COUNT aggregation with GROUP BY and ordering was used to rank countries by the number of large companies.
Insight: Provided valuable data for job placement strategies in large companies.
High-Paying Remote Roles Analysis:

Objective: Calculate the percentage of employees in fully remote roles with salaries exceeding $100,000 USD.
SQL Query: Variables were set to compute total employee counts and the percentage of high-paying remote positions.
Insight: Revealed the attractiveness of high-paying remote jobs, a key trend in the evolving job market.
Entry-Level Salary Comparison by Location:

Objective: Identify countries where entry-level salaries exceed the market average for the same job title.
SQL Query: A join of average salary per job title and location, combined with a comparison to global averages.
Insight: Guided freshers to countries offering better-than-average entry-level compensation.
Country with Maximum Average Salary by Job Title:

Objective: Find the country offering the highest average salary for each job title.
SQL Query: A window function (DENSE_RANK()) was used to rank countries based on average salary for each job title.
Insight: Helped prioritize countries for high-paying job placement strategies.
Sustained Salary Growth Analysis:

Objective: Pinpoint countries with consistent salary growth over the past three years.
SQL Query: A CTE (Common Table Expression) was used to analyze trends by grouping salary data over multiple years and filtering for countries with data from the last three years.
Insight: Highlighted countries experiencing sustained salary growth, useful for long-term recruitment planning.
Remote Work Adoption Trends (2021 vs 2024):

Objective: Compare the percentage of fully remote work for each experience level between 2021 and 2024.
SQL Query: Aggregated data by year and experience level, calculating remote work ratios for both years.
Insight: Provided a clear comparison of remote work trends, highlighting increases or decreases in adoption.
Salary Trends and Percentage Increase:

Objective: Calculate the percentage increase in average salary for each job title and experience level between 2023 and 2024.
SQL Query: Used a CTE to group average salaries by year and experience level, followed by percentage increase calculation.
Insight: Helped HR consultants understand salary growth trends and stay competitive in talent acquisition.
Domain Transition Guidance Based on Average Salary:

Objective: Provide career guidance for individuals looking to switch domains based on their experience, location, and other preferences.
SQL Query: Created a stored procedure that takes inputs like experience level, company size, location, and employment type, returning the job titles and average salaries for guidance.
Insight: Helped professionals make informed decisions about transitioning to higher-paying domains.
Key Concepts and Tools Used:
SQL Aggregation and Filtering:

Utilized SQL functions like COUNT(), AVG(), GROUP BY, and ORDER BY to summarize and filter large datasets.
Window Functions:

Applied window functions such as DENSE_RANK() to rank countries and job titles based on specific criteria.
Common Table Expressions (CTE):

CTEs were employed to break down complex queries and handle recursive salary trend analysis.
Stored Procedures:

Created stored procedures to encapsulate logic for domain transitions based on salary trends and other parameters, enhancing query reusability.
