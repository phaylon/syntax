#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use Test::More 0.94;
use Test::Fatal;

my $imported_options = do {
    package TestSyntaxExporter;
    use syntax 'test_foo' => { -version => '0.001', bar => 23 };
    foo;
};

is_deeply $imported_options, { bar => 23 }, 'version requirement removed from options';

like exception { syntax->import(test_foo => { -version => '0.002' }) },
    qr{^Syntax::Feature::TestFoo version 0\.002 required--this is only version 0\.001},
    'Correct exception when required version exceeds installed version';

like exception { syntax->import('test_foo/bar' => { -version => '0.002' }) },
    qr{^Syntax::Feature::TestFoo::Bar does not define \$Syntax::Feature::TestFoo::Bar::VERSION--version check failed},
    'Correct exception when required module does not define a version';

done_testing;
