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

#test sub showReview 
$mech -> get_ok( "http://localhost:3000/review/show?user_id=1" );
$mech->title_is( "Your Reviews" );
$mech->content_contains( "BB" );

#test insert review for delete 
$mech->get_ok( 'http://localhost:3000/reviewSite/5/writeReview' );
$mech->title_is( "Write a review" );
$mech->field( 'place_id','5' );
$mech->field( 'detail','Nice place ,Good service' );
$mech->field( 'rating','1' );
$mech->field( 'user_id','1' );
$mech->submit_form_ok();
$mech->content_contains( "complete!" );
=head
#test sub delete 
$mech -> get_ok( "http://localhost:3000/review/71/delete" );
$mech->title_is( "Delete review" );
$mech->content_like( qr/Confirm to delete review./ );
$mech->submit_form_ok();
$mech->title_is( "Your Reviews","check redirect" );
=cut
done_testing();

