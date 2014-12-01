--import Prelude hiding ((||))
-- 0

-- no work
{-halve1 xs = (take n xs, drop n xs)
            where n = length xs / 2
-}

-- OK
halve2 xs = splitAt (length xs `div` 2) xs

-- OK
halve3 xs = (take (n `div` 2) xs, drop (n `div` 2) xs)
			where n = length xs

-- no work
halve4 xs = splitAt (length xs `div` 2)

-- no work
halve5 xs = (take n xs, drop (n+1) xs)
			where n = length xs `div` 2

-- OK			
halve6 xs = splitAt (div (length xs) 2) xs

-- no work
--halve7 xs = splitAt (length xs / 2) xs

-- OK
halve8 xs = (take n xs, drop n xs)
			where n = length xs `div` 2

-- 1

-- OK
safetail1 xs = if null xs then [] else tail xs

-- OK
safetail2 [] = []
safetail2 (_ : xs) = xs

-- no work
safetail3 (_ : xs)
  | null xs = []
  | otherwise = tail xs

-- OK
safetail4 xs
  | null xs = []
  | otherwise = tail xs
  
-- no work, warning
safetail5 xs = tail xs
safetail5 [] = []

-- OK
safetail6 [] = []
safetail6 xs = tail xs

-- not ok
safetail7 [x] = [x]
safetail7 (_ : xs) = xs

-- no work
-- on load: parse error on input `->' (last row)
{-safetail8
  = \ xs ->
      case xs of
	      [] -> []
		  (_ : xs) -> xs -}
		  

-- 2

let a || b | b == c = True 
           | otherwise = False

False or0 False = False
_ or0 _ = True
		
or1 a b | False || False = False
        | _ || _ = True

or2 a b | False || b = b
        | True || _ = True
		
b || c
   | b == c = True
   | otherwise = False
