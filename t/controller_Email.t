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
=head
#test sending email
$mech->get_ok( 'http://localhost:3000/email/invite' );
$mech->title_is( 'Invite Friend' );
$mech->field( 'email', 'a-lohana@hotmail.com' );
$mech->field( 'detail', 'test' );
$mech->submit_form_ok();
=cut
my $sender = Email::Send->new( { mailer => 'Test' } );
$sender->send( 'hello hello ' );
# Clear first, just in case
ok( Email::Send::Test->clear, '->clear returns true' );
my $mailer = Email::Send->new( { mailer => 'Test' } );
isa_ok( $mailer, 'Email::Send' );
#test send
ok( $mailer->send( 'test' ), '->send returns true' );
is( scalar( Email::Send::Test->emails ), 1, 'Sending an email results in something in the trap' );
#check body 
ok( Email::Send::Test->send( 'Hello Hello' ), 'Sending Hello' );
is( ( Email::Send::Test->emails )[1], 'Hello Hello', 'Check Hello' );
ok( Email::Send::Test->clear, '->clear returns true' );
is( scalar( Email::Send::Test->emails ), 0, '->clear clears the trap' );

#test fail
#mailer module that won't load
my $rv = $sender->mailer_available( "Test::Email::Send::Won't::Exist" );
ok( !$rv, "failed to load mailer (doesn't exist)" ),
like( "$rv", qr/can't locate/i, "and got correct exception" );
 
done_testing();
