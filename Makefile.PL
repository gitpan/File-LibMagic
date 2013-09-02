
use strict;
use warnings;

use 5.008;

use ExtUtils::MakeMaker 6.30;

use lib qw( inc );
use Devel::CheckLib;

check_lib_or_exit( lib => 'magic', header => 'magic.h' );




my %WriteMakefileArgs = (
  "ABSTRACT" => "Determine MIME types of data or files using libmagic",
  "AUTHOR" => "Andreas Fitzner, Michael Hendricks <michael\@ndrix.org>, Dave Rolsky <autarch\@urth.org>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "File-LibMagic",
  "EXE_FILES" => [],
  "INC" => "-I.",
  "LIBS" => [
    "-lmagic"
  ],
  "LICENSE" => "perl",
  "NAME" => "File::LibMagic",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Exporter" => 0,
    "XSLoader" => 0,
    "base" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => "0.88",
    "lib" => 0
  },
  "VERSION" => "1.00",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



