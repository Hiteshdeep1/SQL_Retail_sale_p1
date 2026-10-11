
--Sql retail sales analysis -p1

Create table retail_sales
    (
     transactions_id	int primary key ,
      sale_date date,	
       sale_time time,	
        customer_id	 int,
         gender varchar (15),	
          age	int,
           category varchar (15),	
            quantiy int,	
             price_per_unit float	,
              cogs	float,
               total_sale float



     )


alter table   retail_sales rename column quantiy to quantity ;
	 select * from retail_sales order by category asc

	select * from retail_sales;

	 select Count(*) from retail_sales



	 select * from retail_sales
	 where transactions_id is NUll;

	 select * from retail_sales
	 where sale_date is NUll;

	 select * from retail_sales
	 where sale_time is NUll;


	 select * from retail_sales
	 where 
	  transactions_id is NUll
	 or
	  sale_date is NUll
	  or
	  sale_time is NUll
	  or
	  gender is NULL
	  or
	  category is NULL
	  or
	  
	  cogs is NULL
	  or 
	  total_sale is NULL 
 -- DATA AXPLORATION 
 

	 DELETE FROM RETAIL_SALES
	 WHERE TRANSACTIONS_ID = 673;
	  DELETE FROM RETAIL_SALES
	 WHERE TRANSACTIONS_ID = 746;
	  DELETE FROM RETAIL_SALES
	 WHERE TRANSACTIONS_ID = 1225;


	 SELECT COUNT(*) FROM RETAIL_SALES;
SELECT * FROM RETAIL_SALES;


	 -- HOW MANY UNIQUE CUSTOMER DO WE HAVE ?
	 
	 SELECT COUNT(DISTINCT CUSTOMER_ID) FROM RETAIL_SALES;

	 

	 SELECT DISTINCT CATEGORY AS TOTAL_COUNT FROM RETAIL_SALES;

   - GROUP BY CATEGORY 

	  SELECT CATEGORY, COUNT (*) AS GROUP_CATEGORY
	  FROM RETAIL_SALES
	  GROUP BY CATEGORY 
	  HAVING COUNT(*)>1


	   SELECT GENDER,COUNT(*) AS GENDER_COUNT
	   FROM RETAIL_SALES
	   GROUP BY GENDER 
	   HAVING COUNT(*)>1;

	   --DATA ANALYSIS  & BUISNESS KEY PROBLEM AND ANSWERS 

	   /*

	   Q1- Write a sql querry to retrive  all column from sales made on '2022-11-05'?
	   Q2- Write a sql querry to retrive  all transection where the category is "clothing" and the quantity 
	       sold is more then 10 in the month of nov-2022    
	   Q3- Write a sql querry to to calculate the total sales (total_sales) for each category?
	   Q4-Write a sql querry to find the average age of customer who purchases item from the 'Beautyu' category?
	   Q5- Write a sql querry to find all the transection where the total_sales is greater then 1000?
	   Q6- Write a sql querry to find the total number of transection (transections_id) made by each gender in each category .4
	   Q7- Write a sql querry to average sale of each month find out best best selling month in each year .
	   Q8- Write a sql querry to find the top 5 customer bases on the highest total sales ?
	   Q9- Write a sql querry to find teh number unique customer who purchased item om each category ?
	   10- Write a sql querry to  create each shift d number or order (explain morning <=12, afternoon between 12&17, evening >17)
	   */
	   
	 select * from retail_sales
	 where sale_date  ='2022-11-05' ;


--Q2- Write a sql querry to retrive  all transection where the category is "clothing" and the quantity 
	--sold is more then 4 in the month of nov-2022    
		   
	 select *
	 from retail_sales
	 where category ='Clothing'
	 and 
	 to_char(sale_date, 'yyyy-mm')='2022-11'
	 AND
	 quantity >= 4
	


	 
--Q3- Write a sql querry to calculate the total sales (total_sales) for each category?


select category, sum(total_sale) as net_sale,	
count(*) as total_order
from retail_sales
group by category 

--Q4-Write a sql querry to find the average age of customer who purchases item from the 'Beautyu' category?



select round(avg(age),2) as customeravg_age from retail_sales
where category ='Beauty'



--Q5- Write a sql querry to find all the transection where the total_sales is greater then 1000?

select * from retail_sales


 select * from retail_sales
 where total_sale>1000


 -- Q6- Write a sql querry to find the total number of transection (transections_id) made by each gender in each category.


select 
     category,
	 gender,
	 count(*) as total_transactions
	 from retail_sales
	 group by 
	 category,
	 gender
	 order  by 1 


	 --Q7- Write a sql querry to average sale of each month find out best best selling month in each year .


    select 
	year,
	month,
     avg_sale
	from 
	(

	 select 
	EXTRACT(YEAR FROM SALE_DATE)  as year,
		EXTRACT(month FROM SALE_DATE)  as month,
	 avg(total_sale)  as agv_sale,
	 rank() over (partition by EXTRACT(YEAR FROM sale_date) order by avg(total_sale) desc ) as rank
	 from retail_sales
		group by  1,2
	
		) as  t1
		where rank =1



		--Q8- Write a sql querry to find the top 5 customer bases on the highest total sales ?

          select customer_id,
		  sum(total_sale) as total_sale
		  from retail_sales
		  group by customer_id
		  order by total_sale desc limit 5 


		  --Q9- Write a sql querry to find the number unique customer who purchased item om each category ?
		  select * from retail_sales

		 select 
		 category ,
		 count (distinct Customer_id) as cnt_unique_cs
		 from retail_sales
		 group by category
		 having  count (distinct Customer_id)>1



--10- Write a sql querry to  create each shift d number or order (explain morning <12, afternoon between 12&17, evening >17)

with hourly_sale
as
(
            select *,
                     case
					 when extract(hour from sale_time)<12 then 'morning'
					 when extract(hour from sale_time)between 12 and 17 then 'afternoon'
					 else 'evening'
					  end  as shift
                     from retail_sales



)
     select  
	      shift,
	      count (*) as   total_orders
	 from hourly_sale
        group by shift 

		--End of project 
				 
	 




     

	 
	 




	 

	 






	 