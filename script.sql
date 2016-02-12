drop table if exists temp.segment;

create temporary table segment as
select distinct * 
from (
select w.start as S, r.start E
from worktime w, records r
UNION
select r.end S, w.end E
from worktime w, records r
)
where s < e and 0 <=(w.end - r.start)*(r.end - w.start);


--select rowid, S, E from temp.segment;

select distinct
	--t1.rowid as ID1
	--,t2.rowid as ID2
	max(t1.S, t2.S) as S1
	,min(t1.E, t2.E) as E1
from temp.segment t1, temp.segment t2
where t1.rowid <> t2.rowid 
	and max(t1.S, t2.S) < min(t1.E, t2.E)
	and 0 >= ( 
		select MAX( (min(t1.E, t2.E) - r.start) * (r.end - max(t1.S, t2.S)) )
		from main.records r
		)
order by S1, E1
