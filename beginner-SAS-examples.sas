/******I used to give this code to staff who want to learn SAS********/

*single line comment;

*But you can
do this, too.
It's one of the few things
SAS isn't too picky about.;

/* multiline
comment
*/

/*CTRL+/ will add*/
/*multiline comments*/
/*to each highlighted line*/

/*and if you do CTRL+SHIFT+/ to a multi-comment style commented line, it'll take away comments*/

quit;
dm log 'clear';*this clears the "log" window;
dm out 'clear';*this clears the "output" window;
dm 'odsresults;clear;';*this clears the html "results" window;

proc datasets library=work kill;run;quit;*this deletes all datasets in the WORK library;
*run these and LOOK AT YOUR LOG!;

*here's a data step so you can play around;
data one;
input nums cat;
label cat = "cat: do they like cats?";
cards;
1 1
2 2
4 1
6 2
3 .
;
run;
************ALWAYS CHECK YOUR LOG!!!!;

*some of my frequent options;
options mprint source2 formdlim="*" symbolgen msglevel=i nofmterr mergenoby=error;
*mergenoby: SAS does not "fail fast," meaning it will continue to run even with errors. 
If you do not include a BY variable for a merge, it will continue to run what was submitted even if it's wrong.
a BY variable in a merge is where you want to join a column of values to a table according to a key or ID. if you don't specify
that key/ID, SAS will merge according to row number, row 1 with row 1, row 2 with row 2, and so on.;

***********format errors******;
*nofmterr: SAS formats add a label to a value. By default, if you don't have a format defined and you specify it, you will get an error.
nofmterr will allow processing if you call a format that SAS can't find.;
*example of fmterr and nofmterr;
options fmterr;
proc freq data=one;
tables nums;
format nums numfmt.;
run;
*run the above and you get an error saying SAS can't find the format;

options nofmterr;
proc freq data=one;
tables nums;
format nums numfmt.;
run;
*run the above and SAS proceeds even though it can't find the format;

*Formats with the number in the label. It makes it easier when looking at output or printed output.;
proc format;
value animal
1="1: cat"
2="2: dog"
3="3: bird"
4="4: dinosaur"
other="other animal"
;
proc freq data=one;
tables nums;
format nums animal.;
run;
*The format is applied. SAS doesn't know what it means. You have to know what it means.;

proc format; value yesno 1='1: yes' 2='2: no';
value years
low-1989="pre-90s"
1990-1999="nineties"
2000-high="2k and later"
.="missing data"
;run;
data years;
input year;
cards;
1980
1979
1990
1992
1994
.
1999
2000
2030
;
run;
proc freq data=years;
tables year/missing;*missing will show missing data in the frequency; 
format year years.;
run;

*another example of creating a dataset, a SAS table;
data example;
label rucool="rucool: is the person cool?";*notice I add the variable name in the label;
input id name $ score year rucool;
cards;
1 Nelson 100 1998 2
2 Bach 97 1995 2
3 Ludwig 50 2000 1
4 Yo-yo 100 2011 1
;
run;
proc freq data=example;
tables rucool;
format rucool yesno.;
run;

*now I'm going to show some simple macros. ANYONE can do this. I promise even if you don't think you can, you can.;
*title1 title2 title3, etc put titles for your things that display in the output. You want to use these a lot.;
*&sysdate is a SAS system macro. it puts the date. If you're feeling adventurous, run the %put statement to 
see the system macros and user-defined macros
before your title1 statement;
%put _all_;

%let name=Sam;
title1 "&name &sysdate some SAS code created 2013";
title2 "isn't that great?";
title3 'but you do not always have to use double quotes';
title3;*title3 here by itself erases only title3;
proc print data=example;
var id name;
where score=100;
*titles can go before a run statement, within a PROC;
title4 'where score=100';
run;
title4;

data example2;*new name for a new dataset;
set example;
if year<1999 then theyear=1;
else theyear=2;
run;
proc freq data=example2;
tables year*theyear/list;
title2 "checking recode of year";
run;
proc freq data=example2;
tables year;
where year<1999;
title2 "where year<1999";
run;
title2;
proc print data=example2;
where year<1999;
title2 "all variables where year<1999";
run;

data example2;*overwrite this table;
set example2;*using this name;
rename id=nums;*you lose the id column. it's renamed;
year2=year;*this keeps the year column and add an identical column called year2;
format year years.;*apply the format years by default;
run;
proc freq data=example2;
tables year;*see the format?;
run;

data example2;
set example2;
format _all_;*remove format assignments;
run;

***************merging;
*let's assume the two datasets we've created, example and one, refer to the same cases. what that means is
the ID columns refer to the same people, visits, physicians, claims, whatever the unit of analysis is;
*if we want to merge these two things, here's some example code:;
proc sort data=one;*you have to sort before a merge;
by nums;
run;
proc sort data=example2;*you have to sort both. I'm using the ID variable that's been renamed so they match. They have to be the same name;
by nums;
run;
data merged;
merge example2 one;
by nums;
run;
proc print data=merged;
title2 "notice what happens when one dataset doesn't have data for a case";
title3 "nums=6 is not on the example dataset, so those are blank, but included. This is a FULL JOIN if you're familiar with SQL at all";
run;
proc print data=merged (obs=2) noobs;
title2 "only the first two rows are printed because of the (obs=2) code";
title3 "noobs has to go after if you want the two together";
title4 "noobs takes away that obs column you saw before for proc print";
run;title2;title3;title4;
run;
