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
