## Lambda-etudes
Inspired from: https://github.com/norvig/pytudes

"An *étude* (a French word meaning *study*) is an instrumental musical composition, usually short, 
of considerable difficulty, and designed to provide practice material for perfecting a particular 
musical skill." &mdash; [Wikipedia](https://en.wikipedia.org/wiki/%C3%89tude)

This project is intended to derive common lambda calculus functions from the ground up with automatic testing (with QuickCheck) and Haskell's excellent type system.
Designed to be readable to non-Haskellers familiar with lambda calculus.

[`etudes.hs`](/etudes.hs) contains all the preliminary etudes.

## Running Tests
To run tests, load [`etudes.hs`](/etudes.hs) into `ghci` and run `runTests` like so:

``` haskell
>>> :l etudes.hs
>>> runTests
```

Sample output:

``` shell
GHCi, version 8.6.5: http://www.haskell.org/ghc/  :? for help
Prelude> :l etudes.hs 
[1 of 1] Compiling Main             ( etudes.hs, interpreted )
Ok, one module loaded.
*Main> runTests 
=== prop_zero from etudes.hs:24 ===
+++ OK, passed 1 test.

=== prop_one from etudes.hs:27 ===
+++ OK, passed 1 test.

=== prop_iszero from etudes.hs:34 ===
+++ OK, passed 100 tests; 91 discarded.

=== prop_succ from etudes.hs:41 ===
+++ OK, passed 100 tests; 93 discarded.

=== prop_plus from etudes.hs:44 ===
+++ OK, passed 100 tests; 276 discarded.

=== prop_pred from etudes.hs:50 ===
+++ OK, passed 100 tests; 96 discarded.

=== prop_numeralisinverseConversion from etudes.hs:70 ===
+++ OK, passed 100 tests; 85 discarded.

=== prop_boolisinverseConversion from etudes.hs:71 ===
+++ OK, passed 100 tests.

True
*Main> 
```
