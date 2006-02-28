use strict;
use Test::More 'no_plan';
use HTML::ResolveLink;

my $base = "http://www.example.com/base/";

my $resolver = HTML::ResolveLink->new(base => $base);
my $html = $resolver->resolve(<<'HTML');
<a href="/foo">foo</a><img src="/bar.gif" alt="foo &amp; bar" /> foobar
<a href="mailto:foobar@example.com">hey &amp;</a>
<a href="foo.html" onclick="foobar()">bar</a><br />
<a href="http://www.example.net/">bar</a>
<!-- hello -->
HTML
    ;

is $html, <<'HTML';
<a href="http://www.example.com/foo">foo</a><img src="http://www.example.com/bar.gif" alt="foo &amp; bar" /> foobar
<a href="mailto:foobar@example.com">hey &amp;</a>
<a href="http://www.example.com/base/foo.html" onclick="foobar()">bar</a><br />
<a href="http://www.example.net/">bar</a>
<!-- hello -->
HTML
    ;
