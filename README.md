Learning to Dance
=================

Talk and tutorial given at YAPC::EU 2011 about Dancer.

<b>Teacher:</b> Andrew Solomon <b>Teaching Assistants:</b> Adam Taylor, Liz Goldstein


What's Dancer?
--------------

Dancer is a micro 'web framework' - a toolkit for developing a dynamic web application.  It is inspired by the Ruby framework, Sinatra.

Prerequisites
-------------

* Basic Perl knowledge
* Basic HTML/HTTP knowledge

Preparation
-----------

* Bring a laptop with Perl installed
* Install ```Task::Dancer``` (somewhat large) or install ```Dancer``` and ```Dancer::Template::TemplateToolkit```
* Install ```Data::Types```
* *Either* checkout a copy of this talk ```git clone git://github.com/andrewsolomon/YAPC2011DancingLesson.git``` 
* *Or* download and untar https://github.com/andrewsolomon/YAPC2011DancingLesson/blob/master/YAPC2011DancingLesson.tar
* Check that everything works:

```
$ cd YAPC2011DancingLesson/solutions/part2/airport-toolkit
$ ./bin/search_airports --matching syd
```

If it doesn't run, install any prerequisites we forgot!

Instructions
------------
Do your exercises in the directories

```
YAPC2011DancingLesson/exercises/part1/ex1 
YAPC2011DancingLesson/exercises/part1/ex2
...
```
and if you get stuck, you'll find solutions in 

```
YAPC2011DancingLesson/solutions/part1/ex1 
YAPC2011DancingLesson/solutions/part1/ex2
...
```

Paths to take
-------------
The lesson is divided into two sections:

* Part 1: https://github.com/andrewsolomon/YAPC2011DancingLesson/blob/master/slides/part1.md 

This provides you with the basic toolkit of skills for implementing a web site. 

* Part 2: https://github.com/andrewsolomon/YAPC2011DancingLesson/blob/master/slides/part2.md

The application you'll be implementing is an airport search engine, and the exercises illustrate how the code should be structured to make the site easy to change and maintain.  If you just want to cut to the chase, you can skip some of the exercises as follows:

* Quick and Dirty Dancing
- Part 1: Ex 1 - 4, 6, 8
- Part 2: Ex 1 - 4
