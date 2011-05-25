package ReviewSite::Schema::ResultSet::Type;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

sub select {
	my $self = shift;
	my @type_objs = $self->all();
	my @types;
    foreach ( @type_objs ) {
        push( @types, [$_->id, $_->placename ] );
        # Get the select added by the config file
    }
    return \@types;
}

1;