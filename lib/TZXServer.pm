package TZXServer;

use Dancer2;
use Dancer2::Plugin::DBIC qw/ schema rset /;

use Try::Tiny;
use URI;

our $VERSION = schema('default')->{VERSION};

get '/' => sub {
    template 'index';
};

get '/tape/:id' => sub {
    my $tape = rset('Tape')
        ->find( route_parameters->get('id') );

    if ( !$tape ) {
        status 404;
        return "Not found"
    }

    try {
        $tape->unroll;
    }
    catch {
        status 500;
        return $_;
    };

    template 'tape', {
        tape => $tape,
    }
};

any '/search' => sub {
    my $query = param('q');
    $query = join ' ', @{ $query } if ref $query eq 'ARRAY';

    template 'results', {
        query => $query,
        tapes => rset('Tape')
            ->by_title( $query )
            ->hri
            ->all_ref,
    }
};

1;
