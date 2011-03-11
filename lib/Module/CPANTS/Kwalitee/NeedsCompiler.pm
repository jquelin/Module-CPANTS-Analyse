use warnings;
use strict;

package Module::CPANTS::Kwalitee::NeedsCompiler;
# ABSTRACT: Checks if the module needs a (probably C) compiler

sub order { 200 }

##################################################################
# Analyse
##################################################################

sub analyse {
    my $class=shift;
    my $me=shift;
    
    my $files=$me->d->{files_array};
    foreach my $f (@$files) {
        if ($f =~ /\.[hc]$/i or $f =~ /\.xs$/i) {
            $me->d->{needs_compiler}=1;
            return;
        }
    }
    if (defined ref($me->d->{prereq}) and ref($me->d->{prereq}) eq 'ARRAY') {
        for my $m (@{ $me->d->{prereq} }) {
            if ($m->{requires} =~ /^Inline::/
               or $m->{requires} eq 'ExtUtils::CBuilder'
               or $m->{requires} eq 'ExtUtils::ParseXS') {
                $me->d->{needs_compiler}=1;
                return;
            }
        }
    }
    return;
}

##################################################################
# Kwalitee Indicators
##################################################################

sub kwalitee_indicators{
    return [
    ];
}


q{Favourite compiler:
  gcc};

__END__

=pod

=head1 DESCRIPTION

Checks if there is some indication in the module that it needs a C compiler to build and install

=head2 Methods

=head3 order

Defines the order in which Kwalitee tests should be run.

Returns C<200>.

=head3 analyse

Checks for file with .c, .h or .xs extensions.
Check is the module depends on any of the Inline:: modules or
on ExtUtils::CBuilder or ExtUtils::ParseXS.

=head3 TODO:

How to recognize cases such as http://search.cpan.org/dist/Perl-API/ 
and http://search.cpan.org/dist/Term-Size-Perl
that generate the .c files during installation

In addition there are modules that can work without their XS part.
E.g. Scalar-List-Utils, Net-DNS, Template-Toolkit 
For our purposes these all should be marked as "need C compiler"
as they need it for their full functionality and speed.
 
=head3 kwalitee_indicators

No Kwalitee Indicator.

=cut
