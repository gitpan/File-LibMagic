#! perl -w

use lib qw(../blib/lib ../blib/arch ../blib/lib/auto ../blib/arch/auto);

use File::LibMagic ':easy';
use Benchmark qw(timethese cmpthese);

print MagicBuffer("Hello World\n"),"\n";
print MagicFile("/bin/ls"),"\n";

my $r=timethese(10_000, {
	  a => sub { my $a=MagicBuffer("Hi\n"); },
	  b => sub { my $a=MagicBuffer("Hi\n"); }
      } );

cmpthese($r);

