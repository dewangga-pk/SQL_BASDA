use northwind
--Modul 2 SUBQUERY DAN OPERASI HIMPUNAN
--In not IN PUNYA ERSANDY

--8
select top 5 e.EmployeeID
from Employees e 
join Orders o on e.EmployeeID = o.EmployeeID
join [Order Details] od on o.OrderID = od.OrderID
group by e.EmployeeID
order by sum (od.Quantity*od.UnitPrice) desc

--9
select o.OrderID
from Orders o
where employeeID in
(select top 5 EmployeeID  from Orders o join [Order Details] od
on o.OrderID=od.OrderID
group by o.EmployeeID
order by SUM(od.Quantity*od.UnitPrice) desc)

--10
select top 1 s.ShipperID
from Shippers s 
join Orders o on s.ShipperID = o.ShipVia
group by s.ShipperID
order by count(o.ShipVia) desc
--10 (Sub Query)
select s.ShipperID
from Shippers s
where s.ShipperID in
(select top 1 ShipperID
from Orders o join Shippers s on o.ShipVia=s.ShipperID
group by s.ShipperID
order by COUNT(o.OrderID)desc)

--11
select s.CompanyName,o.OrderID
from Shippers s join orders o
on s.ShipperID=o.ShipVia
where s.ShipperID not in
(select top 1 ShipperID
from Orders o join Shippers s on o.ShipVia=s.ShipperID
group by ShipperID
order by COUNT(o.OrderID)desc)

--12
select p.ProductID,p.ProductName,p.UnitPrice
from Products p
where p.UnitPrice>(select AVG(p.UnitPrice) from products p)

--Subquery exist dan not exist

--5
select ProductID,ProductName
from Products
where exists(
	select UnitPrice
	from Products
	where UnitPrice>75
)
--6
select p.ProductID,p.ProductName
from Products p join Categories c on p.CategoryID=c.CategoryID 
where c.CategoryName='beverages' and exists(
	select Quantity
	from [Order Details]
	where Quantity>100
)
--7
select EmployeeID,(FirstName+''+LastName) as Nama
from Employees
where Country='UK' and exists(
	select EmployeeID,DATEDIFF(YY,BirthDate,GETDATE()),Country
	from Employees
	where DATEDIFF(YY,BirthDate,GETDATE())>60 and Country='UK'
)
--8
select EmployeeID,(FirstName+''+LastName) as Nama
from Employees
where Country='UK' and not exists(
	select e.EmployeeID,SUM(od.UnitPrice)
	from Employees e join Orders o on e.EmployeeID=o.EmployeeID
	join [Order Details] od on o.OrderID=od.OrderID
	where e.Country='UK'
	group by e.EmployeeID
	having SUM(od.UnitPrice)>200
)
--Subquery any dan all
--4
select EmployeeID,(FirstName+''+LastName) as Nama
from Employees
where Country='USA' and DATEDIFF(YY,BirthDate,GETDATE())>all(
	select DATEDIFF(YY,BirthDate,GETDATE())
	from Employees
	where Country='UK'
)
--5
select EmployeeID,(FirstName+''+LastName) as Nama
from Employees
where Country='USA' and DATEDIFF(YY,BirthDate,GETDATE())>any(
	select DATEDIFF(YY,BirthDate,GETDATE())
	from Employees
	where Country='UK'
)
--6 
select e.EmployeeID,(e.FirstName+''+e.LastName) as Nama,SUM((od.UnitPrice*Quantity)*(1-od.Discount))
from Employees e join Orders o on e.EmployeeID=o.EmployeeID
join [Order Details] od on o.OrderID=od.OrderID
where e.Country='USA'
group by e.EmployeeID,(e.FirstName+''+e.LastName)
having SUM((od.UnitPrice*Quantity)*(1-od.Discount))>all(
	select SUM((od.UnitPrice*Quantity)*(1-od.Discount))
	from Employees e join Orders o on e.EmployeeID=o.EmployeeID
	join [Order Details] od on o.OrderID=od.OrderID
	where e.Country='UK'
	group by e.EmployeeID
) 
--7
select e.EmployeeID,(e.FirstName+''+e.LastName) as Nama,SUM((od.UnitPrice*Quantity)*(1-od.Discount))
from Employees e join Orders o on e.EmployeeID=o.EmployeeID
join [Order Details] od on o.OrderID=od.OrderID
where e.Country='USA'
group by e.EmployeeID,(e.FirstName+''+e.LastName)
having SUM((od.UnitPrice*Quantity)*(1-od.Discount))>any(
	select SUM((od.UnitPrice*Quantity)*(1-od.Discount))
	from Employees e join Orders o on e.EmployeeID=o.EmployeeID
	join [Order Details] od on o.OrderID=od.OrderID
	where e.Country='UK'
	group by e.EmployeeID
)
--Union
--7
(select p.ProductID,p.ProductName,p.UnitPrice
from Products p join Categories c on(p.CategoryID=c.CategoryID)
where c.CategoryName='Seafood')
union
(select p.ProductID,p.ProductName,p.UnitPrice
from Products p join Suppliers s on(p.SupplierID=s.SupplierID)
where s.Country='Japan')
--8
(select p.ProductID,p.ProductName,p.UnitPrice
from Products p join Categories c on(p.CategoryID=c.CategoryID)
where c.CategoryName='Seafood')
union
(select p.ProductID,p.ProductName,p.UnitPrice
from Products p
where p.UnitPrice>all(
		select AVG(UnitPrice)
		from Products
	)
)
--9
(select e.EmployeeID,(e.FirstName+' '+e.LastName) as nama
from Employees e join Orders o on(e.EmployeeID=o.EmployeeID)
join [Order Details] od on (o.OrderID=od.OrderID)
group by e.EmployeeID,(e.FirstName+' '+e.LastName)
having SUM((od.UnitPrice*Quantity)*(1-od.Discount))>1000)
union
(select e.EmployeeID,(e.FirstName+' '+e.LastName) as nama
from Employees e join Orders o on(e.EmployeeID=o.EmployeeID)
join [Order Details] od on (o.OrderID=od.OrderID)
group by e.EmployeeID,(e.FirstName+' '+e.LastName)
having SUM(od.Quantity)>100)

--10
(select s.SupplierID,s.CompanyName
from Suppliers s join Products p on(s.SupplierID=p.SupplierID)
group by s.SupplierID,s.CompanyName
having COUNT(p.SupplierID)>5)
union
(select s.SupplierID,s.CompanyName
from Suppliers s join Products p on(s.SupplierID=p.SupplierID)
where p.UnitPrice>100)

--Intersect dan except
--5
(select p.ProductID,p.ProductName
from Products p join Categories c on(p.CategoryID=c.CategoryID)
where c.CategoryName='Seafood')
intersect
(select p.ProductID,p.ProductName
from Products p join Suppliers s on(p.SupplierID=s.SupplierID)
where s.Country='Japan')
--6
(select e.EmployeeID,(e.FirstName+' '+e.LastName) as nama
from Employees e join Orders o on(e.EmployeeID=o.EmployeeID)
join [Order Details] od on (o.OrderID=od.OrderID)
group by e.EmployeeID,(e.FirstName+' '+e.LastName)
having SUM(od.Quantity)>100)
intersect
(select e.EmployeeID,(e.FirstName+' '+e.LastName) as nama
from Employees e join Orders o on(e.EmployeeID=o.EmployeeID)
join [Order Details] od on (o.OrderID=od.OrderID)
group by e.EmployeeID,(e.FirstName+' '+e.LastName)
having SUM((od.UnitPrice*Quantity)*(1-od.Discount))>1000)
--7
(select p.ProductID,p.ProductName,p.UnitPrice
from Products p join Categories c on(p.CategoryID=c.CategoryID)
where c.CategoryName='beverages')
except
(select p.ProductID,p.ProductName,p.UnitPrice
from Products p
where p.UnitPrice<(
		select AVG(UnitPrice)
		from Products
	)
)
--8
(select c.CustomerID,c.CompanyName
from Customers c join Orders o on(c.CustomerID=o.CustomerID)
group by c.CustomerID,c.CompanyName
having COUNT(o.CustomerID)>5)
except
(select c.CustomerID,c.CompanyName
from Customers c 
where c.Country='Germany')
--9
(select s.CompanyName
from Shippers s join Orders o on(s.ShipperID=o.ShipVia)
group by s.CompanyName
having COUNT(o.ShipVia)>5)
intersect
(select s.CompanyName
from Shippers s join Orders o on(s.ShipperID=o.ShipVia)
join [Order Details] od on(o.OrderID=od.OrderID)
group by s.CompanyName
having SUM((od.UnitPrice*Quantity)*(1-od.Discount))>1000)
--10
(select e.EmployeeID,(e.FirstName+' '+e.LastName) as nama
from Employees e join Orders o on(e.EmployeeID=o.EmployeeID)
group by e.EmployeeID,(e.FirstName+' '+e.LastName)
having COUNT(o.EmployeeID)>10)
intersect
(select e.EmployeeID,(e.FirstName+' '+e.LastName) as nama
from Employees e join Orders o on(e.EmployeeID=o.EmployeeID)
group by e.EmployeeID,(e.FirstName+' '+e.LastName)
having COUNT(o.CustomerID)>3)
--11
(select s.SupplierID
from Suppliers s join Products p on(s.SupplierID=p.SupplierID)
group by s.SupplierID
having count(p.SupplierID)>10)
except
(select s.SupplierID
from Suppliers s join Products p on(s.SupplierID=p.SupplierID)
group by s.SupplierID
having count(p.CategoryID)=1)
--12
(select s.ShipperID,s.CompanyName
from Shippers s join Orders o on(s.ShipperID=o.ShipVia)
join [Order Details] od on(o.OrderID=od.OrderID)
group by s.ShipperID,s.CompanyName
having count(od.ProductID)>5)
except
(select s.ShipperID,s.CompanyName
from Shippers s join Orders o on(s.ShipperID=o.ShipVia)
where o.ShipCountry='USA')