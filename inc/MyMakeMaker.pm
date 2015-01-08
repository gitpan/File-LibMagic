package inc::MyMakeMaker;

# ABSTRACT: build a Makefile.PL that uses ExtUtils::MakeMaker
use Moose;
use Moose::Autobox;

use namespace::autoclean;

extends 'Dist::Zilla::Plugin::MakeMaker::Awesome';

override _build_WriteMakefile_args => sub {
    my $self = shift;

    my $args = super();

    $args->{LIBS}   = ['-lmagic'];
    $args->{INC}    = '-I. -Ic';
    $args->{XS}     = { 'lib/File/LibMagic.xs' => 'lib/File/LibMagic.c' };
    $args->{C}      = ['lib/File/LibMagic.c'];
    $args->{OBJECT} = 'lib/File/LibMagic$(OBJ_EXT)';
    $args->{LDFROM} = 'LibMagic$(OBJ_EXT)';

    delete $args->{VERSION};
    $args->{VERSION_FROM} = 'lib/File/LibMagic.pm';

    return $args;
};

override _build_WriteMakefile_dump => sub {
    my $self = shift;

    my $dump = super();
    $dump .= <<'EOF';
$WriteMakefileArgs{DEFINE} = _defines();
unshift @{ $WriteMakefileArgs{LIBS} }, _libs();
$WriteMakefileArgs{INC} = join q{ }, _includes(), $WriteMakefileArgs{INC};

EOF

    return $dump;
};

override _build_MakeFile_PL_template => sub {
    return super() . do { local $/; <DATA> };
};

__PACKAGE__->meta->make_immutable;

1;

__DATA__

use lib qw( inc );
use Config::AutoConf;
use Getopt::Long;

my @libs;
my @includes;

sub _libs     { return @libs }
sub _includes { return @includes }

sub _defines {
    GetOptions(
        'lib:s@'     => \@libs,
        'include:s@' => \@includes,
    );

    my $ac = Config::AutoConf->new(
        extra_link_flags    => [ map { '-L' . $_ } @libs ],
        extra_include_flags => [ map { '-I' . $_ } @includes ],
    );

    _check_libmagic($ac);

    return $ac->check_lib( 'magic', 'magic_version' )
        ? '-DHAVE_MAGIC_VERSION'
        : q{};
}

sub _check_libmagic {
    my $ac = shift;

    return
        if $ac->check_header('magic.h')
        && $ac->check_lib( 'magic', 'magic_open' );

    warn <<'EOF';

  This module requires the libmagic.so library and magic.h header. See
  INSTALL.md for more details on installing these.

EOF

    exit 1;
}
