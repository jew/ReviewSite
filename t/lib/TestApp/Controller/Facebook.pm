package TestApp::Controller::Facebook;

use strict;
use warnings;

use parent 'ReviewSite::Controller::facebook';

=head2
=cut

sub index : Path( '/login/facebook' ) {
    my ( $self, $c ) = @_;
    my $realm = $c->get_auth_realm( 'facebook' );
    $c->res->body( $realm->name );
}


1;
