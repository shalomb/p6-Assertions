# NAME

Assertions - Runtime assertions for Perl 6

# SYNOPSIS

    use Assertions

    my $x = 42;

    assert $x;                      # Assert $x is defined and evaluates to something truthy

    assert x %% 5;                  # Assert a simple expression. `assertion failed.`

    assert $x² < 1729,              # Include a user-friendly error message
          'Ramanujan was slightly off the mark';

    assert { ($x+1).is-prime };     # Assert a block

    assert {
        ((1/$x¹, 1/$x², 1/$x³ … { $_ < 1/($x**$x) }).elems) == $x;
      },
      "No magic found with $x";

    assert { $frodo.has-ring },
           { Logger.log('Oops, he did it again!'); }

## Non-fatal assertions

In line with `assert` available in languages like C, C++, Python, etc `assert`
throws an exception if the test expression fails. To make assertions non-fatal
and log failure messages to STDERR instead, use the `:non-fatal` flag.

    my $x = (-20,-15 ... 30).pick;
    assert $x.sqrt !~~ NaN, :non-fatal;       # $x might be a negative number
    with $x { do something(); }               # control resumes here
    … 

# DESCRIPTION

`Assertions` provides an assertion mechanism for Perl 6 in the style of 
[assert.h](http://en.wikipedia.org/wiki/Assert.h) (NOTE: Unlike `assert` from 
`assert.h`, these are subroutines and are not available at compilation time).

## Note

Perl6's type system, sub/method signatures and return types, exceptions, etc
somewhat make assertions an unneeded feature of the language and you should
defer to the features of the language over the use of `assert` from this module
for performance and stability (amongst other) reasons.

# TODO

* Make use of `DEBUG` and `NDEBUG` to control assertions.
* Enable tracing to track triggered assertions.
* Consider if Smart Comments may be of use.

# SEE ALSO

* [assert.h](http://en.wikipedia.org/wiki/Assert.h) - Wikipedia page on `assert.h`
* [assertions](http://search.cpan.org/perldoc?assertions) - Assertions for Perl >= 5.9.0

