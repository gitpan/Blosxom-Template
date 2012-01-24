use strict;
use Test::More;
use Blosxom::Template;

{
    my %templates = ();
    my $t = Blosxom::Template->new(\%templates);

    isa_ok $t, 'Blosxom::Template';
    can_ok $t, qw(new get set remove exists);
    is_deeply $t, { templates => \%templates }
}

{
    my %templates = ( html => { foo => 'bar' } );
    my $t = Blosxom::Template->new(\%templates);
    $t->set('foo.html' => 'baz');
    is_deeply \%templates, { html => { foo => 'baz' } };
}

{
    my %templates = ( html => { foo => 'bar' } );
    my $t = Blosxom::Template->new(\%templates);
    $t->set('bar.html' => 'baz');
    is_deeply \%templates, { html => { foo => 'bar', bar => 'baz' } };
}

{
    my %templates = ( html => { foo => 'bar' } );
    my $t = Blosxom::Template->new(\%templates);
    is $t->get('foo.html'), 'bar';
}

{
    my %templates = ( html => { foo => 'bar', bar => 'baz' } );
    my $t = Blosxom::Template->new(\%templates);
    $t->remove('foo.html');
    is_deeply \%templates, { 'html' => { bar => 'baz' } };
}

{
    my %templates = ( html => { foo => 'bar' } );
    my $t = Blosxom::Template->new(\%templates);
    is $t->exists('foo.html'), 1;
}

done_testing;
