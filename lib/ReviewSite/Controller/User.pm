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


=head2 index

=cut

sub index :Path :Args(0)  {
    my ( $self, $c ) = @_;

}

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
        $result = $c->model( 'DB::User' )->create ( {
            username  => $username,
            password  => $password,
            firstname => $firstname,
            lastname  => $lastname,
            email     => $email
    	} );
    	
    	if ( $result->username eq $username ) {
    		$c->stash( status_msg => "complete!" );
    	} else {
    		$c->stash( error_msg => "uncomplete!" );
    		
    	}

	}
	
}


=head checkuser
Check available name for user
=cut
sub checkAvaliable :Local {
	my ( $self,$c ) = @_;
	my $username = $c->request->param( 'username' );
	my $result   = $c->model('DB::User')->search( {username => $username} );
	if($result->first()->username() eq $username){  
        $c->response->body( 0 ); 
        return  0;  
    }else{  
        #//else if it's not bigger then 0, then it's available '  
        $c->response->body( 1 );
        return 1;  
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
