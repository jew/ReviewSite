package ReviewSite::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

ReviewSite::Controller::Root - Root Controller for ReviewSite

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->body( $c->welcome_message );
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 auto
Check if there is  user and, if not, forward to login page
=cut
sub auto :Private {
    my ( $self, $c ) = @_;
    if ( $c->controller eq $c->controller( 'Login' ) ) {
        return 1;
    }
        # If a user doesn't exist, force login
    if ( !$c->user_exists ) {
        $c->log->debug('***Root::auto User not found, forwarding to /login') if $c->debug;
        $c->response->redirect($c->uri_for('/login'));
        # Return 0 to cancel 
        return 0;
     }
    return 1;
}
=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
