#!/usr/bin/env perl6

use v6;
use lib 'lib';

use Test;

use Assertions;

my @tests = (
{ ok { assert !!1 }, 'assert Bool' },
{ ok { assert 1   }, 'assert Int'  },
{
ok { assert !!1, 'Expression !!1 is not truthy?' },
    'assert Bool with failure message'
},
{
ok { assert 1,   'Expression 1 is not truthy?' },
    'assert Int with failure message'
},
{
ok { assert True, 'Expression True is not truthy?' },
    'assert Bool with failure message'
},
{
ok { assert False, 'Expression False is not truthy?' },
    'assert Bool with failure message'
},
{
my $bar = 1;
ok { assert !!$bar, '$bar does not evaluate to Bool' },
    'assert variable value is truthy';
},
{
my $bar = Nil;
dies-ok { assert !!$bar, { die "noting that \$bar holds no good" } },
        'assert variable value is falsy and dies in a block';

},
{
my $bar = Nil;
lives-ok { assert !!$bar, { note "noting that \$bar holds no good" } },
        'assert variable value is falsy and dies in a block';

},
{
my $bar = Any;
dies-ok { assert !!$bar, { die "noting that \$bar holds no good" }, :non-fatal },
        'assert variable value is falsy and dies in a block despite :non-fatal';
},
{
my $bar = Mu;
dies-ok { assert !!$bar, '$bar is not set' },
        'assert variable value is falsy and dies with a message';
},
{
my $bar = Cool;
lives-ok { assert !!$bar, '$bar is not set', :non-fatal },
        'assert variable value is falsy and does not die but instead notes() a message';
},
{
dies-ok { assert 1==0 },
        'assert simple expression dies';
},
{
lives-ok { assert 1==0, :non-fatal },
        'assert simple expression marked non-fatal does not die';
},
{
dies-ok {
  my $foo = 42;
  assert
    0 < $foo < 2,
    "Value of $foo (0 < $foo < 2) is incorrect"
  }, 'assert simple condition for truth and die with message';
},
{
lives-ok {
  my $foo = 42;
  assert 0 < $foo < 2,
    "Value of $foo (0 < $foo < 2) is incorrect",
    :non-fatal
  }, 'assert simple condition for truth and do not die with message (non-fatal)';
},
{
ok { assert False, 'False', :non-fatal },
   'assert simple non-fatal expression';
},
{
dies-ok {
    my $foo = 42;
    assert 0 < $foo < 2, "Value of $foo (0 < $foo < 2) is incorrect"
  }, 'assert simple condition for truth and die with message';
},
);

plan @tests.elems;

&$_() for @tests;

