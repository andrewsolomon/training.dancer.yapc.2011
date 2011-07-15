#!/bin/env perl
use Dancer;
use DateTime;

set logger => 'console';
set log => 'debug';
set show_errors => 1;

get '/', sub {
    return "<h1>Hello World!</h1>";
};

get '/hello' => sub {
    return "<h1>Hello Things!</h1>";
};

get '/tt-time' => sub {
    my $now = DateTime->now();

    template 'time' => { time => '11:24:09', date => '15 Jul 2011' };
};

Dancer->dance;
