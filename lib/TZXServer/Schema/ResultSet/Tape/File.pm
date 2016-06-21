package TZXServer::Schema::ResultSet::Tape::File;

use TZXServer::Base::Imports;
extends 'TZXServer::Schema::ResultSet';

use HTTP::Tiny;
use File::Spec::Functions;
use File::Copy qw/ cp mv /;
use Archive::Extract;
use File::LibMagic::FFI;

has http => ( is => 'lazy' );
sub _build_http {
    HTTP::Tiny->new;
}

sub create_from_zip( $self, $zipfile, $stash, $tape_id, $username = undef ) {
    my $ex = Archive::Extract->new( archive => $zipfile );
    $ex->extract( to => $stash );

    for my $file ( @{ $ex->files } ) {
        next if $file !~ /tzx$/i;
        $self->create({
            tape_id  => $tape_id,
            filename => $file,
            username => $username
        });
    }
}

sub create_from_tape( $self, $tape ) {
    return if !$tape->uri;
    my $stash = $self->schema->storage_dir( $tape->id );
    my $filename = $tape->uri =~ s{.*/(.*)}{$1}r;
    my $zipfile  = $self->schema->storage_file( catfile( $tape->id, $filename ) );

    my $res = $self->http->mirror( $tape->uri, $zipfile );

    $self->throw_exception( sprintf(
        "HTTP %s: %s", $res->{status}, $res->{reason}
    ) ) if !$res->{success};

    $self->create_from_zip( $zipfile, $stash, $tape->id );
}

sub create_from_upload( $self, $upload, $username, $tape_id ) {
    $self->throw_exception("Who is uploading?") unless $username;
    $self->throw_exception("What is the tape?") unless $tape_id;

    my $stash = $self->schema->storage_dir( $username, $tape_id );
    my $target = catfile( $stash, $upload->filename );
    mv $upload->tempname, $target;

    if ( index (
        File::LibMagic::FFI->new->checktype_filename( $target ),
        'application/zip'
    ) == 0 ) {
        $self->create_from_zip( $target, $stash, $tape_id, $username );
    }

    $self->throw_exception( "Unknown file type")
        if $target !~ /\.tzx$/i;

    $self->create({
        tape_id  => $tape_id,
        filename => $target =~ s{.*/}{}r,
        username => $username
    });
}

sub find_for_user( $self, $username ) {
    return $self->search({ username => undef }) unless $username;
    return $self->search({ username => [ undef, $username ] });
}

1;

