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

is_deeply $imported_options, { bar => 23 },
    'imported options were received';

done_testing;
