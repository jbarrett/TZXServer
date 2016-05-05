package TZXServer;

use Dancer2;
use Dancer2::Plugin::DBIC qw/ schema rset /;

our $VERSION = schema('default')->{VERSION};

get '/' => sub {
    template 'index';
};

1;
