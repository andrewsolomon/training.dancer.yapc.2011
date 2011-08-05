Learning to Dance
=================

Talk and tutorial given at YAPC::EU 2011, for the beginner track, about Dancer.

What's Dancer?
--------------

Dancer is a micro web framework, inspired by the Ruby framework, Sinatra.

Prerequisites
-------------

* Basic Perl knowledge
* Basic HTML/HTTP knowledge
* A laptop with Perl, Task::Dancer and Data::Types

Tutor
-----

Andrew Solomon <andrew.solomon@net-a-porter.com>

FIXMEs from the class
===================





5. 12:24 < rufus> just under the template file config, it says /time instead of 
               /date_time


6. dakkar: GET is idempotent (see HTTP rfc), POST is not (e.g sessions). 
That is the difference
POST hiding things from the url is 
See also the REST spec.(see Joel's talk about HTTP spec's implications)

7. 
12:37 < dakkar> asolomon: re ex8: why comma separated? would multi-valued 
                params be more interesting?
12:37 < asolomon> dakkar: see ex9
12:38 < dakkar> not really, they are 3 different params
12:38 < asolomon> sorry - what's a multivalued param?
12:38 < dakkar>  http://foo/bar?q=1&q=2&q=3
12:39 < asolomon> dakkar: got it - i'll make that ex 10 (or 8.5 or something)
12:38 < dakkar>  http://foo/bar?q=1&q=2&q=3


8.  13:10 < rufus> oh, dancer -a is nice
13:11 < asolomon> yes, i should tell the students that at the end so they can 
                  see how much easier it would have been:)

9. AndrewB : consistency of 
