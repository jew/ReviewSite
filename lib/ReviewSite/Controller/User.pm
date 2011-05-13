package ReviewSite::Controller::User;
use Moose;
use namespace::autoclean;
BEGIN {extends 'Catalyst::Controller::HTML::FormFu'; }
use HTML::FormFu::Constraint::Email;
use HTML::FormFu::Constraint::Equal;


=head1 NAME

ReviewSite::Controller::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 register
Register
=cut

sub register :Local FormConfig {
	my ( $self,$c ) = @_;
	my $form = $c->stash->{ form };
	#get values 
	my $username  = $form->param_value( 'username' );
	my $password  = $form->param_value( 'password' );
	my $firstname = $form->param_value( 'firstname' );
	my $lastname  = $form->param_value( 'lastname' );
	my $email     = $form->param_value( 'email' );
	
    $c->stash( title => "Register" );
    my $result;
    if ( $form->submitted_and_valid ) {
    	$c->log->debug("VALID");
        $result = $c->model( 'DB::User' )->create ( {
            username  => $username,
            password  => $password,
            firstname => $firstname,
            lastname  => $lastname,
            email     => $email
    	} );
        $c->stash( status_msg => "complete!" );
	} else {
		$c->log->debug(join ("\n", @{ $form->get_errors}));
	}
	
}


=head2 check
 Check available name for user
=cut

sub check :Local {  
	my ( $self, $c ) = @_;
	my $result   = $c->model('DB::User')->find( {username => $c->request->param( 'username' )} );
	if ( $result ) { #Return 0 if not available
		$c->res->body(0);
	} else {
		$c->res->body(1);
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
