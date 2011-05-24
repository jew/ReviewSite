use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst;
use ok 'Test::WWW::Mechanize::Catalyst' => 'ReviewSite';
ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );
$mech->get_ok( 'http://localhost:3000/home');
$mech->title_is( "Home" );

done_testing();
