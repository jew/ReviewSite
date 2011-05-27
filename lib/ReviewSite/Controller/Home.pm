package ReviewSite::Controller::Home;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

ReviewSite::Controller::Home - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash( title => 'Home' );
    my $hotels      = $c->model( 'DB::Place' )->search_rs( { type_id => '1' } )->top3();
    my $nightlifes  = $c->model( 'DB::Place' )->search_rs( { type_id => '2' } )->top3();
    my $shoppings   = $c->model( 'DB::Place' )->search_rs( { type_id => '3' } )->top3();
    my $restaurants = $c->model( 'DB::Place' )->search_rs( { type_id => '4' } )->top3();
    $c->stash( hotels      => $hotels );
    $c->stash( nightlifes  => $nightlifes );
    $c->stash( shoppings   => $shoppings );
    $c->stash( restaurants => $restaurants );
}



=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
