use strict;
use warnings;
use Test::More;
use Catalyst::Test 'ReviewSite';
use Test::WWW::Mechanize::Catalyst;

use lib 't/lib';

BEGIN { *CORE::GLOBAL::system = sub { 0 }; }
use_ok( 'WWW::Facebook::API' );
use_ok( "WWW::Facebook::API::Auth" );
use Test::MockObject::Extends;
   
#Test API
my $api = Test::MockObject::Extends->new(
    WWW::Facebook::API->new(
        api_key        => 1,
        secret         => 1,
        parse_response => 1,
        desktop        => 1,
    ),
);


{
    local $/ = "";
    $api->set_series( '_post_request', <DATA> );
}
my $auth = WWW::Facebook::API::Auth->new( base => $api );
my $token = $auth->create_token;
is $token, '84fe59f9c895e5f111ae675f9ee57bf8', 'token correct';
$auth->get_session( $token );
is $api->session_key, '6669e83a601ded0f8a3a0eee6b267aafbadee98e', 'session key correct';
is $api->session_uid, '538651837', 'uid correct';
is $api->session_expires, '1173309298',        'expires correct';
is $api->secret,          '16e3023bcfd9f61ae008ec16e6629056', 'secret correct';
eval { $auth->get_session; };
ok $@, 'token needed';
ok $auth->can( 'logout' ), 'logout works';


for my $plugin ( qw/ 
    Authentication
    Session
    Session::Store::File
    Session::State::Cookie
    / ) {
    my $module = "Catalyst::Plugin::$plugin";
    eval "use $module; 1" or plan skip_all => "test requires $module";
}      
my $mech = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'TestApp');
$mech->get_ok( '/login/facebook' );
$mech->content_contains( 'facebook' );

done_testing();


=head2 structure of __DATA__
auth_token
{"session_key":"6669e83a601ded0f8a3a0eee6b267aafbadee98e","uid":"538651837","expires":1173309298,"secret":"16e3023bcfd9f61ae008ec16e6629056"}
auth_token
=cut


__DATA__
"84fe59f9c895e5f111ae675f9ee57bf8"

{"session_key":"6669e83a601ded0f8a3a0eee6b267aafbadee98e","uid":"538651837","expires":1173309298,"secret":"16e3023bcfd9f61ae008ec16e6629056"}

"84fe59f9c895e5f111ae675f9ee57bf8"

