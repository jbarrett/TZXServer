package TZXServer::Schema::ResultSet;

use TZXServer::Base::Imports;
extends 'DBIx::Class::ResultSet';

sub schema {
    shift->result_source->schema;
}

sub rs {
    shift->result_source->schema->resultset(@_);
}

__PACKAGE__->load_components(qw/
    Helper::ResultSet::Me
    Helper::ResultSet::Shortcut
    Helper::ResultSet::OneRow
/);

1;

