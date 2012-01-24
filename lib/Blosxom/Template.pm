package Blosxom::Template;
use strict;
use warnings;

our $VERSION = '0.01002';

sub new {
    my $class = shift;
    my $templates = shift;

    return bless { templates => $templates }, $class;
}

sub get {
    my $self = shift;
    my ($chunk, $flavour) = _split(shift);
    my $templates = $self->{templates};

    my $value;
    if (exists $templates->{$flavour}{$chunk}) {
        $value = $templates->{$flavour}{$chunk};
    }

    return $value;
}

sub set {
    my $self = shift;
    my ($chunk, $flavour) = _split(shift);
    my $value = shift;

    if ($chunk and $flavour) {
        $self->{templates}{$flavour}{$chunk} = $value;
    }

    return;
}

sub remove {
    my $self = shift;
    my ($chunk, $flavour) = _split(shift);

    if ($chunk and $flavour) {
        delete $self->{templates}{$flavour}{$chunk};
    }

    return;
}

sub exists {
    my $self = shift;
    my ($chunk, $flavour) = _split(shift);

    my $exists;
    if ($chunk and $flavour) {
        $exists = exists $self->{templates}{$flavour}{$chunk};
    }

    return $exists;
}

sub _split { (shift =~ /(.*)\.([^.]*)/) }

1;

__END__

=head1 NAME

Blosxom::Template - Intuitive interface of %blosxom::template

=head1 SYNOPSIS

  use Blosxom::Template;

  my %templates = ( html => { foo => 'bar' } );

  my $t = Blosxom::Template->new(\%templates);
  my $value = $t->get('foo.html');
  my $bool = $t->exists('foo.html');

  $t->set('foo.html' => 'baz'); # overwrites existent template
  $t->remove('foo.html');

  $t->{templates}; # same reference as \%templates

=head1 DESCRIPTION

Blosxom, a weblog application, exports %template which holds default
values of templates. The data structure of this hash is as follows:

  %blosxom::template = (
      'html' => {
          'foo' => 'bar',
      },
  );

When you get a value of this, you must write as follows:

  my $value = $blosxom::template{html}{foo};

It doesn't seem intuitive.

If you used this module, you might write as follows:

  my $t = Blosxom::Template->new(\%blosxom::template);
  my $value = $t->get('foo.html');

=head2 METHODS

=over 4

=item $t = Blosxom::Template->new(\%templates)

Creates a new Blosxom::Template object.
This object holds a reference to the original given \%templates argument.

=item $t->get('foo.html')

Returns a value of the specified template.

=item $t->exists('foo.html')

Returns a Boolean value telling whether the specified template exists.

=item $t->set('foo.html' => 'baz')

Sets a value of the specified template.

=item $h->remove('foo.html')

Deletes the specified element from templates.

=back

=head1 EXAMPLES

=head1 DEPENDENCIES

L<Blosxom 2.1.2|http://blosxom.sourceforge.net/>

=head1 SEE ALSO

L<Blosxom::Header>

=head1 AUTHOR

Ryo Anazawa (anazawa@cpan.org)

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2011 Ryo Anazawa. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

