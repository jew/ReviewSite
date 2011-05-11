package ReviewSite::Controller::Login;
use Moose;
use namespace::autoclean;
BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

ReviewSite::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index
  use for Login 
=cut

sub index :Path :Args(0) FormConfig {
    my ( $self, $c ) = @_;
    # Get the username and password from form
    my $form = $c->stash->{form};
    $c->stash( title => 'Login' );
    if( $form->submitted_and_valid ) {
        my $username = $form->param_value( 'username' );
        my $password = $form->param_value( 'password' );
    	$c->log->debug( "username" . $username );
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
        else {
            # Set an error message
            $c->stash( error_msg => "Bad username or password." );
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
