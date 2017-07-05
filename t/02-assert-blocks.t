#!/usr/bin/env perl6

use v6;
use lib 'lib';

use Test;

use Assertions;

my @tests = (
{
ok { assert { 1 } },
    'assert simple Int expression in block for truth';
},
{
ok { assert { True } },
    'assert simple Bool expression in block for truth';
},
{
dies-ok { assert { False } },
    'assert simple Bool expression in block for truth and die';
},
{
ok { assert { 0 === 0 } },
   'assert block expression for truth';
},
{
ok { assert { 0..9 ~~ Range } },
   'assert block expression for truth';
},
{
dies-ok { assert { 0==1 } },
        'assert simple expression and die with default message';
},
{
lives-ok { assert { 1==0 }, :non-fatal },
        'assert simple expression marked non-fatal does not die';
},
{
lives-ok
  { assert 1==0, '1!=0', :non-fatal },
  'assert simple expression with failure message marked non-fatal does not die';
},
{
dies-ok { assert { 1==0 }, { die "noting that 1!=0"; } },
        'assert block expression and die in a failure block';
},
{
dies-ok {
  my $foo = 42;
  assert
    { 0 < $foo < 2 },
    { die "Value of $foo (0 < $foo < 2) is incorrect" }
  }, 'assert simple condition in block and die from within a failure block';
},
{
lives-ok {
  my $foo = 42;
  assert
    { 0 < $foo < 2 },
    { note "# Value of $foo (0 < $foo < 2) is incorrect" }
  }, 'assert simple condition in block and note from within a failure block';
},
{
lives-ok {
  my $foo = 42;
  assert
    { 0 < $foo < 2 },
    { say "# Value of $foo (0 < $foo < 2) is incorrect" }
  }, 'assert simple condition in block and say from within a failure block';
},
{
dies-ok {
  my $foo = 42;
  assert
    { 0 < $foo < 2 },
    "# Value of $foo (0 < $foo < 2) is incorrect"
  }, 'assert simple condition in block and use failure message'
},
{
lives-ok {
    assert { die 2 }, "hmm, what could this be?", :non-fatal
  }, 'assert simple condition in block and use failure message (non-fatal)'
},
{
lives-ok {
  assert { die 2 }, { 2 }, :non-fatal
  }, 'assert simple condition in block and use failure block (non-fatal)'
},
{
lives-ok {
  my $foo = 42;
  my $ret = assert { 0 < $foo < 2 }, { True };
  $ret === True;
  }, 'assert simple condition in block, use failure block and test retval is True'
},
{
lives-ok {
  my $foo = 42;
  my $ret = assert { 0 < $foo < 2 }, { False };
  $ret === False;
  }, 'assert simple condition in block, use failure block and test retval is False'
},
);

plan @tests.elems;

&$_() for @tests;

