package ReviewSite::Schema::Result::Review;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

ReviewSite::Schema::Result::Place

=cut

__PACKAGE__->table("reviews");

=head1 ACCESSORS

=head2 review_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_nullable: 1

=head2 place_id

  data_type: 'varchar'
  is_nullable: 1

=head2 detail

  data_type: 'varchar'
  is_nullable: 1

=head2 rate

  data_type: 'varchar'
  is_nullable: 1
=cut

__PACKAGE__->add_columns(
  "review_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_nullable => 1 },
  "place_id",
  { data_type => "integer", is_nullable => 1 },
  "detail",
  { data_type => "varchar", is_nullable => 1 },
  "rate",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("review_id");
#set relationship later
__PACKAGE__-> belongs_to( "user","ReviewSite::Schema::Result::User",
{ user_id => "user_id"},);
__PACKAGE__-> belongs_to( "place","ReviewSite::Schema::Result::Place",
{ place_id => "place_id"},);

# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-05-09 15:08:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:L3Wzq6T/3kXD155GIyJS+g


=head2

#my $countR =  $c->model( 'DB::Review' )->search_rs( { place_id => 5},{ count => 'review_id'} ); 
sub count {
    my ( $self ) = @_;
    return 0 if $self->review->count() == 0;
    return $self->review->count();
}
=cut
# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
