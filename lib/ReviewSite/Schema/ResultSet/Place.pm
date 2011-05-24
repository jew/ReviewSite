package ReviewSite::Schema::ResultSet::Place;
use strict;
use warnings;

use base 'DBIx::Class::ResultSet';

sub top3 {
	my $self = shift;
	return $self->search_rs( {type_id => '4'}, { order_by => { -desc => 'avg_rate'}, rows => 3 } );
}

1;