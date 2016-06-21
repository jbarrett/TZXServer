package TZXServer;

use Dancer2;
use Dancer2::Plugin::DBIC;

setting( session => 'PSGI' );

use Try::Tiny;
use URI;

our $VERSION = schema('default')->{VERSION};

BEGIN {
    rset('Tape')->import;
}

get '/' => sub {
    template 'index';
};

get '/tape/:id' => sub {
    my $tape = rset('Tape')
        ->find( route_parameters->get('id') );

    if ( !$tape ) {
        status 404;
        return "Not found"
    }

    try {
        $tape->unroll;
    }
    catch {
        status 500;
        return $_;
    };

    template 'tape', {
        tape => $tape,
    }
};

get '/play/:id/:filename' => sub {
    my $filetype = config->{prefer} || 'mp3';

    my $file = rset('Tape::File')->search( {
        tape_id  => route_parameters->get('id'),
        filename => route_parameters->get('filename'),
    } )->one_row;

    if ( !$file ) {
        status 404;
        return "Not found";
    }

    if ( $file->username && ( !session('user') || $file->username ne session('user') ) ) {
        status 403;
        return "Forbidden";
    }

    redirect( URI->new(
        sprintf( '/cache/%s', $file->cache_path( $filetype ) )
    )->canonical );
};

any '/search' => sub {
    my $query = param('q');
    $query = join ' ', @{ $query } if ref $query eq 'ARRAY';

    template 'results', {
        query => $query,
        tapes => rset('Tape')
            ->by_title( $query )
            ->hri
            ->all_ref,
    }
};

get '/login' => sub {
    template 'login.tx';
};

post '/login' => sub {
    my $username = body_parameters->get('username');
    my $password = body_parameters->get('password');

    my $user = rset('User')->find_lc( $username );

    if ( !$user ) {
        status 400;
        return template 'login.tx', {
            username => $username,
            msg      => "Incorrect username",
        }
    }

    if ( !$user->check_password( $password ) ) {
        status 400;
        return template 'login.tx', {
            username => $username,
            msg      => "Incorrect passsword",
        }
    }

    session user => $user->username;
    redirect '/';
};

get '/register' => sub {
    template 'register.tx';
};

post '/register' => sub {
    my $username = body_parameters->get('username');
    my $password = body_parameters->get('password');

    if ( rset('User')->find_lc( $username ) ) {
        status 403;
        return template 'register.tx', {
            username => $username,
            msg      => "This username exists, please choose another",
        };
    }

    my $user = rset('User')->create( {
        username => $username,
        password => $password,
    } );

    if ( $user ) {
        session user => $user->username;
        redirect '/';
    }

};

post '/upload' => sub {
    if ( ! session('user') ) {
        status 403;
        return q{¯\_(ツ)_/¯};
    }
    my $tape_id = body_parameters->get('tape_id');
    my $upload = upload('file');

    my $foo = rset('Tape::File')->create_from_upload( $upload, session('user'), $tape_id );
    use DDP;p $foo;

    redirect "/tape/$tape_id";
};

get '/logout' => sub {
    app->destroy_session;
    redirect '/';
};

1;
