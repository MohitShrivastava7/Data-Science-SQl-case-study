CREATE DATABASE datascience;
USE datascience;

SELECT * FROM salaries;

/*1.You're a Compensation analyst employed by a multinational corporation. Your Assignment is to Pinpoint Countries who give work fully remotely, for the title
 'managers’ Paying salaries Exceeding $90,000 USD*/
 
 SELECT distinct company_location from salaries where job_title like '%manager%' and salary_in_usd >90000 and remote_ratio=100;
 
 /*2.AS a remote work advocate Working for a progressive HR tech startup who place their freshers’ clients IN large tech firms. you're tasked WITH 
Identifying top 5 Country Having  greatest count of large(company size) number of companies.*/

select company_location, count(*) as cnt from
(
select * from salaries where experience_level ='EN' and company_size='L'
)t group by company_location
order by cnt desc
limit 5;

/*3. Picture yourself AS a data scientist Working for a workforce management platform. Your objective is to calculate the percentage of employees. 
Who enjoy fully remote roles WITH salaries Exceeding $100,000 USD, Shedding light ON the attractiveness of high-paying remote positions IN today's job market.*/

set @total = (select count(*) from salaries);
SELECT @TOTAL;
set @count = (select count(*) from salaries where salary_in_usd>100000 and remote_ratio=100);
SELECT @COUNT;
set @percentage = round(((select @count)/(select @total))*100,2);
select @percentage as 'percentage';

/*4.	Imagine you're a data analyst Working for a global recruitment agency. Your Task is to identify the Locations where entry-level average salaries exceed the 
average salary for that job title in market for entry level, helping your agency guide candidates towards lucrative countries.*/

select company_location,t.job_title,experience_level,average_salary,average_salary_per_country from
(
select job_title,avg(salary) as average_salary from salaries where experience_level = 'EN'
group by job_title,experience_level
)t
inner join
(
select company_location,job_title,experience_level,avg(salary) as average_salary_per_country from salaries
where experience_level = 'EN'
group by job_title,company_location,experience_level
)m on t.job_title = m.job_title
where   average_salary_per_country > average_salary;

/*5. You've been hired by a big HR Consultancy to look at how much people get paid IN different Countries. Your job is to Find out for each job title which
Country pays the maximum average salary. This helps you to place your candidates IN those countries.*/

select * from
(
select *, dense_rank() over(partition by job_title order by avg_salary desc) as rank_ from
(
select  job_title,company_location,(avg(salary)) as avg_salary from salaries
group by job_title,company_location
)t
)k where rank_ = 1;

/*6.  AS a data-driven Business consultant, you've been hired by a multinational corporation to analyze salary trends across different company Locations.
 Your goal is to Pinpoint Locations WHERE the average salary Has consistently Increased over the Past few years (Countries WHERE data is available for 3 years Only(this and pst two years) 
 providing Insights into Locations experiencing Sustained salary growth.*/

with mycte as
(
		select * from  salaries where company_location in
		(
		select company_location from
		(
		select company_location,count(distinct(work_year)) as year_,avg(salary_in_usd) as average_salary from salaries where work_year >= (year(current_date())-2)
		group by company_location having year_ = 3
		)c
		)
)

select company_location, 
	max(case when work_year = 2022 then average_salary end) as 2022_average_salary,
	max(case when work_year = 2023 then average_salary end) as 2023_average_salary,
	max(case when work_year = 2024 then average_salary end) as 2024_average_salary
from 
(
select company_location,work_year, avg(salary) as average_salary from mycte group by company_location, work_year
)m group by company_location having 2022_average_salary;

 /* 7.	Picture yourself AS a workforce strategist employed by a global HR tech startup. Your missiON is to determINe the percentage of  fully remote work for each 
 experience level IN 2021 and compare it WITH the correspONdINg figures for 2024, highlightINg any significant INcreASes or decreASes IN remote work adoptiON
 over the years.*/

select * from 
(
	 select *, ((remote_employee)/(total_employee))*100 as '2021_remote_ratio' from
		 (
		 select m.experience_level,m.total_employee,s.remote_employee from
		 (
		 Select experience_level,count(*) as total_employee from salaries where work_year = 2021 group by experience_level
		 )m inner join
		 (
		  Select experience_level,count(*) as remote_employee from salaries where work_year = 2021 and remote_ratio = 100 group by experience_level
		)s on m.experience_level = s.experience_level
	)t

)g inner join
	(
		 select *, ((remote_employee)/(total_employee))*100 as '2024_remote_ratio' from
			 (
			 select m.experience_level,m.total_employee,s.remote_employee from
			 (
			 Select experience_level,count(*) as total_employee from salaries where work_year = 2024 group by experience_level
			 )m inner join
			 (
			  Select experience_level,count(*) as remote_employee from salaries where work_year = 2024 and remote_ratio = 100 group by experience_level
			)s on m.experience_level = s.experience_level
		)k
)h  on g.experience_level = h.experience_level;


/* 8. AS a compensatiON specialist at a Fortune 500 company, you're tASked WITH analyzINg salary trends over time. Your objective is to calculate the average 
salary INcreASe percentage for each experience level and job title between the years 2023 and 2024, helpINg the company stay competitive IN the talent market.*/

with salary_trend as
(
select experience_level,job_title,work_year,round(avg(salary_in_usd),2) as avg_salary from salaries where work_year in(2023,2024) group by  experience_level,job_title,work_year
)

select *,round((((2024_avg_salary)-(2023_avg_salary))/ (2023_avg_salary)*100),2) as '%_changes' from
(

select experience_level,job_title,
	max(case when work_year = 2023 then avg_salary end) as 2023_avg_salary,
	max(case when work_year = 2024 then avg_salary end) as 2024_avg_salary
    from salary_trend group by experience_level,job_title
)m where ((2024_avg_salary)-(2023_avg_salary)) is not null


/* 9. You're a database administrator tasked with role-based access control for a company's employee database. Your goal is to implement a security measure where employees
 in different experience level (e.g.Entry Level, Senior level etc.) can only access details relevant to their respective experience_level, ensuring data 
 confidentiality and minimizing the risk of unauthorized access.*/
 
 
 /* 10.	You are working with an consultancy firm, your client comes to you with certain data and preferences such as 
( their year of experience , their employment type, company location and company size )  and want to make an transaction into different domain in data industry
(like  a person is working as a data analyst and want to move to some other domain such as data science or data engineering etc.)
your work is to  guide them to which domain they should switch to base on  the input they provided, so that they can now update thier knowledge as  per the suggestion/.. 
The Suggestion should be based on average salary.*/

DELIMITER //
create PROCEDURE GetAverageSalarie(IN exp_lev VARCHAR(2), IN emp_type VARCHAR(3), IN comp_loc VARCHAR(2), IN comp_size VARCHAR(2))
BEGIN
    SELECT job_title, experience_level, company_location, company_size, employment_type, ROUND(AVG(salary), 2) AS avg_salary 
    FROM salaries 
    WHERE experience_level = exp_lev AND company_location = comp_loc AND company_size = comp_size AND employment_type = emp_type 
    GROUP BY experience_level, employment_type, company_location, company_size, job_title order by avg_salary desc ;
END//
DELIMITER ;
-- Deliminator  By doing this, you're telling MySQL that statements within the block should be parsed as a single unit until the custom delimiter is encountered.

call GetAverageSalary('EN','FT','AU','M');


drop procedure Getaveragesalary