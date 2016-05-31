#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Plack::Builder;
use Plack::App::File;
use Plack::Session::Store::Cache;
use File::Spec::Functions;
use CHI;
use TZXServer;

builder {
    enable 'Session',
        store => Plack::Session::Store::Cache->new(
            cache => CHI->new(driver => 'FastMmap')
        );
    mount '/' => TZXServer->to_app;
    mount '/cache' => Plack::App::File->new(
        root => catdir( $ENV{HOME}, qw/ .tzxserver cache / )
    )->to_app;
}
