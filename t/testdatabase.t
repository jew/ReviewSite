
use strict;
use warnings;
use Test::More;
use FindBin qw($Bin);
use lib "$Bin/lib";

use vars qw($schema);
use Test qw($schema);

Test::create_users(); #Creating user.

{ #Check for ReviewSite::Schema
 ok $schema;
 isa_ok $schema, 'ReviewSite::Schema', '$schema';
}

{ #Test for the created user.
   my $user = $schema->resultset('User')->search({})->first;
   ok $user;
   is( $user->username, 'A', 'Correct username' );
   is( $user->password, 'B', 'Correct password' );
   #is( $user->firstname, 'C','Correct firstname' );
   is( $user->lastname, 'D', 'Correct lastname' );
   is( $user->email,    'E@hotmail.com', 'Correct Email' );
}

{#Test creating 
    my $row = $schema->resultset( 'User' )->create( { username => 'foo' } );
    ok $row, 'got a row';
    is $row->username, 'foo', 'foo username';
}

{#Test Deleting 
	my $delete = $schema->resultset('User')->find( 2 ) -> delete;
	ok $delete , 'deleted  row';
}

done_testing();
