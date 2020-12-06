{-# LANGUAGE TemplateHaskell #-}

import Test.QuickCheck

-- Church Booleans
true :: a -> b -> a
true = \x -> \y -> x -- the K combinator

false :: a -> b -> b
false = \x -> \y -> y -- the K* combinator

-- Other combinators
i :: a -> a
i = \x -> x
s = \x -> \y -> \z -> (x z (y z))

-- The Y combinator
-- y = \f -> ((\x -> f (x x)) \x -> f (x x)) -- doesn't work because type checking needs to be decidable!
y :: (a -> a) -> a
y f = f (y f)


zero = \f -> \x -> x
prop_zero = (numeralConvert zero) == 0 -- an automated test using QuickCheck

one = \f -> \x -> f x
prop_one = (numeralConvert one) == 1

-- A church numeral has type (a -> a) -> a -> a
-- A church boolean has type a -> b -> c
-- Arithmetic functions (with automated tests)
iszero :: ((p -> a1 -> b1 -> b1) -> (a2 -> b2 -> a2) -> t) -> t -- from ghci
iszero = (\n -> n (\x -> false) (true))
prop_iszero n = (n >= 0) ==> ((churchboolConvert (iszero (intConvert n))) == (n == 0))

-- TODO: Why does this not work?:
-- iszero :: ((a -> a) -> a -> a) -> (a -> b -> c)

succ :: ((a -> a) -> a -> a) -> (a -> a) -> a -> a
succ n = \f -> \x -> f (n f x)
prop_succ n = (n >= 0) ==> ((numeralConvert (Main.succ (intConvert n))) == n + 1) -- QuickCheck!

plus = \m -> \n -> m Main.succ n
prop_plus n m = ((n >= 0) && (m >= 0)) ==> ((numeralConvert (plus (intConvert n) (intConvert m))) == n + m) -- QuickCheck!


-- The types are a tad bit undecipherable
pred :: (((t1 -> t2) -> (t2 -> t3) -> t3) -> (p1 -> p2) -> (a -> a) -> t4) -> t1 -> p2 -> t4
pred n = \f -> \x -> ((n (\g -> \h -> h (g f)) (\u -> x)) i)
prop_pred n = (n >= 1) ==> ((numeralConvert (Main.pred (intConvert n))) == n - 1)

-- Church Numerals constructor/converter (for use in testing)
-- TODO: use more specific types
intConvert :: Int -> (a -> a) -> a -> a
intConvert n = \f -> (\x -> iterate f x !! n) -- f^n x

numeralConvert :: ((Int -> Int) -> Int -> Int) -> Int
numeralConvert n = n (\x -> x + 1) 0

boolConvert :: Bool -> a -> a -> a
boolConvert a
  | a == True = true
  | a == False = false

churchboolConvert :: (Bool -> Bool -> Bool) -> Bool
churchboolConvert a = a True False

-- This asserts that intConvert and numeralConvert are inverse functions
-- Note that the aformentioned functions are defined only on the natural numbers
prop_numeralisinverseConversion n = (n >= 0) ==> ((numeralConvert (intConvert n)) == n)
prop_boolisinverseConversion n = ((churchboolConvert (boolConvert n)) == n)


-- for testing
return []
runTests = $quickCheckAll


-- This gets away from Church Booleans in the traditional sense to allow for better type checking
-- Church Boolean type class (less ugly types)
-- class ChurchBoolean a where
  -- bool :: a -> b -> b -> b
  -- not ::

-- Church Numerals type class (less ugly types)
-- class ChurchNumeral a where
--   number :: a -> (b -> b) -> b -> b
--   add :: Int -> a -> a
--   succ :: a -> a
--   pred :: a -> a
