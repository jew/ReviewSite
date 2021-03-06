#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'ReviewSite';
all_from 'lib/ReviewSite.pm';

requires 'Catalyst::Runtime' => '5.80032';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
test_requires 'Test::More' => '0.88';
test_requires 'DBICx::TestDatabase';
test_requires 'Test::MockObject::Extends';
test_requires 'Email::Sender::Simple';
test_requires 'Test::WWW::Mechanize::Catalyst';
catalyst;
build_requires 'Catalyst::Devel';
requires 'FindBin';
requires 'HTML::FormFu::Constraint::Email';
requires 'HTML::FormFu::Constraint::Equal';
requires 'Email::MIME';
requires 'Carp';
requires 'Catalyst::Authentication::Store::DBIx::Class';
requires 'Catalyst::Plugin::StackTrace';
requires 'Catalyst::Model::DBIC::Schema';
requires 'Catalyst::View::Email::Template';
requires 'Catalyst::Plugin::Email';
requires 'WWW::Facebook::API';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::Store::File';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Controller::HTML::FormFu';
install_script glob('script/*.pl');
auto_install;
WriteAll;
