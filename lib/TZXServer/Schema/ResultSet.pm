package TZXServer::Schema::ResultSet;

use TZXServer::Base::Imports;
extends 'DBIx::Class::ResultSet';

sub schema {
    $_[0]->result_source->schema;
}

sub rs {
    shift->result_source->schema->resultset(@_);
}

sub all_ref {
    [ $_[0]->all ];
}

__PACKAGE__->load_components(qw/
    Helper::ResultSet::Me
    Helper::ResultSet::Shortcut
    Helper::ResultSet::OneRow
/);

1;

