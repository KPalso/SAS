*example proc groovy code to get you started;
*proc groovy requires Java 6 if you're importing jars to use in SAS. At least, that's how our set up is.;

proc groovy;
clear;
quit;

proc groovy;
submit;
println('hello world')
endsubmit;
quit;

proc groovy;
submit;
for (i = 0; i <3; i++) {
   System.out.println("Hello World")
}
endsubmit;
quit;

proc groovy;
submit;
List<String> list = new ArrayList<String>();
list.add("A");
list.add("B");
list.add("C");
for (String item : list) {
   System.out.println(item)
}
endsubmit;
quit;

proc groovy ;
submit;
int x=1
println "x is "+x 
endsubmit;
quit;

proc groovy;/*UPTO*/
submit;
def c = {
   println it
}
1.upto(10, c)
endsubmit;
submit;
def c = {
   println it
}
6.upto(25, c)
endsubmit;

submit;
1.upto(4, {println "Number ${it}"})
endsubmit;
quit;

proc groovy;/*STEP is like UPTO but you can specify the increment*/
submit;
0.step 5, 1, { /*less than 5, shows from 0-4*/
   println it
}
endsubmit;
submit;
5.step 51, 5,  { /*shows 5-50 in increments of 5*/
println it
}
endsubmit;
quit;


proc groovy;/*LISTS*/
submit;
def list = ["A", "B", "C"]
for (item in list) {
   println item
}
endsubmit;

submit;/*Here is a shortened example: */

for (item in ["A", "B", "C"]) {
   println item
}
endsubmit;

submit; /*Here is another example that iterates over a range of numbers */

for (number in 1..3 ) {
    println number
}
endsubmit;

submit;/*Here is a way of iterating over a map using for loop: */

def map = [a1:'b1', a2:'b2']
for ( item in map ) {
    println item.key 
}
endsubmit;

submit;/*Same example but using the values of the map */
def map = [a1:'b1', a2:'b2']
for ( item in map ) {
    println item.value
}
endsubmit;
quit;

proc groovy ;
submit;
int x=(int) 23.4;/*23*/
int y=(int) 23.5;/*23*/
int z=(int) 23.8;/*23*/
println "x is "+x 
println "y is "+y
println "z is "+z
endsubmit;
quit;
