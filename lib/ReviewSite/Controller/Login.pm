package ReviewSite::Controller::Login;
use Moose;
use namespace::autoclean;
BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ReviewSite::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 login
  Login logic
=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    # Get the username and password from form
    my $username = $c->request->params->{ username };
    my $password = $c->request->params->{ password };
    $c->stash( title => 'Login' );
    $c->stash( template => 'login.tt' );
    if( $c->req->method eq 'POST' ) {
        if( $c->authenticate( { username => $username,
                                password => $password  } ) ) {
            #  successful
            $c->response->redirect( $c->uri_for( '/home' ) );
            return;
        } 
        else {
            # Set an error message
            $c->stash( error_msg => "Bad username or password." );
        }
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
