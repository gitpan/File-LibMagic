#! perl -w

use lib qw(../blib/lib ../blib/arch ../blib/lib/auto ../blib/arch/auto);

use File::LibMagic qw(magic_buffer magic_file);
use Benchmark qw(timethese cmpthese);

print magic_buffer("Hello World\n"),"\n";
print magic_file("/bin/ls"),"\n";

my $r=timethese(10_000, {
	a => sub { my $a=magic_buffer("Hi\n"); },
	b => sub { my $a=magic_buffer("Hi\n"); }
	} );

cmpthese($r);

