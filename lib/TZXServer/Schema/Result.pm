package TZXServer::Schema::Result;

use TZXServer::Base::Imports;

extends 'DBIx::Class::Core';

sub schema {
    $_[0]->result_source->schema;
}

sub rs {
    shift->result_source->schema->resultset(@_);
}

1;
