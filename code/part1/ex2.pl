#!/opt/xt/xt-perl/bin/perl
use Dancer;

set logger => 'console';
set log => 'debug';
set show_errors => 1;

get '/', sub {
    return "<h1>Hello World!</h1>";
};

get '/hello' => sub {
    return "<h1>Hello Things!</h1>";
};

Dancer->dance;
