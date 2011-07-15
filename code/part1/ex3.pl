#!/opt/xt/xt-perl/bin/perl
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

    return "<p>Hello World, the time is now " . DateTime->new->now . "</p>";
};

Dancer->dance;
