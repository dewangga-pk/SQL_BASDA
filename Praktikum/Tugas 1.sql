use pubs
--No.1
select p.pub_name,t.title,s.qty
from publishers p join titles t
on p.pub_id = t.pub_id
join sales s on t.title_id = s.title_id
where (p.pub_id%2 = 0) and (s.qty between 30 and 55)
--No.2
select s.stor_name,t.title
from stores s join sales sa on s.stor_id=sa.stor_id
join titles t on sa.title_id=t.title_id
where (s.state = 'CA') and (t.title like '%S')
