use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst;
use ok 'Test::WWW::Mechanize::Catalyst' => 'ReviewSite';
ok( my $mech = Test::WWW::Mechanize::Catalyst-> new );
#test for register 
$mech->get_ok( 'http://localhost:3000/user/register' );
#$mech->title_is( "Register" );
$mech->field( 'username' , 'lalit' );
$mech->field( 'password', '1234' );
$mech->field( 'firstname','lalit' );
$mech->field( 'lastname','Chanprasert' );
$mech->field( 'email','lalit@hotmail.com' );
$mech->submit_form_ok();


done_testing();
