package TestApp;

use strict;
use warnings;

use Catalyst qw/
    Authentication
    Session
    Session::Store::File
    Session::State::Cookie
/;


__PACKAGE__->config(
    "Plugin::Authentication" => {
        default_realm => "facebook",
        realms => {
         facebook => {
             credential => {
                 class       => 'FBConnect',
                 api_key     => 'test-api-key',
                 secret      => 'test-secret-key',
                 app_name    => 'TestApp', 
             }
        }
      }
    },
);

TestApp->setup;

1;
