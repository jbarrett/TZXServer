package TZXServer::Schema;

use TZXServer::Base::Imports;

extends 'DBIx::Class::Schema';

our $VERSION = '0.001';

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

