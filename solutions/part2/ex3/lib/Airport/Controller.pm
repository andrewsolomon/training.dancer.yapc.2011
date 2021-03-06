package Airport::Controller;
use Airport::Data;
use Dancer;

debug 'Reading airports_csv';
my $ra_airports = Airport::Data::parse_airports(setting('airports_csv'));


get '/' => sub {
  template 'index';
};

get '/results' => sub {
  my $searchstring = params->{searchstring};
  my $rh_search_params = Airport::Data::parse_search_string($searchstring);

  template 'index' => {
    search_type => defined($rh_search_params->{latitude}) ?
      'location' : 'name',
    searchstring => $searchstring,
    total_number_airports => scalar(@$ra_airports),
    searchresults => [
      { name => 'Kentucky Fried Airport', iso_country => 'Kentucky' },
      { name => 'McAirport', iso_country => 'United State of Texas' },
    ],

  };
};

1;


