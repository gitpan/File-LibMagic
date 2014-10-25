package inc::MyInstallGuide;

use Dist::Zilla::File::FromCode;
use Moose;
use Moose::Autobox;

use namespace::autoclean;

with 'Dist::Zilla::Role::FileGatherer';
with 'Dist::Zilla::Role::TextTemplate';

my $content = <<'EOF';
# Installing File-LibMagic

Installing File-LibMagic requires that you have the *libmagic.so* library and
the *magic.h* header file installed. Once those are installed, this module is
installed like any other Perl distributions.

## Installing libmagic

On Debian/Ubuntu run:

    sudo apt-get install libmagic-dev

On Mac you can use homebrew (http://brew.sh/):

    brew install libmagic

## Installation with cpanm

If you have cpanm, you only need one line:

    % cpanm File::LibMagic

If you are installing into a system-wide directory, you may need to pass the
"-S" flag to cpanm, which uses sudo to install the module:

    % cpanm -S File::LibMagic

## Installing with the CPAN shell

Alternatively, if your CPAN shell is set up, you should just be able to do:

    % cpan File::LibMagic

## Manual installation

As a last resort, you can manually install it. Download the tarball, untar it,
then build it:

    % perl Makefile.PL
    % make && make test

Then install it:

    % make install

If you are installing into a system-wide directory, you may need to run:

    % sudo make install

## Documentation

File-LibMagic documentation is available as POD.
You can run perldoc from a shell to read the documentation:

    % perldoc File::LibMagic
EOF

sub gather_files {
    my $self = shift;

    $self->add_file(
        Dist::Zilla::File::FromCode->new(
            name => 'INSTALL.md',
            code => sub { $content },
        )
    );

    return;
}

__PACKAGE__->meta()->make_immutable();

1;
