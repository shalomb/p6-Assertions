# NAME

Assertions - Runtime assertions for Perl 6

# SYNOPSIS

    use Assertions

    my $x = 42;

    assert $x;           # Assert $x is defined and evaluates truthy

    assert x %% 5;       # Assert a simple expression. `assertion failed.`

    assert $x² < 1729,   # Include a user-friendly error message
          'Ramanujan was slightly off the mark';

    assert { ($x+1).is-prime };
                         # Assert a block

    assert {
        ((1/$x¹, 1/$x², 1/$x³ … { $_ < 1/($x**$x) }).elems) == $x;
      },
      "No magic found with $x";

    assert { $frodo.has-ring },
           { Logger.log('Oops, he did it again!'); }

`assert` throws an exception if the test expression fails. To make assertions
non-fatal and log failure messages to STDERR instead, use the `:non-fatal` flag.

    my $x = fetch-real-number();
    assert $x.sqrt !~~ NaN, :non-fatal; # $x might be a negative number
    with $x { do something(); }         # control resumes here
    … 

# DESCRIPTION

`Assertions` provides an assertion mechanism for Perl 6 in the style of 
[assert.h](http://en.wikipedia.org/wiki/Assert.h) (NOTE: Unlike `assert` from 
`assert.h`, these are subroutines and are not available at compilation time).

# TODO

* Make use of `DEBUG` and `NDEBUG` to control invoking assertions.
* Consider if Smart Comments may be of use.

# SEE ALSO

* [assert.h](http://en.wikipedia.org/wiki/Assert.h) - Wikipedia page on `assert.h`
* [assertions](http://search.cpan.org/perldoc?assertions) - Assertions for Perl >= 5.9.0

