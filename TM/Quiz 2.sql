use pubs

--no1
select title,title_id
from titles
where price>20
Intersect
select title_id
from titleauthor
where RIGHT(CONVERT(int,au_id))%2 = 0


select

--no2
select (fname+' '+lname) as [nama lengkap]
from employee 
where  job_id in(
	select j.job_id
	from jobs j
	where j.job_desc='Publisher'
)

select*From jobs
where job_id=5