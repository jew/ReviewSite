package Test;
use DBICx::TestDatabase;
use strict;
use vars qw($schema);
# Using Exporter to Share Global Variables $schema
BEGIN {
    use Exporter ();
    @Test::ISA         = qw(Exporter);
    @Test::EXPORT      = qw();
    @Test::EXPORT_OK   = qw($schema);
}

$schema = DBICx::TestDatabase->new( 'ReviewSite::Schema' );

sub create_users {
	$schema->resultset( 'User' )->create( { 
	    username  =>  'A',
	    password  =>  'B',
	    firstname =>  'C',
	    lastname  =>  'D',
	    email     =>  'E@hotmail.com'
	} );
}