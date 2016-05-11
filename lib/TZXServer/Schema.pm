package TZXServer::Schema;

use TZXServer::Base::Imports;
use File::Path qw/ make_path /;
use File::Spec::Functions;

extends 'DBIx::Class::Schema';

our $VERSION = '0.004';

has cache_storage => ( is => 'lazy' );
sub _build_cache_storage {
    my $path = catdir( $ENV{HOME}, qw/ .tzxserver cache / );
    make_path( $path ) if ( !-d $path );
    return $path;
}

sub storage_dir( $self, $dir ) {
    my $path = catdir( $self->cache_storage, $dir );
    make_path( $path ) if ( !-d $path );
    return $path;
}

sub storage_file( $self, $file ) {
    catfile( $self->cache_storage, $file );
}

sub db_upgrade( $self ) {
    my $db_version = $self->get_db_version;

    if ( $db_version ne $VERSION ) {

        $self->create_ddl_dir(
            undef, $VERSION,
            'migrate', $db_version
        );

        if ($db_version) {
            $self->upgrade();
        }
        else {
            $self->deploy();
        }
    }
}


__PACKAGE__->load_namespaces();
__PACKAGE__->load_components(qw/
    Schema::Versioned
/);
__PACKAGE__->upgrade_directory('migrate');

1;

