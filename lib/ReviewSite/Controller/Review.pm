package ReviewSite::Controller::Review;
use Moose;
use namespace::autoclean;

#BEGIN {extends 'Catalyst::Controller'; }
BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

ReviewSite::Controller::Review - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 base
=cut

sub base :Chained( '/' ) :PathPart( 'review' ) :CaptureArgs( 1 ) {
    my ( $self , $c, $review_id ) = @_;
    $c->stash( review_id => $review_id );


}


=head2 delete
=cut 

sub delete :Chained( 'base' ) :Args( 0 ) {
    my ( $self, $c ) = @_;
    my $review_id = $c->stash->{ review_id };
    $c->log->debug("------------->review_id" . $review_id ) if $c -> debug;
    if( $c->req->method eq 'POST' ) {
        #delete  
        $c->model( 'DB::Review' )->find( $review_id )->delete;
        $c->response->redirect( $c->uri_for( '/review/show' ) );
    }
    else {
        $c->stash( title => 'Delete review' );
    }; 
}


=head2 show
=cut 

sub show :Local  {
	my ( $self, $c ) = @_;
    #$c->response->body('Reviewshow.pm');
    $c->stash( title => 'Your Reviews' );
    $c->log->debug("-------------------------->" . $c->user->user_id) if $c -> debug;
    my $review_rs = $c->model( 'DB::Review' )->search( { user_id => $c->user->user_id } );
    use Data::Dumper;
    #$c->log->debug(Dumper($review_rs));
    $c->stash( review_rs => $review_rs );

}	


=head2 edit
edit user s review by FormFu
=cut

sub edit :Chained( 'base' ) :FormConfig {
    my ( $self,$c ) = @_ ;
    my $form        = $c->stash->{ form };
    my $review_id   = $c->stash->{ review_id };
    my $review      = $c->model('DB::Review' )->find( $review_id );
    $c->stash( review => $review );
    $c->stash( title  => "Edit Your Reviews" );
    if ( $form->submitted_and_valid ) {
            $form->model->update( $review );
            $c->res->redirect( $c->uri_for( "/review/show" ) );
            return;
        }
        $form->model->default_values( $review )
            if (! $form->submitted && $review);

}	
	
=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
