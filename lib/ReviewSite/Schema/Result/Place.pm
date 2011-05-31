package ReviewSite::Schema::Result::Place;

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

__PACKAGE__->table("places");

=head1 ACCESSORS

=head2 place_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 placename

  data_type: 'varchar'
  is_nullable: 1

=head2 la

  data_type: 'varchar'
  is_nullable: 1

=head2 long

  data_type: 'varchar'
  is_nullable: 1

=head2 location

  data_type: 'varchar'
  is_nullable: 1'Place

=head2 type_id

  data_type: 'varchar'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(

  "place_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "placename",
  { data_type => "varchar", is_nullable => 1 },
  "la",
  { data_type => "double", is_nullable => 1 },
  "long",
  {  data_type => "double", is_nullable => 1 },
  "location",
  { data_type => "varchar", is_nullable => 1 },

   "type_id",
  { data_type => "integer", is_nullable => 0 },

);
__PACKAGE__->set_primary_key("place_id");
#set relationship later
__PACKAGE__-> belongs_to( "type","ReviewSite::Schema::Result::Type",
{ type_id => "type_id"},);
__PACKAGE__-> has_many( "review" => 'ReviewSite::Schema::Result::Review',
{"foreign.place_id"=>"self.place_id"},
);

=head2 rate
rate
=cut

sub rate {
	my ( $self ) = @_;
	return 0 if $self->review->count() == 0;
	return $self->review->get_column('rate')->sum()/$self->review->count();
}

=head2 count
count
=cut

sub count {
    my ( $self ) = @_;
    return 0 if $self->review->count() == 0;
    return $self->review->count();
}



# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-05-09 15:08:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:L3Wzq6T/3kXD155GIyJS+g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
