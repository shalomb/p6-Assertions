#!/usr/bin/env perl6

use v6;
use lib 'lib';

use Test;

use Assertions;

my @tests = (
{
dies-ok  { assert { die 2 }, "Bang bang, my baby shot me down .." },
         'assert die block and use failure message'
},
{
lives-ok { assert { die 2 }, "Hey, I live again", :non-fatal },
         'assert die block and use failure message (non-fatal)'
},
{
dies-ok  { assert { die 2 }, { note "Hey, I live again" } },
         'assert block and use failure block'
},
{
my $foo = '42';
lives-ok { assert { die $foo }, { note "Hey, $foo lives again" }, :non-fatal },
         'assert block and use failure block (non-fatal)'
},
);

plan @tests.elems;

&$_() for @tests;
