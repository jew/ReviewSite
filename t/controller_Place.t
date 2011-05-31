use strict;
use warnings;
use Test::More;
use DBICx::TestDatabase;
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

#create database for test sub top3
my $schema = DBICx::TestDatabase->new( 'ReviewSite::Schema' );

my $pl = [{ place_id => '1' ,placename  => 'Sukumwit',type_id     => '1' },
    { place_id => '2' ,placename  => 'Asoke Hotel', type_id       => '1' },
    { place_id => '3' ,placename  => 'Novotel Hotel', type_id     => '1' },
    { place_id => '4' ,placename  => 'GB Hotel' , type_id         => '1' }, ];
                                                  
foreach my $p (@{$pl}) {                                                  
   my $places = $schema->resultset('Place')->create( $p );
}

my $rws = [{ review_id => '1' , rate =>'5', place_id => '1'},
    { review_id => '2' , rate => '2' ,      place_id => '2'},
    { review_id => '3' , rate => '3',       place_id => '3'},
    { review_id => '4' , rate => '1',       place_id => '4'}, ];
                                                  
foreach my $rw (@{$rws}) {
	 my $reviews = $schema->resultset('Review')->create( $rw );	
}                                                

#test sub top3 in Place resultset
my @tops = $schema->resultset('Place')->search_rs( { type_id => '1' } )->top3();
is( $tops[0]->placename, 'Sukumwit', '1 Sukumwit' );
is( $tops[1]->placename, 'Novotel Hotel', '2 Novotel Hotel' );
is( $tops[2]->placename, 'Asoke Hotel', '3 Asoke Hotel' );



done_testing();
