use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst;

use Catalyst::Test 'ReviewSite';
use ReviewSite::Controller::Login;
use ok 'Test::WWW::Mechanize::Catalyst' => 'ReviewSite';
ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );
$mech->get_ok( 'http://localhost:3000/login','test URL');
$mech->title_is( "LOGIN" );
$mech->field( 'username','jew' );
$mech->field( 'password','jewabc' );
$mech->submit_from_ok();
ok( request('/login')->is_success, 'Request should succeed' );

done_testing();
