use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst;
use ok 'Test::WWW::Mechanize::Catalyst' => 'ReviewSite';
ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );
#test for fail login
$mech->get_ok( 'http://localhost:3000/login','test URL');
$mech->title_is( "LOGIN" );
$mech->field( 'username','jew1' );
$mech->field( 'password','jewabc1' );
$mech->submit_from_ok();
$mech->content_contains( 'Invalid username or password' );
#test for successfully login 
$mech->get_ok( 'http://localhost:3000/login','test URL' );
$mech->title_is( "LOGIN" );
$mech->field( 'username','jew' );
$mech->field( 'password','jewabc' );
$mech->submit_from_ok();
$mech->content_contains( 'Welcome Nudjaree' );
done_testing();
