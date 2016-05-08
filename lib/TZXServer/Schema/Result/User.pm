package TZXServer::Schema::Result::User;

use TZXServer::Base::Imports;
extends 'TZXServer::Schema::Result';

use DBIx::Class::Candy -autotable => v1;
use Crypt::PBKDF2;

primary_column username => { data_type => 'text' };

column password => { data_type => 'text' };

__PACKAGE__->filter_column( password => {
        filter_from_storage => sub { $_[1]; },
        filter_to_storage   => sub ( $self, $password ) {
            use DDP; p $self->pbkdf2->generate( $password );
            $self->pbkdf2->generate( $password );
        },
    }
);

has pbkdf2 => ( is => 'lazy' );
sub _build_pbkdf2 {
    Crypt::PBKDF2->new(
        hash_class => 'HMACSHA2',
        hash_args => {
            sha_size => 512,
        },
        iterations => 5000,
        salt_len => 10,
    );
}

sub check_password( $self, $password ) {
    $self->pbkdf2->validate( $self->password, $password );
}

1;
