-- Retrieve the total number of orders placed.

Select count(order_id) as Total_Orders from Orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(Order_details.quantity * pizzas.price),
            2) AS Total_Sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
-- Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY Pizzas.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

 -- List the top 5 most ordered pizza types along with their quantities.
 
 SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

Select pizza_types.category,
Sum(order_details.quantity) as quantity
From pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity desc;

-- Determine the distribution of orders by hour of the day.

Select hour(order_time)as hour , count(order_id) from orders as Order_count
group by hour (order_time);


-- Join relevant tables to find the category-wise distribution of pizzas.

Select category, count(name) from  pizza_types
group by category;



--  Group the orders by date and calculate the average number of pizzas ordered per day.

Select round(avg (quantity), 0) as AVG_Pizza_Order_perday from 
(Select orders.order_date, Sum(order_details.quantity) as quantity 
From orders join order_details
on orders.order_id	=  order_details.order_id
group by orders.order_date) as order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.

Select pizza_types.name,
Sum(order_details.quantity * pizzas.price) as Revenue
from pizza_types join Pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by Revenue desc limit 3;

-- Calculate the percentage contribution of each pizza type to total revenue.

