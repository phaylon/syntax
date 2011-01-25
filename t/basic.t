#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test::More;

my $imported_options = do {
    package TestSyntaxImporter;
    use syntax test_foo => { bar => 23 };
    foo;
};

my $deep_imported_options = do {
    package TestSubSyntaxImporter;
    use syntax 'test_foo/bar' => { baz => 17 };
    bar;
};

is_deeply $imported_options, { bar => 23 },
    'imported options were received';
is_deeply $deep_imported_options, { baz => 17 },
    'imported subsyntax options were received';

done_testing;
