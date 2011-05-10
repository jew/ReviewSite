package ReviewSite::View::HTML;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    #Set the location for TT files
    INCLUDE_PATH => [
        ReviewSite->path_to( 'root', 'template' ),
    ],
   # WRAPPER => 'wrapper.tt',
);
=head1 NAME

ReviewSite::View::HTML - TT View for ReviewSite

=head1 DESCRIPTION

TT View for ReviewSite.

=head1 SEE ALSO

L<ReviewSite>

=head1 AUTHOR

jew,,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
