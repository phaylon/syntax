use strict;
use warnings;

package Syntax::Feature::TestFoo;

sub install {
    my ($class, %args) = @_;

    my $target  = $args{into};
    my $options = $args{options};

    no strict 'refs';
    *{ "${target}::foo" } = sub { $options };

    return 1;
}

1;
