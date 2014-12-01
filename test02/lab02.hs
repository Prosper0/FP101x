add2 :: Int -> Int
add2 x = x + x

add4 :: Int -> Int -> Int
add4 x y = x+y

add6 :: Int -> (Int -> Int)
add6 x y = x+y

add3 :: (Int, Int) -> Int
add3 (x,y) = x+y

zeroto :: Int -> [Int]
zeroto n = [0..n]

mult1 :: Int -> Int -> Int -> Int
mult1 x y z = x*y*z

-- mult2 x y z ---->>> ((mult2 x) y) z
mult2 :: Int -> (Int -> (Int -> Int))
mult2 x y z = x*y*z