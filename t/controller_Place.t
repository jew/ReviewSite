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

#test sub show 
$mech -> get_ok( "http://localhost:3000/place/show?type_id=1" );
$mech->title_is( "All Places" );
$mech->content_contains( "Rate" );

#test sub show 
$mech -> get_ok( "http://localhost:3000/place/5/review" );
$mech->title_is( "Reviews" );
$mech->content_contains( "Rate" );

done_testing();
