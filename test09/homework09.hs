{-# LANGUAGE NPlusKPatterns #-}

import Data.Char
import Data.List
import Unsafe.Coerce

data Nat = Zero
         | Succ Nat
         deriving Show

-- 0
-- natToInteger (Succ (Succ (Succ Zero)))

natToInteger0 :: Nat -> Integer
natToInteger0 Zero = 0
natToInteger0 (Succ n) = natToInteger0 n + 1

natToInteger1 :: Nat -> Integer
natToInteger1 (Succ n) = natToInteger1 n + 1
natToInteger1 Zero = 0

natToInteger3 :: Nat -> Integer
natToInteger3 (Succ n) = 1 + natToInteger3 n
natToInteger3 Zero = 0

-- Not OK
natToInteger4 :: Nat -> Integer
natToInteger4 Zero = 1
natToInteger4 (Succ n) = (1 + natToInteger4 n) - 1

natToInteger5 :: Nat -> Integer
natToInteger5 = head . m
  where m Zero = [0]
        m (Succ n) = [sum [x | x <- (1 : m n)]]
        
natToInteger6 :: Nat -> Integer
natToInteger6 = \n -> genericLength [c | c <- show n, c == 'S']

-- Not OK, not type check
natToInteger7 :: Nat -> Int
natToInteger7 = \n -> length [c | c <- show n, c == 'S']

-- 1
-- integerToNat (3::Integer)
integerToNat0 :: Integer -> Nat
integerToNat0 0 = Zero
integerToNat0 (n + 1) = Succ (integerToNat0 n)

integerToNat4 :: Integer -> Nat
integerToNat4 (n + 1) = Succ (integerToNat4 n)
integerToNat4 0 = Zero

integerToNat5 :: Integer -> Nat
integerToNat5 (n + 1) = let m = integerToNat5 n in Succ m
integerToNat5 0 = Zero

-- 2
--add (Succ (Succ Zero)) (Succ Zero) => Succ (Succ (Succ Zero))
add0 :: Nat -> Nat -> Nat
add0 Zero n = n
add0 (Succ m) n = Succ (add0 n m)

add1 :: Nat -> Nat -> Nat
add1 (Succ m) n = Succ (add1 n m)
add1 Zero n = n

add2 :: Nat -> Nat -> Nat
add2 Zero n = Zero
add2 (Succ m) n = Succ (add2 m n)

add3 :: Nat -> Nat -> Nat
add3 (Succ m) n = Succ (add3 m n)
add3 Zero n = n

add4 :: Nat -> Nat -> Nat
add4 n Zero = n
add4 n (Succ m) = Succ (add4 n m)

add5 :: Nat -> Nat -> Nat
add5 n (Succ m) = Succ (add5 n m)
add5 n Zero = n

add6 :: Nat -> Nat -> Nat
add6 n Zero = n
add6 n (Succ m) = Succ (add6 m n)

add7 :: Nat -> Nat -> Nat
add7 n (Succ m) = Succ (add7 m n)
add7 n Zero = n

-- 3
--natToInteger (mult m n) = natToInteger m * natToInteger n. 
--natToInteger0(mult(Zero) (Zero)) ==> 0 * 0 = 0
--natToInteger0(mult(Succ (Succ Zero)) (Succ (Succ Zero))) ==> 2 * 2 = 4
mult m Zero = Zero
mult m (Succ n) = add0 m (mult m n)

-- 4
--occurs 3 (Node (Leaf 3) 4 (Leaf 5))
data Tree = Leaf Integer | Node Tree Integer Tree deriving Show

-- OK
occurs0 :: Integer -> Tree -> Bool
occurs0 m (Leaf n) = m == n
occurs0 m (Node l n r)
  = case compare m n of
      LT -> occurs0 m l
      EQ -> True
      GT -> occurs0 m r

-- Not OK
occurs1 :: Integer -> Tree -> Bool
occurs1 m (Leaf n) = m == n
occurs1 m (Node l n r)
  = case compare m n of
      LT -> occurs1 m r
      EQ -> True
      GT -> occurs1 m l

-- Not OK
occurs3 :: Integer -> Tree -> Bool
occurs3 m (Leaf n) = m == n
occurs3 m (Node l n r)
  = case compare m n of
      LT -> occurs3 m l
      EQ -> False
      GT -> occurs3 m r

-- OK
occurs4 :: Integer -> Tree -> Bool
occurs4 m (Leaf n) = m == n
occurs4 m (Node l n r)
  | m == n = True
  | m < n = occurs4 m l
  | otherwise = occurs4 m r

-- Not OK
occurs5 :: Integer -> Tree -> Bool
occurs5 m (Leaf n) = m == n
occurs5 m (Node l n r)
  | m == n = True
  | m > n = occurs5 m l
  | otherwise = occurs5 m r

-- 5
-- ???
data TreeX = LeafX Integer
           | NodeX TreeX TreeX deriving Show

balancedX :: TreeX -> Bool

leavesX (LeafX _) = 1
leavesX (NodeX l r) = leavesX l + leavesX r
balancedX (LeafX _) = True
balancedX (NodeX l r) = abs (leavesX l - leavesX r) <= 1 && balancedX l && balancedX r

-- 6
--balance [1,2]  ==>  NodeX (LeafX 1) (LeafX 2)
--balancedX (balance [0..100]

balance :: [Integer] -> TreeX
halve xs = splitAt (length xs `div` 2) xs
balance [x] = LeafX x
balance xs = NodeX (balance ys) (balance zs)
    where (ys, zs) = halve xs

-- 9
{-instance Monad Maybe where
    return x = Just x
    Nothing >>= _ = Nothing
    (Just x) >>= f = f x-}