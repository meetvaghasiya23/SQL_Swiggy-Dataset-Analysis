-- Q1) How many restaurants have the rating Greater than  4.5 ?
Select 
	count(distinct restaurant_name) as high_rated_restaurants 
from swiggy 
where rating > 4.5;

-- Q2) Which is the Top 1 City with the highest Number of restaurants ?
Select
	city, 
	count(distinct restaurant_name) as No_of_restaurant 
from swiggy 
group by city 
order by No_of_restaurant desc
limit 1;

-- Q3) How many Restaurants have the word "Pizza" in their name ?

Select
	count(distinct restaurant_name) as Pizza_Restaurnats_Count
from swiggy
where restaurant_name like "%Pizza%";

-- Q4) What is the most common cuisine among the restaurants in the dataset ?

select
	cuisine,
    count(*) as cuisine_count
from swiggy
group by cuisine
order by cuisine_count desc
limit 1;

-- Q5) What is the average rating of restaurants by city ?

Select
	city,
    avg(rating) as average_rating
from swiggy
group by city;

-- Q6) What is the highest price of item under the recommended Menu category for each restaurant ?

Select 
	distinct restaurant_name,
	menu_category,
	max(price) as highestprice 
from swiggy
where menu_category = "Recommended"
group by restaurant_name, menu_category;

-- Q7) Find the TOP 5 Most Expensive Restaurants that offer cuisine other than Indian Cuisine ?

Select 
	distinct restaurant_name,
	cost_per_person
from swiggy
where cuisine <> "Indian"
order by cost_per_person desc
limit 5;

-- Q8) Find the restaurants that have an average cost which is higher than the total average cost of all restaurants together ?

Select 
	distinct restaurant_name,
    cost_per_person
from swiggy
where cost_per_person > (Select avg(cost_per_person) from swiggy);

-- Q9) Retrieve the details of restaurants that have the same name but are located in different cities ?

Select 
	distinct t1.restaurant_name, 
	t1.city ,
	t2.city 
from swiggy t1 
join swiggy t2 
on 
	t1.restaurant_name = t2.restaurant_name and t1.city <> t2.city;
    
-- Q10) Which Restaurant offers the most number of items in the main course category ?

Select
	distinct restaurant_name,
	menu_category,
	count(item) as no_of_items
from swiggy
where menu_category = "Main Course"
group by restaurant_name, menu_category
order by no_of_items desc
limit 1;

-- Q11) List the names of restaurants that are 100% vegetarian  in alphabetical order of restaurant name ?

Select 
	distinct restaurant_name, 
	(count(case when veg_or_nonveg = "Veg" then 1 end)*100/ count(*)) as vegetarian_percentage
 from swiggy 
 group by restaurant_name
 having vegetarian_percentage = 100.00
 order by restaurant_name;

-- Q12) Which is the restaurant providing the lowest average price for all items ?

Select 
	distinct restaurant_name,
	avg(price) as average_price
from swiggy
group by restaurant_name
order by average_price
limit 1;

-- Q13) Which top 5 restaurants offeres highest number of categories ?

Select 
	distinct restaurant_name,
	count(distinct menu_category) as no_of_category
from swiggy
group by restaurant_name
order by no_of_category desc
limit 5;

-- Q14) Which restaurant provides the highest percentage of non-veg food ?

Select 
	distinct restaurant_name,
	(count(case when veg_or_nonveg = "Non-Veg" then 1 end)* 100/count(*)) as Non_Veg_Percent
from swiggy
group by restaurant_name
order by Non_Veg_Percent desc
limit 1;
