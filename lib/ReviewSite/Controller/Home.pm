package ReviewSite::Controller::Home;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ReviewSite::Controller::Home - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( title => 'Home' );
    
    #FIXME: How to autoupdate avg_rate field?
    my $places = $c->model( 'DB::Place' )->search_rs({});
    while (my $place = $places->next) { 
    	$place->update({'avg_rate' => $place->rate}); 
    }
    #####
    my $hotel_rs    = $c->model( 'DB::Place' )->search_rs( { type_id => '1' } );
    my $restaurants = $c->model( 'DB::Place' )->top3();
    $c->stash( hotels => $hotel_rs );
    $c->stash( restaurants => $restaurants );
}

=head2 base

sub base :Chained( '/' ) :PathPart( 'home' ) :CaptureArgs( 1 ) {
	my ( $self,$c ) = @_;
	my $place = $c->model( 'DB::Place' );
	
	my $hotel_rs = $c->$place->search_rs( {type_id => '1' } );
	$c->stash( hotels => $hotel_rs );
	
	
	
	
}
=cut
	
	






=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
