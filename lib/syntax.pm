use strict;
use warnings;

# ABSTRACT: Activate syntax extensions

package syntax;

use Data::OptList qw( mkopt );

use namespace::clean;

$Carp::Internal{ +__PACKAGE__ }++;

sub import {
    my ($class, @args) = @_;

    my $caller = caller;
    my $import = mkopt \@args;

    for my $declaration (@$import) {
        my ($feature, $options) = @$declaration;

        $class->_install_feature($feature, $caller, $options);
    }

    return 1;
}

sub _install_feature {
    my ($class, $feature, $caller, $options) = @_;

    my $name =
        join '',
        map ucfirst,
        split /_/, $feature;

    my $file    = "Syntax/Feature/${name}.pm";
    my $package = "Syntax::Feature::${name}";

    require $file;
    return $package->install(
        into        => $caller,
        options     => $options,
        identifier  => $feature,
    );
}

1;

=head1 SYNOPSIS

    # either
    use syntax 'foo';

    # or
    use syntax foo => { ... };

    # or
    use syntax qw( foo bar ), baz => { ... };

=head1 DESCRIPTION

This module activates community provided syntax extensions to Perl. You pass it
a feature name, and optionally a scalar with arguments, and the dispatching 
system will load and install the extension in your package.

The import arguments are parsed with L<Data::OptList>. There are no 
standardised options. Please consult the documentation for the specific syntax
feature to find out about possible configuration options.

The passed in feature names are simply transformed: C<function> becomes
L<Syntax::Feature::Function> and C<foo_bar> would become 
C<Syntax::Feature::FooBar>.

=head1 RECOMMENDED FEATURES

=over

=item * L<Syntax::Feature::Function>

Activates functions with parameter signatures.

=back

=head1 SEE ALSO

L<Syntax::Feature::Function>,
L<Devel::Declare>

=cut
