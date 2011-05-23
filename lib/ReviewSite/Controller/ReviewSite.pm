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

sub base :Chained( '/' ) :PathPart( 'reviewSite' ) :CaptureArgs(1) {
    my( $self,$c,$place_id ) = @_;
    my $form = $c->stash-> { form };
    $c->stash( place => $c->model( 'DB::Place' )->find($place_id) );
}

=head2 searchBusiness
Use HTML::FormFu 
=cut

sub searchBusiness :Local :FormConfig {
    my( $self,$c ) = @_;	
    my $form = $c->stash->{ form };
	my @type_objs = $c->model( "DB::Type" )->all();
	my @types;
	$c->stash( title => 'Write a review' );
	#use Data::Dumper;
	#$c->log->debug(Dumper(@type_objs));
    foreach ( @type_objs ) {
        push( @types, [$_->id, $_->placename ] );
        # Get the select added by the config file
    }
    my $select = $form->get_all_element( { type => 'Select' } );
    $select->options( \@types );
    $c->stash( x => 0);
    if ( $form->submitted_and_valid ) {
        my $types  = $form->param_value( 'types' );
        my $bname  = $form->param_value( 'business_name' );
        my $result = $c->model( 'DB::Place' )->find( { placename => $bname,type_id => $types } );
        
        if ( $result ) { 
            #show value to template
            #my $review_rs = $c->model( 'DB::Review' )->search({ place_id => $result->place_id()  });
            my $review_rs = $result->review;
            $c->stash(value => 1 , review_rs => $review_rs ,review => $result ,place_id => $result->place_id() ,place => $result);
        } else {
        	#no value ADD new
            $c->stash( value => 2 );
          
        }
   
    }
	
}

=head2 addPlace
Use HTML::FormFu 
=cut

sub addPlace :Local {
	my ( $self,$c ) = @_;
	my $placename  = $c->request->param( 'placename' );
	my $location   = $c->request->param( 'location' );
	my $latitude   = $c->request->param( 'lat' );
	my $longitude  = $c->request->param( 'lng' );
	my $types      = $c->request->param( 'types' );
	my $detail     = $c->request->param( 'detail' );
    my $rate       = $c->request->param( 'rate' );
    my $user_id    = $c->user->user_id;
    $c->stash( title => 'ADD NEW PALCE' );
    #use Data::Dumper;
    #$c->log->debug(Dumper($types));
    my $list       = $c->model( 'DB::Type' );
    $c->stash( types_rs => $list );
	if( $c->req->method eq 'POST' ) {
		my $place;
        $place = $c->model( 'DB::Place' )->create( {
			placename  => $placename,
		    la         => $latitude,
			long       => $longitude,
			location   => $location,
			type_id         => $types ,
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

=head2 writeReview
Use HTML::FormFu 
=cut
sub writeReview :Chained( 'base' ) :PathPart( 'writeReview' ) :Args(0) :FormConfig {
    my ( $seldf,$c,$place_id ) = @_;
    my $form    = $c->stash-> { form };
    my $user_id = $c->user->user_id;
    my $place = $c->stash->{ place };
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
