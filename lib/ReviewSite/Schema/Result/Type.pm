package ReviewSite::Schema::Result::Type;

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

ReviewSite::Schema::Result::User

=cut

__PACKAGE__->table("types");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 place

  data_type: 'varchar'
  is_nullable: 1
=cut

__PACKAGE__->add_columns(
  "type_id",
  { data_type => "integer", is_nullable => 0 },
  "placename",
  { data_type => "varchar", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("type_id");
#set relationship later
__PACKAGE__-> has_many( "place" => 'ReviewSite::Schema::Result::Place',
{"foreign.type_id"=>"self.type_id"},
);
# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-05-09 15:08:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:L3Wzq6T/3kXD155GIyJS+g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
