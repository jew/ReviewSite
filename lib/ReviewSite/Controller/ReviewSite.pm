package ReviewSite::Controller::ReviewSite;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }


=head1 NAME

ReviewSite::Controller::Review - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 base

=cut

sub base :Chained( '/' ) :PathPart( 'reviewSite' ) :CaptureArgs( 1 ) {
    my( $self,$c,$place_id, ) = @_;
    my $form = $c->stash-> { form };
    $c->stash( place => $c->model( 'DB::Place' )->find( $place_id ) );
}

=head2 searchBusiness
Use HTML::FormFu 
=cut

sub searchBusiness :Local :FormConfig {
    my( $self,$c )  = @_;	
    my $form        = $c->stash->{ form };
    my $type        = $c->model( "DB::Type" );
    my $select      = $form->get_all_element( { type => 'Select' } );
    $select->options( $type->select() );
    $c->stash( x     => 0);
    $c->stash( title => 'Write a review' );
    if ( $form->submitted_and_valid ) {
        my $types    = $form->param_value( 'types' );
        my $bname    = $form->param_value( 'business_name' );
        my @keywords = split( /\s+/, $bname );
        my @cond;
        foreach my $keyword ( @keywords ) {
            push(@cond, {'placename' => { 'like' => "%$keyword%" } } );	
        }
        #$c->log->debug("------------>id" . $types);
        my $result = $c->model( 'DB::Place' )->search( {
            type_id => $types,
            -and => \@cond,
        } );
        if ( $result !=0 ) { 
           $c->stash( value => 1, places => $result );
        } else {
        	#no value ADD new
            $c->stash( value => 0 );     
        }
   }	
}

=head2 addPlace
Use HTML::FormFu 
=cut

sub addPlace :Local :FormConfig {
	my ( $self,$c ) = @_;
	my $form        = $c->stash->{ form };
    $c->stash( title => 'ADD NEW PALCE' );
    my $type   = $c->model( "DB::Type" );
    my $select = $form->get_all_element( { type => 'Select' } );
    $select->options( $type->select() );   

    if ( $form->submitted_and_valid ) {
        my $types      = $form->param_value( 'types' );
		my $placename  = $form->param_value( 'placename' );
		my $location   = $form->param_value( 'location' );
		my $latitude   = $form->param_value( 'lat' );
		my $longitude  = $form->param_value( 'lng' );
		my $detail     = $form->param_value( 'detail' );
	    my $rate       = $form->param_value( 'rate' );
	    my $user_id    = $c->user->user_id;
	    
        if( $c->req->method eq 'POST' ) {
	        my $place;
	        $place = $c->model( 'DB::Place' )->create( {
	            placename  => $placename,
	            la         => $latitude,
	            long       => $longitude,
	            location   => $location,
	            type_id    => $types ,
	        } );
	        #insert into Review
	        my $place_id = $place->place_id();
	        $c->model( 'DB::Review' )->create( {
	            place_id =>  $place_id,
	            user_id  => $user_id ,
	            detail   => $detail,
	            rate     => $rate,
	        } );
	        $c->stash( status_msg => "complete!" );
        }
    }
}

=head2 writeReview
Use HTML::FormFu 
=cut
sub writeReview :Chained( 'base' ) :PathPart( 'writeReview' ) :Args(0) :FormConfig {
    my ( $seldf,$c,$place_id ) = @_;
    my $form    = $c->stash-> { form };
    my $user_id = $c->user->user_id;
    my $place   = $c->stash->{ place };
    $c->stash( title         => 'Write a review' );
    $c->stash( placename     => $place->placename() );
    $c->stash( typeplacename => $place->type->placename() );
    if ( $form->submitted_and_valid ) {
        my $detail  = $form->param_value( 'detail' );  
        my $rate    = $form->param_value( 'rating' );  	
    	my $result  = $c->model( 'DB::Review' )->create({
    	   place_id => $place->place_id(),
    	   user_id  => $user_id,
    	   detail   => $detail,
    	   rate     => $rate,	
        } );
        $c->stash( status_msg => "complete!" );
    } 
}

=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
