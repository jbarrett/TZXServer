#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Plack::Builder;
use Plack::App::File;
use File::Spec::Functions;
use TZXServer;

builder {
    mount '/' => TZXServer->to_app;
    mount '/cache' => Plack::App::File->new(
        root => catdir( $ENV{HOME}, qw/ .tzxserver cache / )
    );
}
