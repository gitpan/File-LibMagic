
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.09

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/File/LibMagic.pm',
    't/00-compile.t',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/all-exports.t',
    't/author-eol.t',
    't/author-no-tabs.t',
    't/author-pod-spell.t',
    't/basic.t',
    't/complete-interface-errors.t',
    't/complete-interface.t',
    't/easy-interface.t',
    't/lib/Test/AnyOf.pm',
    't/oo-api.t',
    't/release-cpan-changes.t',
    't/release-pod-coverage.t',
    't/release-pod-linkcheck.t',
    't/release-pod-syntax.t',
    't/release-portability.t',
    't/release-synopsis.t',
    't/samples/foo.c',
    't/samples/foo.foo',
    't/samples/foo.txt',
    't/samples/magic',
    't/samples/magic.mime',
    't/version.t'
);

notabs_ok($_) foreach @files;
done_testing;
