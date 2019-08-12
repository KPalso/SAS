/*You don't want to hard code things, especially login credentials. This is a quick-and dirty way until I have time to make a gui.
This takes advantage of our folder shortcuts.
I recommend that you save this sort of thing to a personal folder, because SAS doesn't allow more than one person to access a compiled macro
at one time.*/
%let LANlocation="MY_NETWORK_LOCATION";
%let SECURElocation="MY SECURE FOLDER PATH WHERE MACROS GO";
%let mypersonalfilepath="my secure personal file path where my salted password is.txt";
libname macros &SECURElocation;
options mstored mprint sasmstore=macros;

%macro passwordencode(myPassword,myfilepath);
filename mypass "&myfilepath.";
proc pwencode in="&myPassword." out=mypass;run;
data getpwd;
infile mypass;
length pwd #50.;
input pwd $;
call symput('myencryptedpassword',pwd);
run;
%mend;

%macro dbconnect_pw_2019(&myencryptedpassword.) / store source des="Get encrypted password and connect to database";
libname data2019 oledb init_string="Integrated Security=SSPI;Persist Security Info=True;Initial Catalog=MY_DATABASE_NAME2019;
Data Source=PROD-SERVER-INSTANCE;" provider=sqlncli11 prompt=no
user="&sysuserid." password="&myencryptedpassword."
access=readonly dbmax_text=32767;
%mend;

*passwordencode makes a macro variable called &myencryptedpassword;
%passwordencode(password1234,&mypersonalfilepath.);

%dbconnect_pw_2019("&myencryptedpassword.");

