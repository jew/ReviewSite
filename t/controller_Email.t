use strict;
use warnings;
use Test::More;
use Email::Send;
use Email::Send::Test;
use Test::WWW::Mechanize::Catalyst;
use ok 'Test::WWW::Mechanize::Catalyst' => 'ReviewSite';
ok( my $mech = Test::WWW::Mechanize::Catalyst-> new );

#test for login
$mech->get_ok( 'http://localhost:3000/login' );
$mech->field( 'username', 'jew' );
$mech->field( 'password', '123' );
$mech->submit_form_ok() ;

#test sending email
$mech->get_ok( 'http://localhost:3000/email/invite' );
$mech->title_is( 'Invite Friend' );
$mech->field( 'email', 'a-lohana@hotmail.com' );
$mech->field( 'detail', 'test' );
$mech->submit_form_ok();

# Clear 
ok( Email::Send::Test->clear, '->clear returns true' );
my $mailer = Email::Send->new();
my $message ='Test';
my $sender = Email::Send->new( { mailer => 'Test' } );
$sender->send( $message );
my @emails = Email::Send::Test->emails;
is( scalar( @emails ), 1, 'Sent 1 email' );
is(@emails, 1, "got emails");
isa_ok( $emails[0], 'Email::Simple', 'email is ok' );


#test fail
# mailer module that won't load
my $rv = $sender->mailer_available( "Test::Email::Send::Won't::Exist" );
ok( !$rv, "failed to load mailer (doesn't exist)" ),
like( "$rv", qr/can't locate/i, "and got correct exception" );
 
done_testing();
