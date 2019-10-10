use Northwind
select Country, COUNT(*) as Banyak
from Employees
group by Country

--10
select e.EmployeeID, (FirstName+' '+LastName) as nama, sum(ord.Quantity) as jumlah
from Employees e join Orders o on e.EmployeeID = o.EmployeeID
join [Order Details] ord on o.OrderID=ord.OrderID 
group by e.EmployeeID,(FirstName+' '+LastName)
 

-- 12 
select e.EmployeeID, e.FirstName+e.LastName as Nama, count (p.UnitsInStock) as banyaknyabarang
from Employees e join Orders o 
on e.EmployeeID=o.EmployeeID
join [Order Details] od
on od.orderID=o.orderID
join Products p
on p.productID=od.productID
group by e.EmployeeID, e.FirstName+e.LastName

--13
select e.EmployeeID, e.FirstName+e.LastName as Nama, Max (od.UnitPrice) as HargaTermahal
from Employees e join Orders o 
on e.EmployeeID=o.EmployeeID
join [Order Details] od
on od.orderID=o.orderID
join Products p
on p.productID=od.productID
group by e.EmployeeID, e.FirstName+e.LastName

--14. 
select c.CustomerID, c.CompanyName as NamaPerusahaan, count (p.UnitsInStock) as banyaknyabarang
from Customers c join Orders o 
on c.CustomerID=o.CustomerID
join [Order Details] od
on od.orderID=o.orderID
join Products p
on p.productID=od.productID
group by c.CustomerID,c.CompanyName

--15
select c.CustomerID, c.CompanyName as NamaPerusahaan, sum (od.Quantity*od.UnitPrice) as Totalnilai
from Customers c join Orders o 
on c.CustomerID=o.CustomerID
join [Order Details] od
on od.orderID=o.orderID
join Products p
on p.productID=od.productID
group by c.CustomerID,c.CompanyName

--ModulB

--7
Select p.ProductName,count(od.Quantity) as totalbanyakbarang
from Products p join [Order Details] od
on p.ProductID=od.ProductID
where od.UnitPrice>15.00
group by p.ProductName

--8
Select p.ProductName,sum(od.Quantity) as totalbanyakbarangyangterjual
from Products p join [Order Details] od
on p.ProductID=od.ProductID
join Orders o
on o.OrderID=od.OrderID
group by p.ProductName, od.Quantity
having count(o.OrderDate)*od.Quantity>50 

--9
Select p.ProductName,count(od.Quantity) as totalbanyakbarangyangterjual
from Products p join [Order Details] od
on p.ProductID=od.ProductID
join Orders o
on o.OrderID=od.OrderID
join Categories c
on c.CategoryID=p.CategoryID
where c.CategoryName='beverages'
group by p.ProductName,c.CategoryName,od.Quantity
having count(o.OrderDate)*od.Quantity>100

--10
select s.SupplierID,s.CompanyName,COUNT(od.Quantity)
from Suppliers s join Products p
on s.SupplierID=p.SupplierID
join [Order Details] od on p.ProductID=od.ProductID
group by s.SupplierID,s.CompanyName

--11
select s.SupplierID,s.CompanyName,COUNT(od.Quantity)
from Suppliers s join Products p
on s.SupplierID=p.SupplierID
join [Order Details] od on p.ProductID=od.ProductID
where s.Country='Germany'
group by s.SupplierID,s.CompanyName

--12
select s.SupplierID,s.CompanyName,COUNT(od.Quantity)
from Suppliers s join Products p
on s.SupplierID=p.SupplierID
join [Order Details] od on p.ProductID=od.ProductID
where s.Country='Germany'
group by s.SupplierID,s.CompanyName
having COUNT(od.Quantity)>100

select*from Suppliers


--Kerjaanku 
--A
--12
select e.EmployeeID,(e.FirstName+' '+e.LastName) as Nama, SUM(od.Quantity) as BanyakBarang
from Employees e join Orders o on e.EmployeeID=o.EmployeeID
join [Order Details] od on o.OrderID=od.OrderID
group by e.EmployeeID,(e.FirstName+' '+e.LastName)
--13
select e.EmployeeID,(e.FirstName+' '+e.LastName) as Nama, MAX(od.UnitPrice) as HargaTermahal
from Employees e join Orders o on e.EmployeeID=o.EmployeeID
join [Order Details] od on o.OrderID=od.OrderID
group by e.EmployeeID,(e.FirstName+' '+e.LastName)
--14
select c.CustomerID,c.CompanyName,sum(od.Quantity) as BanyakBarang
from Customers c join Orders o on c.CustomerID=o.CustomerID
join [Order Details] od on o.OrderID=od.OrderID
group by c.CustomerID,c.CompanyName
--15
select c.CustomerID,c.CompanyName,SUM((od.UnitPrice*od.Quantity)*(1-od.Discount)) as TotalNilaiBeli
from Customers c join Orders o on c.CustomerID=o.CustomerID
join [Order Details] od on o.OrderID=od.OrderID
group by c.CustomerID,c.CompanyName

--B
--7
select p.ProductName,SUM(od.Quantity) as TotalJualProduct
from Products p join [Order Details] od on p.ProductID=od.ProductID
where p.UnitPrice>15
group by p.ProductName
--8
select p.ProductName,sum(od.Quantity) as BanyakBarang
from Products p join [Order Details] od on p.ProductID=od.ProductID
group by p.ProductName
having sum(od.Quantity)>50
--9
select p.ProductName,sum(od.Quantity) as TotalBarangTerjual
from Products p join [Order Details] od on p.ProductID=od.ProductID
join Categories c on p.CategoryID=c.CategoryID
where c.CategoryName='Beverages'
group by p.ProductName
having sum(od.Quantity)>100
--10
select s.SupplierID,s.CompanyName,sum(od.Quantity) as BanyakBarangTerjual
from Suppliers s join Products p on s.SupplierID=p.SupplierID
join [Order Details] od on p.ProductID=od.ProductID
group by s.SupplierID,s.CompanyName
--11
select s.SupplierID,s.CompanyName,sum(od.Quantity) as BanyakBarangTerjual
from Suppliers s join Products p on s.SupplierID=p.SupplierID
join [Order Details] od on p.ProductID=od.ProductID
where s.Country='Germany'
group by s.SupplierID,s.CompanyName
--12
select s.SupplierID,s.CompanyName,sum(od.Quantity) as BanyakBarangTerjual
from Suppliers s join Products p on s.SupplierID=p.SupplierID
join [Order Details] od on p.ProductID=od.ProductID
where s.Country='Germany'
group by s.SupplierID,s.CompanyName
having sum(od.Quantity)>100