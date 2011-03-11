use warnings;
use strict;

package Module::CPANTS::Kwalitee::Repackageable;
# ABSTRACT: Checks for various signs that make a module packageable

use File::Spec::Functions qw(catfile);
use List::MoreUtils qw(all any);
#use  Pod::Simple::TextContent;


sub order { 900 }

##################################################################
# Analyse
##################################################################

sub analyse {
    my $class=shift;
    my $me=shift;

   
    return;
}

##################################################################
# Kwalitee Indicators
##################################################################

sub kwalitee_indicators{
    return [
         {
            name=>'easily_repackageable_by_debian',
            error=>qq{It is easy to repackage this module by Debian.},
            remedy=>q{Fix each one of the metrics this depends on},
            aggregating => [qw(no_generated_files has_tests_in_t_dir no_stdin_for_prompting)],
            is_experimental=>1,
            code=>\&_aggregator,
         },
         {
            name=>'easily_repackageable_by_fedora',
            error=>qq{It is easy to repackage this module by Fedora.},
            remedy=>q{Fix each one of the metrics this depends on},
            aggregating=> [qw(no_generated_files fits_fedora_license)],
            is_experimental=>1,
            code=>\&_aggregator,
        },
         {
            name=>'easily_repackageable',
            error=>qq{It is easy to repackage this module. See <a href="http://www.perlfoundation.org/perl5/index.cgi?cpan_packaging">cpan_packaging</a> },
            remedy=>q{Fix each one of the metrics this depends on},
            aggregating=>[qw(easily_repackageable_by_debian easily_repackageable_by_fedora)],
            is_experimental=>1,
            code=>\&_aggregator,
        },
    ];
}

sub _aggregator { 
    my $d=shift;
    my $metric=shift;

    my @errors = grep { !$d->{kwalitee}{$_} } @{ $metric->{aggregating} };
    if (@errors) {
        $d->{error}{ $metric->{name} } = join ", ", @errors;
        return 0;
    }
    return 1;
}

q{Favourite record of the moment:
  Lili Allen - Allright, still};

__END__

=pod

=head1 DESCRIPTION

There are several agregate metrics in here.

=head2 Methods

=head3 order

Defines the order in which Kwalitee tests should be run.

=head3 analyse

=head3 kwalitee_indicators

Returns the Kwalitee Indicators datastructure.

=over

=item * easily_repackageable

=item * easily_repackageable_by_fedora

=back


=cut
