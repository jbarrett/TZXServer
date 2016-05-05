#!/usr/bin/env perl

use strict;
use warnings;

use Dancer2;
use Dancer2::Plugin::DBIC qw/ schema rset /;

my $schema = schema('default');
$schema->upgrade;

