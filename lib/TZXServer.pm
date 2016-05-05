package TZXServer;

use Dancer2;
use Dancer2::Plugin::DBIC qw/ schema rset /;

our $VERSION = schema('default')->{VERSION};

get '/' => sub {
    template 'index';
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
