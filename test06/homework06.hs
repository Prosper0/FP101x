-- Exc 1

-- OK
-- all1 :: (a -> Bool) -> [a] -> Bool
all1 p xs = and (map p xs)

-- Not OK
--all2 p xs = map p (and xs)

-- OK
-- all3 :: (a -> Bool) -> [a] -> Bool
all3 p = and . map p

-- OK
-- all4 :: (a -> Bool) -> [a] -> Bool
all4 p = not . any (not . p)

-- Not OK
--all5 p  = map p . and

-- OK
-- all6 :: (a -> Bool) -> [a] -> Bool
all6 p xs = foldl (&&) True (map p xs)

-- Not OK, gives wrong answer
-- all7 :: (a -> Bool) -> [a] -> Bool
all7 p xs = foldr (&&) False (map p xs)

-- OK
-- all8 :: (a -> Bool) -> [a] -> Bool
all8 p = foldr (&&) True . map p