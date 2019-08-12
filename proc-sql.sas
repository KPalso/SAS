data sumgroup;
input groups $ name $ count;
cards;
dev katie 1
dev usagi 3
dev guy 2
dev theodore 1
analyst robert 5
analyst kyle 2
analyst bob 7
analyst bob 3
;
run;
proc sql;
select groups, count(*) as employees
from sumgroup
group by groups
order by groups desc
;
quit;
proc sql;
select name, count(*) as names
from sumgroup
where name in ('bob','robert')
group by name
order by names desc
;
quit;
/*****I use the following a lot. Especially for checking when I calculate weights. 
You can put the macro variables in titles and other things to do comparisons.******/
%let rowcheck=;
proc sql noprint;
select count(*) into :rowcheck
from sumgroup;
quit;
%put &rowcheck;

%let sumcheck=;
proc sql noprint;
select sum(count) into :sumcheck
from sumgroup;
quit;
%put &sumcheck;
