double x = x+x
quadruple x = double(double x)

factorial n = product [1..n]
average ns = sum ns `div` length ns

n = a `div` length xs
 where a = 10
       xs = [1, 2, 3, 4, 5]
	
-- funkar? men enligt facit är det fel då det ger en array :(
last1 xs = drop (length xs-1) xs
-- funkar?
last2 xs = head (drop (length xs-1) xs)
-- funkar inte!
last3 xs = tail (reverse xs)
-- funkar inte!
last4 xs = reverse (head xs)
-- funkar?
last5 xs = xs !! (length xs-1)
-- funkar inte!
last6 xs = head (drop (length xs) xs)
-- funkar?
last7 xs = head (reverse xs)
-- funkar inte!
last8 xs = reverse xs !! (length xs - 1)

-- funkar, men listan är reverse och enligt facit är det då fel :(
init1 xs = tail (reverse xs)
-- funkar ej
init2 xs = reverse (head (reverse xs))
-- funkar ej
init3 xs = reverse (tail xs)
-- funkar ej
init4 xs = take (length xs) xs
-- funkar
init5 xs = reverse (tail (reverse xs))
-- funkar ej
init6 xs = take (length xs-1) (tail xs)
-- funkar ej
init7 xs = drop (length xs-1) xs

sum1 [] = 0
sum1 (x:xs) = x + sum1 xs

-- funkar ej
product2 [] = 0
product2 (x : xs) = x * product2 xs
-- funkar, men tar exakt 3 inparametrar!
product3 [] = 1
product3 (x : (y : (z : xs))) = x * y * z * product3 xs
-- funkar
product4 [] = 1
product4 (x : xs) = x * product4 xs

-- EXC 7
-- funkar
qsort1 [] = []
qsort1 (x : xs) = qsort1 larger ++ [x] ++ qsort1 smaller
 where smaller = [a | a <- xs, a <= x]
       larger  = [b | b <- xs, b > x]
-- funkar ej
qsort2 [] = []
qsort2 (x : xs) = reverse (qsort2 smaller ++ [x] ++ qsort2 larger)
 where smaller = [a | a <- xs, a <= x]
       larger  = [b | b <- xs, b > x]
-- funkar ej, oändlig loop
qsort3 [] = []
qsort3 xs = qsort3 larger ++ qsort3 smaller ++ [x]
 where x = minimum xs
       smaller = [a | a <- xs, a <= x]
       larger  = [b | b <- xs, b > x]
-- funkar ej
qsort4 [] = []
qsort4 (x : xs) = reverse (qsort4 smaller) ++ [x] ++ reverse (qsort4 larger)
 where smaller = [a | a <- xs, a <= x]
       larger  = [b | b <- xs, b > x]
-- funkar
qsort5 [] = []
qsort5 (x : xs) = qsort5 larger ++ [x] ++ qsort5 smaller
 where larger  = [a | a <- xs, a > x || a == x]
       smaller = [b | b <- xs, b < x]
-- works kinda, but removes 1 of two nbr if they are the same
qsort6 [] = []
qsort6 (x : xs) = qsort6 larger ++ [x] ++ qsort6 smaller
 where smaller = [a | a <- xs, a < x]
       larger  = [b | b <- xs, b > x]
-- funkar
qsort7 [] = []
qsort7 (x : xs) = reverse (reverse (qsort7 smaller) ++ [x] ++ reverse (qsort7 larger))
 where smaller = [a | a <- xs, a <= x]
       larger  = [b | b <- xs, b > x]
-- funkar ej, loopar 4ever
qsort8 [] = []
qsort8 xs = x : qsort8 larger ++ qsort8 smaller
 where x = maximum xs
       smaller = [a | a <- xs, a < x]
       larger  = [b | b <- xs, b >= x]

-- EXC 8
qsort [] = []
qsort (x : xs) = qsort smaller ++ [x] ++ qsort larger
 where smaller = [a | a <- xs, a < x]
       larger = [b | b <- xs, b > x]