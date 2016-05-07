package TZXServer::Schema::Result::Tape::File;

use TZXServer::Base::Imports;
extends 'TZXServer::Schema::Result';

use DBIx::Class::Candy -autotable => v1;
use File::Which qw/ which /;
use File::Spec::Functions;
use IPC::Run qw/ run timeout /;
use File::chdir;

primary_column tape_id  => { data_type => 'integer' };
primary_column filename => { data_type => 'text' };

has playtzx => ( is => 'lazy' );
sub _build_playtzx {
    which 'playtzx';
}

has tape2wav => ( is => 'lazy' );
sub _build_tape2wav {
    which 'tape2wav';
}

has lame => ( is => 'lazy' );
sub _build_lame {
    which 'lame';
}

has oggenc => ( is => 'lazy' );
sub _build_oggenc {
    which 'oggenc';
}

has sox => ( is => 'lazy' );
sub _build_sox {
    which 'sox';
}

sub fullpath( $self, $path = "" ) {
    $self->schema->storage_file( $path || $self->tzx );
}

sub tzx( $self ) {
    catfile( $self->tape_id, $self->filename );
}

sub make_wav( $self ) {
    $self->throw_exception("playtzx or tape2wav requried for wav output")
        if ( !$self->playtzx && !$self->tape2wav );

    my $tzx = $self->tzx =~ s{.*/(.*)}{$1}r;
    my $wav = $tzx =~ s/tzx$/wav/ir;
    my $au  = $tzx =~ s/tzx$/au/ir;
    my ( $i, $o, $e );

    {
        local $CWD = $self->schema->storage_dir( $self->tape_id );
        if ( $self->tape2wav ) {

            run [
                $self->tape2wav, $tzx, $wav
            ], \$i, \$o, \$e, timeout( 30 )
                or $self->throw_exception( "E$? :\n$e\n$o\n" );

        }
        elsif ( $self->playtzx ) {
            $self->throw_exception("SoX is required to use playtzx")
                if !$self->sox;

            run [
                $self->playtzx,
                '-freq', '44100', '-au',
                $tzx, $au,
            ], \$i, \$o, \$e, timeout( 30 )
                or $self->throw_exception( "E$? :\n$e\n$o\n" );

            run [
                $self->sox, $au, '-n', 'stat', '-v'
            ], \$i, \$o, \$e, timeout( 30 )
                or $self->throw_exception( "E$? :\n$e\n$o\n" );

            my @gain = ( $o - 1 > 0 ) ? ( '-v', $o - 1 ) : ();

            run [
                $self->sox, @gain, $au, $wav
            ], \$i, \$o, \$e, timeout( 30 )
                or $self->throw_exception( "E$? :\n$e\n$o\n" )
        }
    };
}

sub wav( $self ) {
    my $filename = $self->tzx =~ s/tzx$/wav/ir;
    my $fullpath = $self->fullpath( $filename );
    $self->make_wav if ( !-f $fullpath );
    return $filename;
}

sub make_mp3( $self ) {
    $self->throw_exception("lame requried for mp3 output") if !$self->lame;

    my $wav = $self->wav =~ s{.*/(.*)}{$1}r;
    my $mp3 = $wav =~ s/wav$/mp3/ir;
    my ( $i, $o, $e );

    {
        local $CWD = $self->schema->storage_dir( $self->tape_id );

        run [
            $self->lame,
            '-s', '44.1',
            '-m', 'm',
            '-V', '1.5',
            $wav
        ], \$i, \$o, \$e, timeout( 30 )
            or $self->throw_exception( "E$? :\n$e\n$o\n" );
    }
}

sub mp3( $self ) {
    my $filename = $self->tzx =~ s/tzx$/mp3/ir;
    my $fullpath = $self->fullpath( $filename );
    $self->make_mp3 if ( !-f $fullpath );
    return $filename;
}

sub make_ogg( $self ) {
    $self->throw_exception("oggenc requried for vorbis output") if !$self->oggenc;

    my $wav = $self->wav =~ s{.*/(.*)}{$1}r;
    my $ogg = $wav =~ s/wav$/ogg/ir;
    my ( $i, $o, $e );

    {
        local $CWD = $self->schema->storage_dir( $self->tape_id );

        run [
            $self->oggenc,
            '-q', '5',
            $wav
        ], \$i, \$o, \$e, timeout( 30 )
            or $self->throw_exception( "E$? :\n$e\n$o\n" );
    }
}

sub ogg( $self ) {
    my $filename = $self->tzx =~ s/tzx$/ogg/ir;
    my $fullpath = $self->fullpath( $filename );
    $self->make_ogg if ( !-f $fullpath );
    return $filename;
}

1;
