use [Online Retail]
select top 3 * from Online_Retail

-------q01- What is the total sales revenue for the entire dataset?
select 
sum(Quantity*UnitPrice) as TotalRevenue
from Online_Retail

--------- q02 - What is the sales trend by month?
select
year(InvoiceDate) as SalesYear,
month(InvoiceDate) as SalesMonth,
sum(Quantity*UnitPrice) as MonthlyRevenue
from Online_Retail
where year(InvoiceDate) is not null and month(InvoiceDate) is not null
group by year(InvoiceDate) , month(InvoiceDate)
order by SalesYear,SalesMonth;

---------- q03 - Which countries generate the highest revenue (excluding the UK)?
select top 10 Country,
sum(Quantity * UnitPrice) as Revenue
from Online_Retail
where Country <> 'United Kingdom'
group by Country 
order by Revenue desc;

---------- q04 - Who are the top 10 customers by revenue?
select top 10 
CustomerID,
sum(Quantity*UnitPrice) as Revenue
from Online_Retail
where CustomerID is not null
group by CustomerID
order by Revenue desc;

-------- q05 - Which products are sold the most (by quantity)?
select top 10 
Description,
sum(Quantity) as TotalQuantity
from Online_Retail
group by Description
order by TotalQuantity desc;

-------- q06 - Which products generate the most revenue?
select top 10 
Description,
sum(Quantity*UnitPrice) as Revenue
from Online_Retail
group by Description
order by Revenue desc;

-------- q07 - What is the average revenue per order (InvoiceNo)?
select 
avg(OrderTotal) as AverageOrderValue
from (select InvoiceNo,sum(Quantity*UnitPrice) as OrderTotal
from Online_Retail
group by InvoiceNo
) as Orders;

--------- q08 - How many orders were cancelled?
select count(distinct InvoiceNo) as CancelledOrders
from Online_Retail
where InvoiceNo like 'C%';

----------- q09 - How much revenue was lost due to cancelled orders?
select sum(Quantity*UnitPrice) as LostRevenue
from Online_Retail
where InvoiceNo like 'C%';

----------- q10 - How many purchases does each customer make?
select CustomerID,
count(distinct InvoiceNo) as NumPurchases
from Online_Retail
where CustomerID is not null
group by CustomerID
order by NumPurchases desc;

---------- q11- Which day of the week has the highest sales?
select DATENAME(weekday,InvoiceDate) as DayOfWeek,
sum(Quantity*UnitPrice) as Revenue
from Online_Retail
where DATENAME(weekday,InvoiceDate) is not null
group by DATENAME(weekday,InvoiceDate) 
order by Revenue desc;

---------- q12 - What is the average revenue per customer?
select avg(CustomerRevenue) as AvgRevenuePerCustomer
from (select CustomerID, sum(Quantity*UnitPrice) as CustomerRevenue
from Online_Retail
where CustomerID is not null
group by CustomerID
) as CustomerTotal;

