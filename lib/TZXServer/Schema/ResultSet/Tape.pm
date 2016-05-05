package TZXServer::Schema::ResultSet::Tape;

use TZXServer::Base::Imports;
extends 'TZXServer::Schema::ResultSet';

use URI;
use Web::Scraper;
use Scalar::Util qw/ looks_like_number /;

has tzxvault_scraper => ( is => 'lazy' );
sub _build_tzxvault_scraper {
    scraper {
        process 'table tr', 'games[]' => scraper {
            process "/tr/td[1]", title => 'TEXT';
            process "/tr/td[1]//a", uri => '@href';
            process "/tr/td[2]", publisher => 'TEXT';
            process "/tr/td[3]", year => 'TEXT';
            process "/tr/td[4]", genre => 'TEXT';
        }
    }
}

sub _uri( $self, $index) {
    URI->new( "http://www.tzxvault.org/${index}.htm" )
}

sub import( $self ) {
    return if $self->rs('Tape')->one_row;

    my $txn = $self->schema->txn_scope_guard;

    for my $index ( 'num', 'a'..'z' ) {
        my $games = $self->tzxvault_scraper->scrape( $self->_uri( $index ) )->{games};
        shift @{ $games };


        for my $game ( @{ $games } ) {
            delete $game->{year} if (!looks_like_number( $game->{year} ));
            $self->create( $game );
        }

    }

    $txn->commit;
}

sub by_title( $self, $title ) {
    $title =~ s/^\s+//;
    $title =~ s/\s+$//;

    $self->search_rs({
        -and => [
            map { \[ 'LOWER(title) LIKE ?', "%$_%" ] }
                ( split /\s+/, lc( $title ) ),
        ],
    });
}

1;
