Elementary Web Application
===========================

Concepts
--------

* <b>Route handler</b> - the mapping of a url to a subroutine
* <b>Route types</b>:
    1. ```http://example.com/link/:like/:this``` where all the data is in the url but not a GET
    2. GET query ```http://example.com/more?like=this&orlike=that```
    3. POST query ```http://example.com/justthis```
* <b>Template</b> - HTML files embedded with ```[% directives %]``` 


We assume you've done a static website. A simple HTML page. The only active part of a static website is a link to
take you from one static page to another. For example
```<a href="http://www.example.com">Example</a>```

More interesting is a website where clicking on a button will do some data mining and generate a new page on the fly.
That's an example of a '<b>Web Application</b>' and this class will take you through putting one together.


Exercise 1 - An index route
==============================
Create the script ```part1/ex1/step1.pl```

```perl
#!/usr/bin/perl

use Dancer;

set logger  => 'console';
set log     => 'debug';
set show_errors => 1;

get '/' => sub {
    return "Hello World!";
};

Dancer->dance;
```


Running it at the command line you should get something like:

```
$ ./hw
>> Dancer server 11757 listening on http://0.0.0.0:3000
```

See what happens when you visit the url with your browser. Replace '0.0.0.0' with the IP address of the machine you're working on.


Things to note about the code:

* ```'use Dancer'``` brings along ```'use strict'``` and ```'use warnings'``` so  we don't need to type them.
* The three settings

```
  set logger    => 'console';
  set log       => 'debug';
  set show_errors => 1;
```

are telling it to keep you informed of what the problem is when
things go wrong to make sure you get as much information as possible.
You'll want to log errors to a file once it's a public website.

* ```get '/' => sub {} ```
says, on an HTTP GET request, call the subroutine on the right 
of the arrow to generate the content of the page to be displayed.

*  ``` Dancer->dance; ``` This is an example of a method call on an object. To use Moose we don't
need to understand how to develop Perl objects - we just need to get a
feel for how to use them.

Now the following commands would have looked a bit suspicious to the Perl newbie:

```
set logger    => 'console';
get '/' => sub {
    return "Hello World!";
};
```

This is just a bit of Perl cosmetics to change the focus of the reader from the subroutine being called, to its arguments. The first of these could just as well have been written

```set('logger', 'console');```

Rewrite the whole script in this way, save it as ``` part1/ex1/step1-back.pl ```

and run it to see that it behaves exactly the same as ``` step1.pl ```

<b>HINT:</b> to understand the ``` get ``` 's second argument set

```
my $hwsub = sub {
    return "Hello World!";
};
```

before calling '```get```' on $hwsub.


Finally,

```
$ cp part1/ex1/step1.pl part1/ex1/step2-forward.pl
```

and change the output to be a bit prettier using HTML tags:

```<h1>Hello World!</h1>```


Exercise 2: A non-index route
==============================

```
$ cp part1/ex1/step2-forward.pl part1/ex2/step1.pl
```

and create another route handler for the URL

```
    http://0.0.0.0:3000/hello
```

which returns ``` <h1>Turn it all around people!</h1> ```

<b>HINT</b>: Instead of ``` get ```'s first argument as ``` '/' ``` it should be ``` '/hello' ```



Exercise 3: Non-static pages
============================

We've shown how to write static pages, but that's no better than plain HTML. First, 

```
$ cp part1/ex1/step2-forward.pl part1/ex3/step1.pl
```

and then add a new route handler 'date_time' which shows not just 'Hello World', but also
the time.

That is:

```
http://localhost:3000/date_time
```

Displays a page containing: 

```
Hello world, the time is now 2002-12-06 14:02:29
```

<b>HINTS</b>: 
* Calculate the time using the ```DateTime``` module, its ```now``` creation method, and  its ```ymd``` and ```hms``` methods.
* ``` $ perldoc DateTime ```
* Calculate the string to display in the in the route handler
my $dt = DateTime->now(time_zone => 'Europe/Riga'); #### FIXME $time should be $dt in the answers
my $s_date = $dt->ymd; my $s_time = $dt->hms;
```


Exercise 4: Template Toolkit
=============================

Now from the previous exercise you are generating HTML from 
within a script. For a small and simple HTML file that's ok, but
if it gets any bigger it will be very difficult to read the 
script picking out the html from the perl or vice versa.

This is what a Template is for - you can separate out the 
HTML into a different file with tags [% date %] and [% time %]
which will be filled in by the variables in the perl script.

Now, copy part1/ex3/step1.pl to part1/ex4/step1.pl

and change the  

    get '/time' 

route handler. Instead of returning an HTML string, return

    template 'date_time' => { time => $dt->hms, date => $dt->ymd };
or 
    template('date_time', { time => $dt->hms, date => $dt->ymd });

if it makes you feel safer :)


At the top of the file, add these configuration parameters telling
Dancer you'll be using a template file.

 set engines => {
     template_toolkit => 
     {
         start_tag => '[%',
         stop_tag  => '%]'
     }
 };
 set template  => 'template_toolkit';


Now, running the script and pointing your browser at
http://10.5.16.131:3000/time 
will give you a runtime errors saying that it's looking
for the file
code/part1/ex4/views/date_time.tt

To fix this, create the file with any HTML content you like, 
and making use of the strings [% date %] and [% time %]
which will be filled in by Dancer::Template

Run it and make sure it works.
The things to note about this:
- 'template 'date_time'' means 'look for views/date_time.tt in the views directory
- the hash ref  { time => $dt->hms, date => $dt->ymd } says
'Whenever you see [% time %] replace it with $dt->hms and
whenever you see [% date %] replace it with  $dt->ymd


Exercise 4 Step 2 - Banana skin 
------------------
$ cp part1/ex4/step1.pl part1/ex4/step2-back.pl

and swap the order of the 'set template' and 'set engines'

What happens?

[It's a Dancer bug - no-one's perfect!]

========================

Exercise 5. Route Type 1: parameterised base url
=================================================

$ cp part1/ex2/step1.pl part1/ex5/step1.pl

Modify the /hello route handler to take another parameter.

That is, instead of writing 
get '/hello' => sub {};
we write 
get '/hello/:adjective' => sub {};

Then within the associated subroutine, the variable
params->{adjective} will be the string in the url after 
/hello-adj-par/ 

NOTE: params is a method returning a hashref of all the parameters

Therefore, we can change 
  return "<h1>Turn it all around people!</h1>";
to     
  return "<h1>Turn it all around ".params->{adjective}." people!</h1>";


Then navigate to the page: 
  http://10.1.1.5:3000/hello/funny

or 
  http://10.1.1.5:3000/hello/interesting

Implement this and see that it works.

NOTES:
* This technique is great for auto-generated urls which might populate
a site-map for search engines to explore your website.
* What's more - it's much prettier as a url than the two other approaches below.


--------
Exercise 5 shows how we can use paramaterised urls for generating content,
but this is not the way for implementing pages which take their parameters
from human input. You don't want them to have to type their name into the
url.  It would be easier for them to type it into a field in a web page.
The two approaches for implementing this are the GET and POST type forms.  
--------

Exercise 6. Route type 2: GET query 
======================================

$ cp part1/ex4/step1.pl part1/ex6/step1.pl

1) Remove all the route handlers except '/' which should now be

get '/' => sub {
    template 'hello-adj-index';
};

NOTE: Don't remove the 'set's only the 'get's!!

2) Create a new template views/hello-adj-index.tt containing

-----
<h1>GET form for accessing the hello-adj get method</h1>
<form action="hello-adj" method="get">
  Adjective: <input type="text" name="adjective" /><br />
  <input type="submit" value="Submit" />
</form>
-----


-----------


3) In ./code/part1/ex6/step1.pl  add a '/hello-adj-index' method
----------

get '/hello-adj' => sub {
  my $params = params();
    return
  "<h1>Hello ".params->{adjective}." Things!</h1>"
};
--------

Run it and see that if you visit the website at 

http://localhost:3000/
and enter a name like 'dynamic' and click submit, it will 
display the page 
http://10.1.1.5:3000/hello-adj?adjective=dynamic
and say 'Hello dynamic Things!'



Exercise 7. Route Type 3: POST query 
=======================================

$ cp -r part1/ex6 part1/ex7

You've just done two experiments with dynamically generating content of the
web page based on information the user provided. In both cases, this
information wound up in the url.

This is sometimes not optimal, for example when the string provided by
the user is their password (and therefore visible in the url), 
or longer than the maximum url length (2083 characters for IE)

The solution to this is to use a POST request, instead of a 
GET request. In a POST request, the query parameters are 
in the HTTP message's header, rather than the url.

With a POST we need to do two things. First of all, provide a POST
form in the template views/hello-adj-index.tt - after the get form.
-----
<h1>POST form for accessing the hello-adj-post method</h1>
<form action="hello-adj" method="post">
  Adjective: <input type="text" name="adjective" /><br />
  <input type="submit" value="Submit" />
</form>
-----


And then in the ./code/part1/ex7/step1.pl controller add the "hello-adj"
*post* method

----------

post '/hello-adj' => sub {
  my $params = params();
    return
  "<h1>Hello ".params->{adjective}." Things!</h1>".
};
--------

Run it and see that if you visit the website at 

http://localhost:3000/
enter a name like 'dynamic' *in the post form* and click submit, it will 
display the page 
http://localhost:3000/hello-adj
and say 'Hello dynamic Things!'


Exercise 8: Dynamic Content + Template Toolkit
==============================================

$ cp -r part1/ex6 part1/ex8

Implement a new GET query so that if the user enters a comma-separated
list of adjectives it prints out a line for each one.

In ./code/part1/ex8/step1.pl, update the /hello-adj route handler
filling in the # TODO section with code to generate an array reference
----------

get '/hello_adj' => sub {
  my $params = params();
  ## TODO: Split the params->{adjectives} into a list of comma separated words
  ## and we pass a refence to this list into TT
  template 'hello-multiple-adj' => { adjective_list => \@adj_list };
};
--------

B. Now we must implement a new template view  and
this is where the Template Toolkit shows its power!  


Write this code in views/hello-multiple-adj.tt

-----------------------------------
[% FOREACH adj in adjective_list %]
<p>Hello [% adj %] thing!</p>
[% END %]
-----------------------------------


Check to see that it runs as expected.


Exercise 9
===========

$ cp -r part1/ex8 part1/ex9
$ rm ./code/part1/ex9/views/hello-multiple-adj.tt



In Exercise 8 we saw how to use the Template's FOREACH loop to show the
contents of an array where each element was a string.

In this example, we show the contents of a hashref.  This is a very
simple example but it illuminates how hashrefs are represented in TT.

GOAL: Write a webpage http://localhost:3000/show-parameters 
which displays everything it receives as a parameter.

For example:

http://localhosit:3000/show-parameters?x=1&y=2&z=t

shows a webpage of 
========================
Parameters

Key Value
x 1
y 2
z t
========================


See perldoc Template::Manual::Directives

A) Write a route handler in ./code/part1/ex9/step1.pl :
---
get '/show-parameters' => sub {
  my $rh_params = params;
  template 'parameters' => { parameter_hashref =>  $rh_params };
};

B) Change views/hello-adj-index.tt to 

<form action="show-parameters" method="get">
  First parameter: <input type="text" name="p1" /><br />
  Second parameter: <input type="text" name="p2" /><br />
  Third parameter: <input type="text" name="p3" /><br />
  <input type="submit" value="Submit" />
</form>


C) Write parameters.tt
with a FOREACH loop which iterates over each key-value pair 
of the 'parameter_hashref' variable

---

<h1>Parameters</h1>

<table>
<tr><td><b>Key</b></td><td><b>Value</b></td></tr>
[% FOREACH p IN parameter_hashref %]

---->INSERT YOUR CODE HERE

[% END %]

</table>

---

To figure out how, read 

'iterated values which are hash references' in 

perldoc Template::Manual::Directives



D) Banana skin
-----------------------------

$ cp part1/ex9/step1.pl part1/ex9/step2-back.pl
---
Change the /show-parameters routehandler  from

get '/show-parameters' => sub {
  my $rh_params = params;
  template 'parameters' => { parameter_hashref =>  $rh_params };
};

to 

get '/show-parameters' => sub {
  template 'parameters' => { parameter_hashref =>  params };
};

and see what happens.

Called in this way 'params' returns a hash, rather than a hashref.
To understand why is beyond the scope of this course, but
to find out more, read the Dancer::Request code implementing 'params' in
5.10.1/Dancer/Request.pm
and read
$ perldoc -f wantarray



