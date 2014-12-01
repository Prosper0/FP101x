-- 1
halve2 xs = ( take n xs, drop n xs ) 
            where n = length xs `div` 2

-- 2a
safetailcond xs = if null xs 
                  then []
				  else tail xs

-- 2b
safetailguard xs | null xs = []
                 | otherwise = tail xs

-- 2c
safetailpatt [] = []
safetailpatt xs = tail xs

-- 2c alt
safetailpattalt [] = []
safetailpattalt (_:xs) = xs

-- 6
-- mult x y z = x * y * z
-- mult = \x -> (\y -> (\z -> x * y * z))