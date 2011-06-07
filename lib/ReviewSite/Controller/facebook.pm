package ReviewSite::Controller::facebook;
use Moose;
use namespace::autoclean;
use WWW::Facebook::API;
use Scalar::Util qw();
# why not
#*fb = \&facebook;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ReviewSite::Controller::facebook - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index : Path( '/login/facebook' ) {
    my ( $self, $c ) = @_;
    if( $c->authenticate( {}, 'facebook' ) ) {    	
        my  $user = $c->model( 'DB::User' );
        $c->fb_user_update( $user );
        $c->res->redirect( $c->uri_for( '/home' ) );
    }
 }

=head2 logout
 Destroy current session.
=cut

sub logout : Path( '/logout' ) {
    my ( $self, $c ) = @_;
    $c->logout;
        $c->res->redirect( $c->uri_for( '/home' ) );
}

=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
