#! perl -w

use lib qw(../blib/lib ../blib/arch ../blib/lib/auto ../blib/arch/auto);

use File::LibMagic qw(magic_buffer magic_file magic_open magic_load mb magic_close);
use Benchmark qw(timethese cmpthese);

my $handle=magic_open(0);
my $ret   =magic_load($handle,"");

my $r=timethese(5000, {
	a => sub { my $a=magic_buffer("Hi\n"); },
	b => sub { my $a=magic_buffer("Hi\n"); },
	c => sub { my $a=mb($handle,"Hi\n"); }
	} );

cmpthese($r);

magic_close($handle);

