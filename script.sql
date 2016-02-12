-- Create Tables
CREATE TABLE "worktime" (
    "_id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "start" INTEGER NOT NULL,
    "end" INTEGER NOT NULL
);

CREATE TABLE "records" (
    "_id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "start" INTEGER NOT NULL,
    "end" INTEGER NOT NULL
);

-- Insert values (init data)
insert into worktime (start, end) 
values (8, 48);

insert into records (start, end)
values (8, 12),
	(24, 30),
	(36,38);

-- Create tamporary table
drop table if exists temp.segment;

create temporary table segment as
select distinct * 
from (
select w.start as S, r.start as E 
from worktime w, records r 
where (w.end - r.start)*(r.end - w.start) > 0
UNION
select r.end as S, w.end as E 
from worktime w, records r 
where (w.end - r.start)*(r.end - w.start) > 0
UNION
select w.start as S, w.end as E 
from worktime w, records r
where (w.end - r.start)*(r.end - w.start) <= 0
)
where s < e;

--select * from temp.segment;

-- Select result sub intervals
select distinct
	max(t1.S, t2.S) as S
	,min(t1.E, t2.E) as E
from temp.segment t1, temp.segment t2
where max(t1.S, t2.S) < min(t1.E, t2.E)
	and 0 >= ( select MAX( (min(t1.E, t2.E) - r.start) * (r.end - max(t1.S, t2.S)) )  from main.records r)
order by S, E;
