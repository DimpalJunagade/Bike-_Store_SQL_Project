select * from [sales].[order_items]
select * from [production].[categories]
select * from [production].[products]
select * from [sales].[customers]
select * from [sales].[orders]
select * from [sales].[staffs]
 
 create procedure Query1
 as
 begin
select [sales].[orders].order_id,CONCAT([sales].[customers].first_name,' ',[sales].[customers].last_name) Customer_name, 
[sales].[customers].city,[sales].[customers].state,[sales].[orders].order_date,[production].[products].Product_name,
sum([sales].[order_items].quantity) as Totals,sum([sales].[order_items].quantity * [sales].[order_items].list_price) as Total_Revenue,
[production].[categories].category_name,[sales].[stores].store_name,CONCAT([sales].[staffs].first_name,' ',[sales].[staffs].last_name) as Sales_Rep
from [sales].[orders]
join [sales].[customers] 
on [sales].[orders].customer_id=[sales].[customers].customer_id
join [sales].[order_items] 
on [sales].[orders].order_id=[sales].[order_items].order_id
join [production].[products] 
on [sales].[order_items].product_id=[production].[products].Product_id
join [production].[categories] 
on [production].[products].category_id=[production].[categories].category_id
join[sales].[stores] 
on [sales].[stores].store_id=[sales].[orders].store_id
Join [sales].[staffs]
on [sales].[orders].staff_id=[sales].[staffs].staff_id
group by [sales].[orders].order_id,concat([sales].[customers].first_name,' ',[sales].[customers].last_name), [sales].[customers].city,[sales].[customers].state,
[sales].[orders].order_date,
[production].[products].Product_name,[production].[categories].category_name,
[sales].[stores].store_name,concat([staffs].first_name,' ',[sales].[staffs].last_name)
order by 1
end;

exec Query1
