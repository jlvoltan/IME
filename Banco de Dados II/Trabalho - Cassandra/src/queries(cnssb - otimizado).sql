--Q 1.1

select sum(extendedprice*discount) as revenue
from v1
where discount in (1,2,3);

--Q 2.1
 
select sum(revenue), year, brand1
from v2
group by year, brand1
order by year, brand1;

--Q 3.1
 
select nation, suppnation, year, sum(revenue) as revenue 
from v3
group by nation, year, suppnation
order by year asc, revenue desc; 

--Q 4.1
 
select year, nation, sum(revenue - supplycost) as profit 
from v4
group by year, nation
order by year, nation;