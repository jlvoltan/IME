--1-a)

SELECT p.pname, p.pcod
	FROM sp.p
	WHERE p.pname != 'Nut' AND p.color IN
		(SELECT p.color
			FROM sp.p
			WHERE p.pname = 'Nut');

--1-b)

SELECT P1.pname, P1.pcod
	FROM sp.p P1, sp.p P2
	WHERE P2.pname = 'Nut' AND P1.color = P2.color AND P1.pname != 'Nut';

--2-a)

SELECT DISTINCT P1.pcod, P1.pname
	FROM sp.p P1, sp.p P2
	WHERE P1.color = P2.color AND P1.pcod != P2.pcod
	ORDER BY P1.pcod;

--2-b)

SELECT DISTINCT P1.pcod, P1.pname
	FROM sp.p P1
	WHERE P1.color IN
	(SELECT DISTINCT P2.color
		FROM sp.p P2
		WHERE P1.pcod != P2.pcod )
	ORDER BY P1.pcod;

--3-a)

SELECT DISTINCT P1.color
	FROM sp.p P1
	WHERE P1.weight >= 
	(SELECT AVG(P2.weight)
		FROM sp.p P2);

--3-b)

SELECT DISTINCT P1.color
	FROM sp.p P1, (SELECT AVG(P2.weight) m FROM sp.p P2) AS media
	WHERE P1.weight >= media.m;

--4-a)

SELECT P1.pcod, P1.pname
	FROM sp.p P1
	WHERE P1.weight > ALL
		(SELECT weight
			FROM sp.p
			WHERE color = 'Blue');

--4-b)

SELECT P1.pcod, P1.pname
	FROM sp.p P1, (SELECT MAX(P2.weight) M
				FROM sp.p P2
				GROUP BY P2.color
				HAVING P2.color = 'Blue') MAXIMUM
	WHERE P1.weight > MAXIMUM.M;

--5-a)

SELECT P1.pcod, P1.pname
	FROM sp.p P1
	WHERE P1.weight >
		(SELECT AVG(P2.weight)
			FROM sp.p P2
			WHERE P2.color = P1.color);

--5-b)

SELECT DISTINCT P1.pcod, P1.pname
	FROM sp.p P1, (SELECT AVG(P2.weight) M, P2.color COLOR
				FROM sp.p P2
				GROUP BY P2.color) MEDIA
	WHERE P1.weight > MEDIA.M AND P1.color = MEDIA.COLOR;

--6-a)

SELECT DISTINCT P.city
	FROM sp.p P
INTERSECT
SELECT DISTINCT S.city
	FROM sp.s S;

--6-b)

SELECT DISTINCT S.city
	FROM sp.s S
	WHERE EXISTS 
		(SELECT *
			FROM sp.p P
			WHERE P.city = S.city);

--7-a)

SELECT DISTINCT P.city
	FROM sp.p P
	WHERE NOT EXISTS 
		(SELECT *
			FROM sp.s s
			WHERE P.city = S.city);

--7-b)

SELECT DISTINCT P.city
	FROM sp.p P
EXCEPT
SELECT DISTINCT S.city
	FROM sp.s S;

--8-a)

SELECT DISTINCT S.city
	FROM sp.s S
EXCEPT
SELECT DISTINCT P.city
	FROM sp.p P;

--8-b)

SELECT DISTINCT S.city
	FROM sp.s S
	WHERE NOT EXISTS 
		(SELECT *
			FROM sp.p P
			WHERE P.city = S.city);

--9-a)

SELECT S.scod, S.sname
	FROM sp.s S
	WHERE S.scod =
		(SELECT SP.scod
			FROM sp.sp SP
			GROUP BY SP.scod
			HAVING COUNT(*) = 
				(SELECT COUNT(*)
					FROM sp.p P));

--9-b)

SELECT S.scod, S.sname
	FROM sp.s S, sp.sp SP, sp.p P
	WHERE S.scod = SP.scod AND SP.pcod = P.pcod
	GROUP BY S.scod
	HAVING COUNT(*) = 
		((SELECT COUNT(*)
			FROM sp.p));

--10-a)

SELECT S.scod
	FROM sp.s S
	WHERE S.status =
		(SELECT MAX(status)
			FROM sp.s);

--10-b)

SELECT S.scod
	FROM sp.s S
EXCEPT
SELECT S1.scod
	FROM sp.s S1, sp.s S2
	WHERE S1.status < S2.status;

--11-a)

SELECT S1.sname
	FROM sp.s S1
	WHERE S1.scod =
		(SELECT S.scod
			FROM sp.s S
		EXCEPT
		SELECT SP.scod
			FROM sp.sp SP
			WHERE SP.pcod = 2);

--11-b)

SELECT DISTINCT S.sname
	FROM sp.s S
	WHERE NOT EXISTS
		(SELECT *
			FROM sp.sp SP
			WHERE SP.scod = S.scod AND SP.pcod = 2);

--12-a)

SELECT DISTINCT S.sname, S.scod, P.pname, P.pcod
	FROM sp.s S, sp.p P
	WHERE NOT EXISTS
		(SELECT *
			FROM sp.sp SP
			WHERE SP.scod = S.scod AND SP.pcod = P.pcod);

--12-b)

SELECT DISTINCT S1.sname, S1.scod, P1.pname, P1.pcod
	FROM sp.s S1, sp.p P1
EXCEPT
SELECT DISTINCT S2.sname, S2.scod, P2.pname, P2.pcod
	FROM sp.s S2, sp.p P2, sp.sp SP
	WHERE S2.scod = SP.scod AND P2.pcod = SP.pcod;

--13-a)

SELECT COUNT(*)
	FROM(	SELECT S1.scod, S1.sname
				FROM sp.s S1
			EXCEPT
			SELECT S.scod, S.sname
				FROM sp.s S, sp.sp SP, sp.p P
				WHERE S.scod = SP.scod AND SP.pcod = P.pcod
				GROUP BY S.scod
				HAVING COUNT(*) = 
					((SELECT COUNT(*)
						FROM sp.p))) X;

--13-b)

SELECT COUNT(*)
	FROM sp.s S1
	WHERE (S1.scod, S1.sname) IN
		(SELECT S2.scod, S2.sname
			FROM sp.s S2
		EXCEPT
		SELECT S.scod, S.sname
			FROM sp.s S, sp.sp SP, sp.p P
			WHERE S.scod = SP.scod AND SP.pcod = P.pcod
			GROUP BY S.scod
			HAVING COUNT(*) = 
				((SELECT COUNT(*)
					FROM sp.p)));

--14-a)

SELECT S.scod, SP.pcod
	FROM sp.s S LEFT OUTER JOIN sp.sp SP
	ON S.scod = SP.scod;

--15-a)

SELECT S.scod, S.sname, SP.pcod, SP.qty
	FROM sp.s S LEFT OUTER JOIN sp.sp SP
	ON S.scod = SP.scod AND SP.qty > 300;