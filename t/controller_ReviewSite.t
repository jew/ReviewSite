use strict;
use warnings;
use Test::More;
use DBICx::TestDatabase;
use Test::WWW::Mechanize::Catalyst;

use ok 'Test::WWW::Mechanize::Catalyst' => 'ReviewSite';
ok ( my $mech = Test::WWW::Mechanize::Catalyst->new );
#test for login
$mech->get_ok( 'http://localhost:3000/login');
$mech->field('username', 'jew');
$mech->field('password', '123');
$mech->submit_form_ok() ;

#Test Sub search for the place that want to write review
#dont have this place 
$mech->get_ok( 'http://localhost:3000/reviewsite/searchBusiness' );
$mech->title_is( "Write a review" );
$mech->field( 'businesstype' , '1' );
$mech->field( 'name' , 'Sukumwit Suite ');
$mech->submit_form_ok();
$mech->content_contains("Dont have here !ADD");
#get the place that user want 
$mech->get_ok( 'http://localhost:3000/reviewsite/searchBusiness' );
$mech->title_is( "Write a review" );
$mech->field( 'businesstype' , '1' );
$mech->field( 'name' , 'BB ');
$mech->submit_form_ok();
$mech->content_contains("Write a review");
=head
#test database for searchBusiness
#my $schema = DBICx::TestDatabase->new( 'ReviewSite::Schema' );
#my $result = $schema->resultset('Place')->create( { placename  => 'Sukumwit',id     =>  '1' } );
---------------------------------------------
#diag( $result);
{ #Test for the created Place.
   my $user = $schema->resultset('Place')->search({})->first;
   ok $user;
   is( $user->placename, 'Sukumwit Hotel', 'Correct placename' );
}
=cut

#Test Sub add AddPlace
$mech->get_ok( 'http://localhost:3000/reviewsite/addPlace' );
$mech->title_is( "ADD NEW PALCE" );
$mech->field( 'types', '2' );
$mech->field( 'placename', 'CC' );
$mech->field( 'lat', '12.11' );
$mech->field( 'lng', '12.11' );
$mech->field( 'location', 'Bangkok' );
$mech->field( 'detail', 'From only $499 including setup!  The latest computerized LED uplighting.' );
$mech->field( 'rate', '3' );
$mech->submit_form_ok();
$mech->content_contains("complete!");

#Test Sub writeReview
$mech->get_ok( 'http://localhost:3000/reviewSite/5/writeReview' );
$mech->title_is( "Write a review" );
$mech->field( 'place_id','5' );
$mech->field( 'detail','Nice place ,Good service' );
$mech->field( 'rating','1');
$mech->field( 'user_id','1');
$mech->submit_form_ok();
#$mech->content_contains("complete! ");




done_testing();