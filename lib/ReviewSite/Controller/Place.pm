package ReviewSite::Controller::Place;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ReviewSite::Controller::Place - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ReviewSite::Controller::Place in Place.');
}

=head2 base
=cut

sub base :Chained( '/' ) :PathPart( 'place' ) :CaptureArgs( 1 ) {
    my ( $self , $c, $place_id ) = @_;
    $c->stash( place_id => $place_id );

}



=head2 show
show all places 
=cut
sub show :Local {
	my ( $self,$c ) = @_;
	my $type_id     = $c->request->param( 'type_id' );
	my $place_rs    = $c->model( 'DB::Place' )->search_rs( { type_id => $type_id } ); 
	$c->stash( place_rs => $place_rs );
	$c->stash( title    => 'All Places' );   
	
}


=head2 show
SAND-136 
Make a controller action that fetches all places of a given type 
=cut

sub review :Chained( 'base' ) :Args( 0 ) {
	my ( $self,$c ) = @_;
	my $place_id    = $c->stash->{ place_id };
	my $result      = $c->model( 'DB::Place' )->find( { place_id => $place_id } );
	$c->stash( place => $result ); 
	$c->stash( title     => 'Reviews' );	
}



=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
