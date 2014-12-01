-- exc 8
-- funct1 3 [1,2,3,4,5,6,7] = [1,2,3,4,4,5,6,7]

funct1 :: Int -> [a] -> [a]
funct1 x xs = take (x + 1) xs ++ drop x xs
