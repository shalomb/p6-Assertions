#!/usr/bin/env perl6

use v6;

unit module Assertions;

proto assert (|)
    is export
    is hidden-from-backtrace
  { * };

sub act-on (
    Str   $failure-message,
    Bool :$non-fatal = False
  ) is hidden-from-backtrace {
  $non-fatal
    ?? note($failure-message ~ "\n" ~ Backtrace.new)
    !! die($failure-message);
}

#! assert(Bool, Str)
multi sub assert (
    Mu    $test-expression,
    Str   $failure-message = '',
    Bool :$non-fatal = False
    --> Bool:D
  ) is hidden-from-backtrace {
  act-on("assertion failed. $failure-message", :$non-fatal)
    unless $test-expression;
  ?$test-expression;
}

#| assert(Bool, Block)
multi sub assert (
    Mu    $test-expression,
    Block $failure-expression,
    Bool :$non-fatal = False
    --> Bool:D
  ) is hidden-from-backtrace {
  &$failure-expression() unless $test-expression;
  ?$test-expression;
}

sub handle (
    Block  :$test-expression,
    Block  :$failure-expression,
    Str    :$failure-message,
    Bool   :$non-fatal = False
    --> Bool:D
  ) is hidden-from-backtrace {

  my $error-handler = {
    my $error-message = "assertion failed.";
    my $action = $non-fatal ?? &note !! &die;

    if $failure-expression {
      &$failure-expression()
    }
    else {
      $error-message ~= " $failure-message" if $failure-message;
      &$action( $error-message );
    }
  };

  if $non-fatal {
    try {
      return ?&$test-expression();
      CATCH {
        default {
          &$error-handler();
          return False;
        }
      }
    }
  }
  else {
    unless &$test-expression() {
      &$error-handler();
      return False;
    }
  }

  return True;
}

#| assert(Block, Str)
multi sub assert (
    Block $test-expression,
    Str   $failure-message = '',
    Bool :$non-fatal = False
    --> Bool:D
  ) is hidden-from-backtrace {
    handle
      test-expression => $test-expression,
      failure-message => $failure-message,
      :$non-fatal
}

#| assert(Block, Block)
multi sub assert (
    Block $test-expression,
    Block $failure-expression,
    Bool :$non-fatal = False
    --> Bool:D
  ) is hidden-from-backtrace {
    handle
      test-expression    => $test-expression,
      failure-expression => $failure-expression,
      :$non-fatal
}

# vim:syntax=perl6

