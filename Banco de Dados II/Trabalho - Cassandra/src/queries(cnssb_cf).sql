--Q 1.1

select sum(o.extendedprice*o.discount) as revenue
from cnssb_cf.orderFact o
inner join cnssb_cf.date d on o.dblinenumber = d.dblinenumber
where d.year = 1993
and o.discount between 1 and 3
and o.quantity < 25; 

--Q 2.1
 
select sum(o.revenue), d.year, p.brand1
from cnssb_cf.orderFact o
inner join cnssb_cf.date d on o.dblinenumber = d.dblinenumber
inner join cnssb_cf.part p on o.dblinenumber = p.dblinenumber 
inner join cnssb_cf.supplier s on o.dblinenumber = s.dblinenumber
where p.category = 'MFGR#12'
and s.suppregion = 'AMERICA'
group by d.year, p.brand1
order by d.year, p.brand1;

--Q 3.1
 
select c.nation, s.suppnation, d.year, sum(o.revenue)
as revenue 
from cnssb_cf.orderFact o
inner join cnssb_cf.date d on o.dblinenumber = d.dblinenumber
inner join cnssb_cf.custumer c on o.dblinenumber = c.dblinenumber 
inner join cnssb_cf.supplier s on o.dblinenumber = s.dblinenumber
where c.region = 'ASIA' and s.suppregion = 'ASIA'
and d.year >= 1992 and d.year <= 1997
group by c.nation, s.suppnation, d.year
order by d.year asc, revenue desc; 

--Q 4.1
 
select d.year, c.nation, sum(o.revenue - o.supplycost) as profit 
from cnssb_cf.orderFact o
inner join cnssb_cf.date d on o.dblinenumber = d.dblinenumber
inner join cnssb_cf.custumer c on o.dblinenumber = c.dblinenumber 
inner join cnssb_cf.supplier s on o.dblinenumber = s.dblinenumber
inner join cnssb_cf.part p on o.dblinenumber = p.dblinenumber 
where c.region = 'AMERICA'
and s.suppregion = 'AMERICA'
and (p.mfgr = 'MFGR#1' or p.mfgr = 'MFGR#2')
group by d.year, c.nation
order by d.year, c.nation;