#! perl -w

use lib qw(../blib/lib ../blib/arch ../blib/lib/auto ../blib/arch/auto);

use strict;
use File::LibMagic ':easy';

print MagicBuffer("Hello World\n"),"\n";

