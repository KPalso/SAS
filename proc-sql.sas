/*******counts********/
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

/*****dictionary.columns can be accessed with a data step or a common way I use it is with proc sql*
to get names of variables, types and lengths
it will find all libnames that are active, so default ones with many 
datasets in them like sashelp will display too*/
***see for yourself, you can either select where desired libname or where not in (undesired libnames);
proc sql;
select distinct libname from dictionary.columns;
quit;
/*
MAPS
MAPSGFK
MAPSSAS
SASHELP
SASUSER
*/
libname edit = '$EDIT'; *or %%EDIT%% for windows environment variables; 
proc sql;
select libname, memname, name, type, length from dictionary.columns
where libname = 'EDIT';
quit;
