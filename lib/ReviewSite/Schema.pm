package ReviewSite::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use namespace::autoclean;
extends 'DBIx::Class::Schema';
=head1 NAME

ReviewSite::Schema;


=head1 DESCRIPTION

Catalyst Schema.

=head1 METHODS

=cut

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-05-09 15:08:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JeApsu7Y6/qkpHnS/LYWOg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
