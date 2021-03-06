package ReviewSite;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    ConfigLoader
    StackTrace
    Static::Simple
    Authentication
    Session
    Session::Store::File
    Session::State::Cookie
    Email
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in reviewsite.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.


 __PACKAGE__->config( 'Plugin::Authentication' => {
     default_realm => 'facebook',
     realms => {
         facebook => {
             credential => {
                 class       => 'FBConnect',
                 api_key     => 'b86b0de92ce880bd9c3c51d0798122f4',
                 secret      => '16e3023bcfd9f61ae008ec16e6629056',
                 app_name    => 'ReviewSite', 
             }
         },
         dbic => {
             credential => {
                 class       => 'Password', 
                 password_type => 'none',
             },
             store => {
                 class       => 'DBIx::Class',
                 user_class  => 'DB::User',
                 id_field    => 'user_id'
             }
         },
                    default=> {  class           => 'SimpleDB',
                        user_model      => 'DB::User',
                        password_type   => 'clear', 
                      },
     }
 } );


=head2 fb_user_update
 Check for current facebook user, update if needed.
=cut

sub fb_user_update {
    my ( $c, $user ) = @_;
    my $cre  = $c->config->{ 'Plugin::Authentication' }
                             ->{ realms }->{ facebook }->{ credential };
    my $fb   = WWW::Facebook::API->new( desktop => 0,
                                        api_key => $cre->{ api_key },
                                        secret  => $cre->{ secret },
                                       );
    my $resp   =   $fb->users->get_info(
        uids   =>  $c->user->session_uid,
        fields =>  [ qw/first_name email last_name/ ]
        );
	my $user_Fb = $user->update_or_create( {
	    credential_identifier   => $c->user->session_uid,
        credential_source       => 'facebook',
        email                   => $resp->[0]->{ email },
        firstname               => $resp->[0]->{ first_name },
        lastname                => $resp->[0]->{ last_name }
        } ,
	    { email => $resp->[0]->{ email } }
    );

    $c->user->{ user_id }   =  $user_Fb->user_id;
}
=head2

__PACKAGE__->config(
    name => 'ReviewSite',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    
    'Plugin::Authentication' => {
           default=> {  class           => 'SimpleDB',
                        user_model      => 'DB::User',
                        password_type   => 'clear', 
                      },
     },
     
    'stacktrace' => {verbose => 1, },

    'Controller::HTML::FormFu' => {
        model_stash => { schema => 'DB'},
    },
    
    'View::Email::Template' => {
    # Where to look in the stash for the email information.
    # 'email' is the default, so you don't have to specify it.
    stash_key => 'email',
    # Define the defaults for the mail
    default => {
        # Defines the default content type (mime type). Mandatory
        content_type => 'text/html',
        # Defines the default charset for every MIME part with the 
        # content type text.
        # According to RFC2049 a MIME part without a charset should
        # be treated as US-ASCII by the mail client.
        # If the charset is not set it won't be set for all MIME parts
        # without an overridden one.
        # Default: none
    charset => 'utf-8'
    },
    # Setup how to send the email
    # all those options are passed directly to Email::Sender::Simple
    sender => {
        # if mailer doesn't start with Email::Sender::Simple::Transport::,
        # then this is prepended.
        mailer => 'SMTP',
        # mailer_args is passed directly into Email::Sender::Simple 
            mailer_args => {
                Host     => 'localhost', # defaults to localhost
            }
        }
    } 
);

=cut


# Start the application
__PACKAGE__->setup();


=head1 NAME

ReviewSite - Catalyst based application

=head1 SYNOPSIS

    script/reviewsite_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<ReviewSite::Controller::Root>, L<Catalyst>

=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
