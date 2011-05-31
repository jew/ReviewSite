package ReviewSite::View::Email::Template;
use strict;
use base 'Catalyst::View::Email::Template';


__PACKAGE__->config (
    stash_key       => 'email',
    template_prefix => 'email',
    default_view    =>  'View::TT',
    
);


=head1 NAME

ReviewSite::View::Email::Template - Templated Email View for ReviewSite

=head1 DESCRIPTION

View for sending template-generated email from ReviewSite. 

=head1 AUTHOR

jew,,,,

=head1 SEE ALSO

L<ReviewSite>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
