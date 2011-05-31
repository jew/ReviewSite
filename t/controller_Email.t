use strict;
use warnings;
use Test::More;
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
$mech->title_is('Invite Friend');
$mech->field( 'email', 'a-lohana@hotmail.com' );
$mech->field( 'detail', 'Hello Hello' );
$mech->submit_form_ok() ;
$mech->content_contains( "Email sent A-OK! (At least as far as we can tell" );
done_testing();
