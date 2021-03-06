package ReviewSite::Schema::ResultSet::Place;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

=head2 top3
select top 3 
=cut 

sub top3 {
	my $self = shift;
	return $self->search( { },
	 {  join     =>    'review',
	 	'+select'   => [ { avg => 'rate' },{ count => 'review.review_id' } ],
	    '+as'       => [ qw/avgrate count_review/ ],
	 	group_by => [ qw/me.place_id/ ], 
	 	order_by => { -desc => 'rate'},
	 	rows => 3 

	 } );
}

1;
