#!/usr/bin/env perl6

use v6;
use lib 'lib';

use Test;

use Assertions;

my @tests = (
{
ok  { my Int $foo = 42; (assert  $foo , :non-fatal) ~~ Bool },
  'retval is Int(Bool) (non-fatal)'
},
{
ok  { my Str $foo = '42'; (assert  $foo , :non-fatal) ~~ Bool },
  'retval is Str(Bool) (non-fatal)'
},
{
ok  { my Bool $foo = False; (assert  $foo , :non-fatal) === False },
  'retval is Bool(Bool) (non-fatal)'
},
{
ok  { my Bool $foo = True; (assert  $foo , :non-fatal) === True },
  'retval is Bool(Bool) (non-fatal)'
},
{
ok  { my Int $foo = 42; (assert { $foo }, :non-fatal) ~~ Bool },
  'retval is Int(Bool) (non-fatal)'
},
{
ok  { my Str $foo = '42'; (assert { $foo }, :non-fatal) ~~ Bool },
  'retval is Str(Bool) (non-fatal)'
},
{
ok  { my Bool $foo = False; (assert { $foo }, :non-fatal) === False },
  'retval is Bool(Bool) (non-fatal)'
},
{
ok  { my Bool $foo = True; (assert { $foo }, :non-fatal) === True },
  'retval is Bool(Bool) (non-fatal)'
},
);

plan @tests.elems;

&$_() for @tests;
