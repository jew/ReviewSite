package ReviewSite::Controller::Email;
use Moose;
use namespace::autoclean;
use Catalyst::Plugin::Email;
use Email::Send;
use Email::MIME;
use Email::MIME::Creator;
use Carp qw/croak/;
use Catalyst 'Email';

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }


=head1 NAME

ReviewSite::Controller::Email - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.
=cut

=head2 invite
=cut 

sub invite :Local  :FormConfig {
    my ( $self, $c ) = @_;  
    my $form         = $c->stash->{ form };
    $c->stash( title => 'Invite Friend' );
    if ( $form->submitted_and_valid ) {
        my $friend_email   = $form->param_value( 'email' );
    	my $body           = $form->param_value( 'detail' );
	    $c->stash->{email} = {
	        to             =>  $friend_email,
	        from           => 'no-reply@foobar.com',
	        subject        => 'Invite You Join ReviewSite',
	        template       => 'sendMail.tt',
	        content_type   => 'multipart/alternative',
	        body           => $body ,
        };        
    $c->forward( $c->view( 'Email::Template' ) );
    if ( scalar( !@{ $c->error } ) ) {
	        $c->response->body( 'Email sent A-OK!' );
	   }
    }
}


__PACKAGE__->meta->make_immutable;
1;