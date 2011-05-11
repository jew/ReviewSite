use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst;
use ok 'Test::WWW::Mechanize::Catalyst' => 'ReviewSite';
ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );
#test for fail login
$mech->get_ok( 'http://localhost:3000/login','test URL' );
$mech->title_is( "Login" ,'TITLE' );
$mech->field( 'username','jew1' );
$mech->field( 'password','jewabc1' );
$mech->field( 'submit','1' );
$mech->submit_form_ok();
$mech->content_contains( 'Bad username or password' ) or diag($mech->content);
#test for successfully login 
$mech->get_ok( 'http://localhost:3000/login','test URL' );
$mech->field( 'username','jew' );
$mech->field( 'password','jewabc' );
$mech->submit_form_ok();
$mech->title_unlike( qr/Login/ , 'Title Unlike' );
$mech->title_is( "Home" );
done_testing();
