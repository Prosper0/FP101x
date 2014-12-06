-- 1

putStr' :: String -> IO ()
putStr' [] = return ()
putStr' (x:xs) = putChar x >> putStr' xs

-- 2

-- OK
putStrLn1' :: String -> IO ()
putStrLn1' [] = putChar '\n'
putStrLn1' xs = putStr' xs >> putStrLn1' ""

-- OK 
putStrLn2' :: String -> IO ()
putStrLn2' [] = putChar '\n'
putStrLn2' xs = putStr' xs >> putChar '\n'

-- OK  
putStrLn3' :: String -> IO ()
putStrLn3' [] = putChar '\n'
putStrLn3' xs = putStr' xs >>= \ x -> putChar '\n'  

-- Not OK
--putStrLn4' :: String -> IO ()
--putStrLn4' [] = putChar '\n'
--putStrLn4' xs = putStr' xs >> \ x -> putChar '\n'   

-- OK
putStrLn5' :: String -> IO ()
putStrLn5' [] = putChar '\n'
putStrLn5' xs = putStr' xs >> putStr' "\n"

-- Not OK
--putStrLn6' :: String -> IO ()
--putStrLn6' [] = putChar '\n'
--putStrLn6' xs = putStr' xs >> putStrLn6' "\n"

-- Not OK 
--putStrLn7' :: String -> IO ()
--putStrLn7' [] = return ""
--putStrLn7' xs = putStrLn7' xs >> putStr' "\n" 

-- Not OK 
--putStrLn8' :: String -> IO ()
--putStrLn8' [] = putChar "\n"
--putStrLn8' xs = putStr' xs >> putChar '\n'

-- 3
-- #3
getLine' = get []

get :: String -> IO String
get xs
  = do x <- getChar
       case x of
         '\n' -> return xs
         _ -> get (xs ++ [x])
         
-- 4
-- #1
--interact' :: (String -> String) -> IO ()
--interact' f = do input <- getLine'
--                 putStrLn' (f input)
                 
-- 5
-- #2,#4,#5,#7 :(
sequence_1 :: Monad m => [m a] -> m ()
sequence_1 [] = return ()
sequence_1 (m:ms) = (foldl (>>) m ms) >> return ()

sequence_3 :: Monad m => [m a] -> m ()
sequence_3 [] = return ()
sequence_3 (m:ms) = m >> sequence_3 ms

sequence_4 :: Monad m => [m a] -> m ()
sequence_4 [] = return ()
sequence_4 (m:ms) = m >>= \_ -> sequence_4 ms

sequence_6 :: Monad m => [m a] -> m ()
sequence_6 ms = foldr (>>) (return ()) ms

sequence_' :: Monad m => [m a] -> m ()
sequence_' [] = return ()
sequence_' (m:ms) = (foldl (>>) m ms) >> return ()

-- 6

-- OK
sequence'_0 :: Monad m => [m a] -> m [a]
sequence'_0 [] = return []
sequence'_0 (m : ms)
  = m >>=
      \ a ->
        do as <- sequence'_0 ms
           return (a : as)

-- Not OK
{--
sequence'_1 :: Monad m => [m a] -> m [a]
sequence'_1 ms = foldr func (return ()) ms
  where
    func :: (Monad m) => m a -> m [a] -> m [a]
    func m acc
      = do x <- m
           xs <- acc
           return (x : xs)
--}

-- Not OK
{--sequence'_2 :: Monad m => [m a] -> m [a]
sequence'_2 ms = foldr func (return []) ms
  where
    func :: (Monad m) => m a -> m [a] -> m [a]
    func m acc = m : acc
 --}

-- Not OK
{--sequence'_3 :: Monad m => [m a] -> m [a]
sequence'_3 [] = return []
sequence'_3 (m : ms) = return (a : as)
  where
    a <- m
    as <- sequence'_3 ms
--}

-- OK
sequence'_4 :: Monad m => [m a] -> m [a]
sequence'_4 ms = foldr func (return []) ms
  where
    func :: (Monad m) => m a -> m [a] -> m [a]
    func m acc
      = do x <- m
           xs <- acc
           return (x : xs)

-- Not OK
{--sequence'_5 :: Monad m => [m a] -> m [a]
sequence'_5 [] = return []
sequence'_5 (m : ms)
  = m >>
      \ a ->
        do as <- sequence'_5 ms
           return (a : as)
--}

-- Not OK
{-sequence'_6 :: Monad m => [m a] -> m [a]
sequence'_6 [] = return []
sequence'_6 (m : ms) = m >>= \a ->
  as <- sequence'_6 ms
  return (a : as)
-}

-- OK
sequence'_7 :: Monad m => [m a] -> m [a]
sequence'_7 [] = return []
sequence'_7 (m : ms)
  = do a <- m
       as <- sequence'_7 ms
       return (a : as)

-- 7
-- mapM' reverse ["ab","3","12"]
sequence' :: Monad m => [m a] -> m [a]
sequence' [] = return []
sequence' (m : ms)
  = do a <- m
       as <- sequence' ms
       return (a : as)

-- OK
mapM'_0 :: Monad m => (a -> m b) -> [a] -> m [b]
mapM'_0 f as = sequence' (map f as)

-- OK
mapM'_1 :: Monad m => (a -> m b) -> [a] -> m [b]
mapM'_1 f [] = return []
mapM'_1 f (a : as)
  = f a >>= \b -> mapM'_1  f as >>= \bs -> return (b : bs)

-- Not OK
{-mapM'_2 :: Monad m => (a -> m b) -> [a] -> m [b]
mapM'_2 f as = sequence_' (map f as)
-}

-- Not OK
{-mapM'_3 :: Monad m => (a -> m b) -> [a] -> m [b]
mapM'_3 :: Monad m => (a -> m b) -> [a] -> m [b]
mapM'_3 f [] = return []
mapM'_3 f (a : as)
  = f a >> \b -> mapM'_3  f as >> \bs -> return (b : bs)
-}

-- Not OK
{-mapM'_4 :: Monad m => (a -> m b) -> [a] -> m [b]
mapM'_4 f [] = return []
mapM'_4 f (a : as) =
  do
    f a -> b
    mapM'_4  f as -> bs
    return (b : bs)
-}

-- OK
mapM'_5 :: Monad m => (a -> m b) -> [a] -> m [b]
mapM'_5 f [] = return []
mapM'_5 f (a : as) =
  do
    b <- f a
    bs <- mapM'_5  f as
    return (b : bs)

-- OK
mapM'_6 :: Monad m => (a -> m b) -> [a] -> m [b]
mapM'_6 f [] = return []
mapM'_6 f (a : as) =
  f a >>=
    \b ->
      do bs <- mapM'_6  f as
         return (b : bs)

-- Not OK
mapM'_7 :: Monad m => (a -> m b) -> [a] -> m [b]
mapM'_7 f [] = return []
mapM'_7 f (a : as) =
  f a >>=
    \b ->
      do bs <- mapM'_7  f as
         return (bs ++ [b])

-- 8
-- filterM1' (\x -> return (even x)) [1 .. 10]
filterM1' :: Monad m => (a -> m Bool) -> [a] -> m [a]
filterM1' _ [] = return []
filterM1' p (x : xs)
  = do flag <- p x
       ys <- filterM1' p xs
       if flag then return (x : ys) else return ys
       
-- 9
--foldLeftM (\a b -> putChar b >> return (b : a ++ [b])) [] "haskell" >>= \r -> putStrLn r
-- ==> haskelllleksahhaskell
foldLeftM :: Monad m => (a -> b -> m a) -> a -> [b] -> m a
foldLeftM _ i [] = return i
foldLeftM f i (x : xs) = f i x >>= \a -> foldLeftM f a xs

-- 10
--foldRightM (\a b -> putChar a >> return (a : b)) [] (show [1,3..10]) >>= \r -> putStrLn r
-- ==> ]9,7,5,3,1[[1,3,5,7,9]
foldRightM :: Monad m => (a -> b -> m b) -> b -> [a] -> m b
foldRightM _ v [] = return v
foldRightM f v (x : xs) = (foldRightM f v xs) >>= \z -> f x z

-- 11
--liftM0 (*10) (Just 2)
--liftM2 (*10) (Just 2)

-- OK
liftM0 :: Monad m => (a -> b) -> m a -> m b
liftM0 f m
  = do x <- m
       return (f x)

-- Not OK
{-liftM1 :: Monad m => (a -> b) -> m a -> m b
liftM1 f m = m >>= \a -> f a
-}

-- OK
liftM2 :: Monad m => (a -> b) -> m a -> m b
liftM2 f m = m >>= \a -> return (f a)

-- Not OK
{-liftM3 :: Monad m => (a -> b) -> m a -> m b
liftM3 f m = return (f m)
-}

-- Not OK
{-liftM4 :: Monad m => (a -> b) -> m a -> m b
liftM4 f m = m >>= \a -> m >>= \b -> return (f a)-}

-- Not OK
{-liftM5 :: Monad m => (a -> b) -> m a -> m b
liftM5 f m = m >>= \a -> m >>= \b -> return (f b)-}

-- Not OK
{-liftM6 :: Monad m => (a -> b) -> m a -> m b
liftM6 f m = mapM f [m]
-}

-- Not OK
{-liftM7 :: Monad m => (a -> b) -> m a -> m b
liftM7 f m = m >> \a -> return (f a)
-}