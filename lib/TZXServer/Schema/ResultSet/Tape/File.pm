package TZXServer::Schema::ResultSet::Tape::File;

use TZXServer::Base::Imports;
extends 'TZXServer::Schema::ResultSet';

use HTTP::Tiny;
use File::Spec::Functions;
use Archive::Extract;

has http => ( is => 'lazy' );
sub _build_http {
    HTTP::Tiny->new;
}

sub create_from_tape( $self, $tape ) {
    return if !$tape->uri;
    my $stash    = $self->schema->storage_dir( $tape->id );
    my $filename = $tape->uri =~ s{.*/(.*)}{$1}r;
    my $zipfile  = $self->schema->storage_file( catfile( $tape->id, $filename ) );

    my $res = $self->http->mirror( $tape->uri, $zipfile );

    $self->throw_exception( sprintf(
        "HTTP %s: %s", $res->{status}, $res->{reason}
    ) ) if !$res->{success};

    my $ex = Archive::Extract->new( archive => $zipfile );
    $ex->extract( to => $stash );

    for my $file ( @{ $ex->files } ) {
        next if $file !~ /tzx$/i;
        $tape->create_related( 'files', {
                filename => $file,
            }
        );
    }
}

1;

