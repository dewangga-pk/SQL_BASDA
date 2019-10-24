--Transact SQL

--Program 1

declare
	@bil1 int,
	@bil2 int,
	@selisih int
begin
	select @bil1 = 10
	select @bil2 = 15
	select @selisih = @bil1-@bil2
	print @selisih
	if @bil1>=@bil2
		begin
		print('Bilangan 1 lebih atau sama dengan bilangan 2')
		print('Selisih antara bilangan 1 dan bilangan 2 bernilai positif :'+str(@selisih))
		end
	else
		begin
		print('Bilangan 1 kurang atau sama dari bilangan 2')
		print('Selisih antara bilangan 1 dan bilangan 2 bernilai negatif :'+str(@selisih))
		end
end

--Program 2
use Northwind
declare 
	@emp int,
	@totalpenjualan money,
	--No.3
	@totalpenjualanid4 money,
	@selisihtotal money
begin
	select @emp = 1

	select @totalpenjualan = SUM(od.Quantity*od.UnitPrice)
	from Orders o,[Order Details] od
	where o.OrderID=od.OrderID and o.EmployeeID=1

	print'total penjualan emp dengan id 1 ='+str(@totalpenjualan)
	--No.3
	select @totalpenjualanid4 = SUM(od.Quantity*od.UnitPrice)
	from Orders o,[Order Details] od
	where o.OrderID=od.OrderID and o.EmployeeID=4
	
	select @selisihtotal = @totalpenjualan-@totalpenjualanid4
	print'selisih total penjualan id 1 dengan id4 adalah :'+str(@selisihtotal)
end

--Program 3
declare 
	@emp int,
	@totalpenjualan money,
	@empMax int
begin
	select @emp = 1
	select @empMax= MAX(EmployeeID)
	from Orders
	while(@emp<=@empMax)
	begin
		select @totalpenjualan = SUM(od.Quantity*od.UnitPrice)
		from Orders o,[Order Details] od
		where o.OrderID=od.OrderID and EmployeeID=@emp

		print'penjualan employee dengan id'+str(@emp)+'adalah'+str(@totalpenjualan)
		select @emp=@emp+1
	end
end

--Program 4
if OBJECT_ID('DBO.program1','V') IS NOT NULL
drop view DBO.program1;

go
create view program1
as
select s.CompanyName as pemasok,p.ProductName,p.UnitPrice
from Suppliers s join Products p on (s.SupplierID=p.SupplierID)
go

select*from program1

--Program 4 No 10
if OBJECT_ID('DBO.program1','V') IS NOT NULL
drop view DBO.program1;

go
create view program1
as
select s.CompanyName,COUNT(p.ProductName) as banyakproduct
from Suppliers s join Products p on (s.SupplierID=p.SupplierID)
group by s.CompanyName
go

select*from program1

--Program 4 No 11
if OBJECT_ID('DBO.program1','V') IS NOT NULL
drop view DBO.program1;

go
create view program1
as
select c.CustomerID,c.CompanyName,COUNT(o.CustomerID) as banyakorder
from Customers c join Orders o on (c.CustomerID=o.CustomerID)
group by c.CustomerID,c.CompanyName 
go

select*from program1

--Program 4 No.12
select 
from program1