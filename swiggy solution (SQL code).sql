use swiggy;

-- Clean the 'orders' table

alter table orders
modify column date date;

desc orders;

-- Qus 1: Find customers who have never ordered.

select user_id, name
from users
where user_id not in (select user_id from orders);


-- Qus 2: Average price per dish.

select a.f_name, round(avg(b.price)) as Avg_price
from food a
inner join menu b on a.f_id = b.f_id
group by a.f_name;

-- Qus 3: Find top restaurants in terms of number of orders for a given month.

select a.r_name as 'Restaurant', month(b.date) as 'Month', count(b.order_id) as 'Total Orders'
from restaurants a
inner join orders b on a.r_id = b.r_id
group by a.r_name, month(b.date)
order by month(b.date), 'Total Orders';

-- Qus 4: Restaurants with monthly sales more than x for

-- For this question let's consider x=500.

select a.r_name as 'Restaurant', month(b.date) as 'Month', sum(b.amount) as Revenue
from restaurants a
inner join orders b on a.r_id = b.r_id
group by a.r_name, month(b.date)
having Revenue>500
order by month(b.date), Revenue desc;

-- Qus 5: Show all orders with order details for a particular customer in a particular date range.

-- For this question let's pull out the order details for 'Nitish' between 10 June 2022 and 10 July 2022.

select a.name, b.date, c.r_name as 'Restaurant', e.f_name as 'Food name', count(b.order_id) as Total_orders, sum(b.amount) as Money_spent
from users a
inner join orders b on a.user_id = b.user_id
inner join restaurants c on b.r_id = c.r_id
inner join order_details d on b.order_id = d.order_id
inner join food e on d.f_id = e.f_id
where a.name like '%Nitish%' and b.date between '2022-06-10' and '2022-07-10'
group by a.name, b.date, c.r_name, e.f_name
order by b.date;

-- Qus 6: Find restaurants with maximum repeated customers.

select d.r_name as 'Restaurant', count(c.Visits) as Repeated_customers from
(select r_id, user_id, count(order_id) as Visits
from orders
group by r_id, user_id
having Visits> 1) c
inner join restaurants d on c.r_id = d.r_id
group by d.r_name
order by Repeated_customers desc
limit 1;

-- Qus 7: Month over month revenue growth of Swiggy.

select c.*, c.Revenue - c.prv_month_rev as 'MoM_Revenue' from
(select month(date) as 'Month', sum(amount) as Revenue, lag(sum(amount), 1) over() as prv_month_rev
from orders
group by month(date)
order by month(date)) c;

-- Qus 8: Favorite food of each customer.

select e.user_id, e.name, e.`Food name`, e.Total_orders from
(select a.user_id, b.name, d.f_name as 'Food name', count(a.order_id) as Total_orders, dense_rank() over(partition by a.user_id order by count(a.order_id) desc) as rnk
from orders a
inner join users b on a.user_id = b.user_id
inner join order_details c on a.order_id = c.order_id
inner join food d on c.f_id = d.f_id
group by a.user_id, b.name, d.f_name
order by a.user_id, Total_orders desc) e
where e.rnk = 1;

-- Qus 9: Find most loyal customers for all restaurants.

select c.Restaurant, count(Visits) as Loyal_customers from
(select a.user_id, a.r_id, b.r_name as 'Restaurant', count(a.order_id) as Visits
from orders a
inner join restaurants b on a.r_id = b.r_id
group by a.user_id, a.r_id, b.r_name
having count(a.order_id) > 1
order by a.user_id, Visits desc) c
group by c.Restaurant
order by Loyal_customers desc;

-- Qus 10: Month over month revenue growth of each restaurant.

select c.*, concat(round(((c.Revenue - c.prv_month_rev)/c.prv_month_rev)*100, 2),'%') as 'MoM_growth' from
(select month(date) as 'Month', sum(amount) as Revenue, lag(sum(amount), 1) over() as prv_month_rev
from orders
group by month(date)
order by month(date)) c;

-- Qus 11: Most paired products.

select f1.f_name as product1, f2.f_name as product2, count(*) as pair_counts
from order_details od1
inner join order_details od2 on od1.order_id = od2.order_id and od1.f_id < od2.f_id
inner join food f1 on od1.f_id = f1.f_id
inner join food f2 on od2.f_id = f2.f_id
group by f1.f_name, f2.f_name
order by pair_counts desc
limit 1;

