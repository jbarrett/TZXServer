package TZXServer::Schema::ResultSet::User;

use TZXServer::Base::Imports;
extends 'TZXServer::Schema::ResultSet';

sub find_lc( $self, $username ) {
    $self->search( \[ 'LOWER(me.username) = ?', ( lc($username) ) ] )->one_row;
}

1;
