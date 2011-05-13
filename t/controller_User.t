use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst;
use ok 'Test::WWW::Mechanize::Catalyst' => 'ReviewSite';
ok( my $mech = Test::WWW::Mechanize::Catalyst-> new );

#test for register 
$mech->get_ok( 'http://localhost:3000/user/register' );
$mech->title_is( "Register" );
$mech->field( 'username' , 'lalit' );
$mech->field( 'password', '1234' );
$mech->field( 'repeat_pass','1234' );
$mech->field( 'firstname','lalit' );
$mech->field( 'lastname','Chanprasert' );
$mech->field( 'email','lalit@hotmail.com' );
$mech->field( 'repeat_email','lalit@hotmail.com' );
$mech->submit_form_ok();
$mech->content_contains( "complete!" );
#test for register fail
$mech->get_ok( 'http://localhost:3000/user/register' );
$mech->title_is( "Register" );
$mech->field( 'password', '1234' );
$mech->field( 'repeat_pass','12345' );
$mech->submit_form_ok();
$mech->content_contains( "Does not match" );
#login by lalit miss match password
$mech->get_ok( 'http://localhost:3000/login' );
$mech->title_is( "Login" );
$mech->field( 'username' , 'lalit' );
$mech->field( 'password', '1234' );
$mech->submit_form_ok();
$mech->title_unlike( qr/Login/ , 'Title Unlike' );
$mech->title_is( "Home" );

#test for user availability
#Not Available
$mech->get_ok( 'http://localhost:3000/user/check/?username=jew' );
$mech->content_contains( '0' ,'Not Available username');

#Available
$mech->get_ok( 'http://localhost:3000/user/check/?username=mm' );
$mech->content_contains( '1','Available username' );
diag($mech->content);

done_testing();
