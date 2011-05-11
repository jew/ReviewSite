use strict;
use warnings;
use Test::More;
use Test::WWW::Mechanize::Catalyst;
use ok 'Test::WWW::Mechanize::Catalyst' => 'ReviewSite';
ok( my $mech = Test::WWW::Mechanize::Catalyst->new, 'Created mech object' );

#Test for successfully logout
$mech->get_ok( 'http://localhost:3000/logout');
$mech->title_is( "Home" );
$mech->content_contains( 'Sign in' );
done_testing();
