package ReviewSite::Schema::ResultSet::Type;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

sub select {
	my $self = shift;
	my @type_objs = $self->all();
    return \@type_objs;

}



1;