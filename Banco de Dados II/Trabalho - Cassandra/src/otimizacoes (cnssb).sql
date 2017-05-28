--1.1

create materialized view v1 as 
select discount, year, quantity, orderkey, linenumber, extendedprice
from nlineorder
where year = 1993 
and quantity < 25
and orderkey is not null
and linenumber is not null
and discount is not null
primary key (discount, quantity, orderkey, linenumber, year);

--2.1

create materialized view v2 as 
select revenue, year, quantity, orderkey, linenumber, brand1
from nlineorder
where quantity is not null
and year is not null
and orderkey is not null
and linenumber is not null
and brand1 is not null
and category = 'MFGR#12'
and suppregion = 'AMERICA'
primary key ((year, brand1), quantity, orderkey, linenumber);

--3.1

create materialized view v3 as 
select nation, suppnation, year, quantity, orderkey, linenumber, revenue
from nlineorder
where quantity is not null
and year is not null
and orderkey is not null
and linenumber is not null
and nation is not null
and suppnation is not null
and region = 'ASIA'
and suppregion = 'ASIA'
and year >= 1992
and year <= 1997
primary key ((nation,year), quantity, orderkey, linenumber);

--4.1

create materialized view v4 as 
select nation, year, quantity, orderkey, linenumber, revenue, supplycost
from nlineorder
where quantity is not null
and year is not null
and orderkey is not null
and linenumber is not null
and nation is not null
and region = 'AMERICA'
and suppregion = 'AMERICA'
and mfgr <= 'MFGR#2'
primary key ((year, nation), quantity, orderkey, linenumber);