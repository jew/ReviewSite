use strict;
use warnings;
use Test::More;
#use Email::Send::Test;
use Email::Sender::Simple;
use Test::WWW::Mechanize::Catalyst;
use ok 'Test::WWW::Mechanize::Catalyst' => 'ReviewSite';

BEGIN { $ENV{EMAIL_SENDER_TRANSPORT} = 'Test' }
#BEGIN { $ENV{'REVIEWSITE_CONFIG_LOCAL_SUFFIX'} = 'test'; }
ok( my $mech = Test::WWW::Mechanize::Catalyst->new() );

#test for login
$mech->get_ok( 'http://localhost:3000/login' );
$mech->field( 'username', 'jew' );
$mech->field( 'password', '123' );
$mech->submit_form_ok() ;

#test sending email
$mech->get_ok( 'http://localhost:3000/email/invite' );
$mech->title_is( 'Invite Friend' );
$mech->field( 'email', 'a-lohana@hotmail.com' );
$mech->field( 'detail', 'hello hello' );
$mech->submit_form_ok();

my @emails = Email::Sender::Simple->default_transport->deliveries;
is( scalar(@emails), 1, 'Sent 1 email' );
like( $emails[0]->{email}->[0]->{body_raw}, qr/hello hello/, "Got email body" ); 
like( $emails[0]->{email}->[0]->{header}->{headers}->[1], qr/a-lohana\@hotmail.com/,"Check for sender" ); 
like( $emails[0]->{email}->[0]->{header}->{headers}->[5], qr/Invite You Join ReviewSite/,"Check for subject" ); 
#use Data::Dumper;
#diag("--------->". Dumper($emails[0]->{email}->[0]->{header}->{headers}));

done_testing();
