--Q 1.1

select sum(extendedprice*discount) as revenue
from nlineorder
where year = 1993
and discount between 1 and 3
and quantity < 25;

--Q 2.1
 
select sum(revenue), year, brand1
from nlineorder
where category = 'MFGR#12'
and suppregion = 'AMERICA'
group by year, brand1
order by year, brand1;

--Q 3.1
 
select nation, suppnation, year, sum(revenue) as revenue 
from nlineorder
where region = 'ASIA' and suppregion = 'ASIA'
and year >= 1992 and year <= 1997
group by nation, suppnation, year
order by year asc, revenue desc; 

--Q 4.1
 
select year, nation, sum(revenue - supplycost) as profit 
from nlineorder
where region = 'AMERICA'
and suppregion = 'AMERICA'
and (mfgr = 'MFGR#1' or mfgr = 'MFGR#2')
group by year, nation
order by year, nation;