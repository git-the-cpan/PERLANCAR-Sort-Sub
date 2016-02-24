package Sort::Sub::perlancar_prereq_sort;

our $DATE = '2016-02-25'; # DATE
our $VERSION = '0.01'; # VERSION

use 5.010;
use strict;
use warnings;

sub gen_sorter {
    my ($is_reverse, $is_ci) = @_;

    sub {
        no strict 'refs';

        my $caller = caller();
        my $a = ${"$caller\::a"};
        my $b = ${"$caller\::b"};

        my $cmp = 0;
        {
            my $a_is_perl = $a eq 'perl' ? 1:0;
            my $b_is_perl = $b eq 'perl' ? 1:0;

            my $a_is_pragma = $a =~ /\A[a-z]/;
            my $b_is_pragma = $b =~ /\A[a-z]/;

            $cmp =
                ($b_is_perl <=> $a_is_perl) ||
                ($b_is_pragma <=> $a_is_pragma) ||
                lc($a) cmp lc($b);
        }

        $is_reverse ? -1*$cmp : $cmp;
    };
}

1;
# ABSTRACT: Sort prereqs PERLANCAR-style

__END__

=pod

=encoding UTF-8

=head1 NAME

Sort::Sub::perlancar_prereq_sort - Sort prereqs PERLANCAR-style

=head1 VERSION

This document describes version 0.01 of Sort::Sub::perlancar_prereq_sort (from Perl distribution PERLANCAR-Sort-Sub), released on 2016-02-25.

=head1 DESCRIPTION

I sort my prereqs in F<dist.ini> using this rule: C<perl>, then pragmas (sorted
ascibetically), then other modules (sorted ascibetically and
case-insensitively).

Case-sensitive option is ignored. Sorting is always done using the
abovementioned rule.

=for Pod::Coverage ^(gen_sorter)$

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/PERLANCAR-Sort-Sub>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-PERLANCAR-Sort-Sub>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=PERLANCAR-Sort-Sub>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
