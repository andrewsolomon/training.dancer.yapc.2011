Implementing an MVC web application
====================================================

Our project is to write a website as a single page
of the format:

http://0.0.0.0:3000/

---
<p>
Search for airports matching [       ]
</p>
[Submit]

---

enter Sydney and the page will look like this

http://0.0.0.0:3000/results?searchstring=Sydney

---
Search for airports matching [Sydney]
[Submit]

Found 3 airports from 2948324

<ul>
<li>Sydney / J.A. Douglas McCurdy Airport, CA</li>
<li>Sydney Bankstown Airport, AU</li>
<li>Sydney Kingsford Smith International Airport, AU</li>
</ul>

---

It will be similar to the elementary website we just developed, but
because it is larger and more complex we'll need to give it more
structure, separating things out a bit more so that the code is easy to
understand and maintain.

The structure we use in this section is the Model-View-Controller (MVC)
framework. A model is the code which access and manipulates the data. The
view is (in our case) the HTML/Template Toolkit file which dictates how
the output is presented to the user.  The controller is the code which
connects a URL with a view, and uses a module to populate a view with
the appropriate data.

Play with the script below to understand how it works. We'll be
calling the modules Airport::Data and Airport::Search it's based on
from our website controller.

``` 

$ cd code/part2/airport-toolkit
$ ./bin/search_airports --matching riga --word
$ ./bin/search_airports --latitude  56.923 --longitude 23.9710   \
    --number 3 --distance 0.01

```

Exercise 1. Implement the skeleton described below
===================================================

The following code is a skeleton on which you'll be building
the website. Save these files in the specified locations
and complete the template so that the site runs without errors.

A) The script: ``` part2/ex1/wsa ```

This is surprisingly minimal, but we're putting
all the route handlers into Airport::Controller
and the 'set' calls are being replaced with 
the contents of a config file

```perl

#!/usr/bin/perl

use Dancer;
use Airport::Controller;


Dancer->dance;

```

B) The config file: ``` part2/ex1/config.yml ```

Instead of having 'set' calls in the perl code
we're putting all the settings in a config file
which can be changed without modifying the code.


```

engines:
  template_toolkit:
    start_tag: '[%'
    stop_tag: '%]'

template: 'template_toolkit'

logger: 'console'
log: 'debug'
show_errors: 1

```

<b>NOTE</b> Remember the "banana skin" (in Part 1 exercise 4)?
Because we've put engines and template into a config file
the ordering no longer matters.

 
C) The handlers module ``` part2/ex1/lib/Airport/Controller.pm ```

```perl

package Airport::Controller;
use Dancer;


get '/' => sub {
  template 'index';
};

get '/results' => sub {
  my $searchstring = params->{searchstring};
  template 'index' => {
    searchstring => $searchstring,
    searchresults => [
      { name => 'Kentucky Fried Airport', iso_country => 'Kentucky' },
      { name => 'McAirport', iso_country => 'United State of Texas' },
    ],

  };
};

1;

```


D) The template ``` views/index.tt ```

```

<html>
<head><title>Find an Airport</title></head>
<body>
  <h1>Find an Airport</h1>

<form action="results" method="get">
  <input type="text" name="searchstring" value="[%searchstring%]"/><br />
  <input type="submit" value="Submit" />
</form>

[% IF searchresults %]
<h2> Search Result </h2>
<table>
<tr><td><b>Name</b></td><td><b>Country</b></td></tr>

-----> FIXME: ADD THE FOREACH LOOP TO FILL IN COLUMNS HERE

</table>
[% END %]


</body>
</html>

```

NOTE: ```wsa``` and the ```config.yml``` have to be in the directory containing the
'views' and 'lib' subdirectories otherwise ```wsa``` needs to be told where to
look for everything.

Move on to Exercise 2 once you've changed views/index.tt to display 
the aiports being sent back from the controller.

Exercise 2: Start using the Toolkit
===================================

In this exercise we start using the airport-toolkit
   
a) Toss in the ingredients

```
$ cp -r ex1 ex2
$ cp -r airport-toolkit/* ex2
```

* Add to ``` config.yml ``` 
``` airports_csv: 'data/iata_airports.csv' ```

b) Edit ``` Airport::Controller ``` so that it loads the array of 
airports generated with ``` Airport::Data::parse_airports ``` 
into a package variable which will be used in 
the search function.

<b>NOTES</b> 

* Due to the config settings above, the filename to 
pass into Airport::Data::parse_airports is setting('airports_csv')

* For hints at how this is done, look at ``` bin/search_airports ```

* the array of airports should be declared and populated outside a
subroutine so it is only populated the first time the ``` Airport::Controller ```
module is loaded, called rather than every time we do a search.

c) Add the number of airports line to the top of the ``` index/results ``` page
as in the example 'screenshots' above using the number of 
elements in the array value being passed to the template.



Exercise 3:  Dancing with the data
====================================

```
$ cp -r ex2 ex3
```

Instead of just writing 'Found 3 airports from 6372'
below the search result it would be more informative to say
```
'Found 3 airports from 6372 - searching by location'
```

or
```
'Found 3 airports from 6372 - searching by name'
```

Using ``` Airport::Data::parse_search_string ``` decide which method
is appropriate depending on the user's input and add that to
the statement above.

Exercise 4: Deciding on your partner
====================================

Now use ```Airport::Search get_name_matching_airports ```
or ``` get_latlong_matching_airports ``` to populate the 
searchresults with the correct data.

Also - turn 'X' into the number of airports found.

Dancing well into the night... 
===============================

* <b>Exercise 5</b> Make the search get_name_matching_airports case insensitive
and update its test script accordingly

* <b>Exercise 6</b> For each airport, if it has a home_link, make it a link when
you click on the airport name.

* <b>Exercise 7</b> Place another link to the right of each link to get the airports
near this one (1 degree circumference)

... and the morning after
=========================
* <b>Exercise 10</b> See how much easier it would have been if you'd let dancer lead:
```
$ mkdir part3
$ cd part3
$ man dancer
$ dancer -a Airport
...
```