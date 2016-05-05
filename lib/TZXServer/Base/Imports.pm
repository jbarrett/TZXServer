package TZXServer::Base::Imports;

use strict;
use warnings;
use v5.22.1;
use feature 'signatures';
no warnings 'experimental::signatures';

use Import::Into;
use Carp;

{
    sub import ( $module, $type = 'class' ) {
        my ( $caller, $filename ) = caller;

        for my $use ( qw/
                strict warnings utf8 autodie
                Carp File::Spec::Functions
            / ) {
            $use->import::into( $caller );
        }

        for my $feature ( qw/ :5.22.1 signatures state / ) {
            feature->import::into( $caller, $feature );
        }

        if ( $type eq 'role' ) {
            require Moo::Role;
            Moo::Role->import::into( $caller );
        }
        else {
            require Moo;
            Moo->import::into( $caller );
        }

        warnings->unimport::out_of( $caller, 'experimental::signatures' );
        warnings->unimport::out_of( $caller, 'experimental::smartmatch' );
    }
};

1;

