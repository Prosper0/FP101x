-- 1
{-
(*) :: Int -> Int -> Int
m * 0 = 0
m * (n+1) = m + (m * n)

4 * 3
= {applying * }
4 + (4 * 2)
= {applying * }
4 + (4 + (4 * 1))
= {applying * }
4 + (4 + (4 + (4 * 0)))
= {applying * }
4 + (4 + (4 + 0))
= {applying + }
12

(^) :: Int -> Int -> Int
m ^ 0 = 1
m ^ (n+1) = m * (m ^ n)

2 ^ 3
= {applying ^ }
2 * (2 ^ 2) -- 3-1
= {applying * }
2 * (2 * (2 ^ 1)) -- 3-2
= {applying ^ }
2 * (2 * (2 * (2 * 0)))
= {applying * }
2 * (2 * (2 + 1))
= {applying * }
8

-}

-- 2
{-
length [1, 2, 3]

drop 3 [1, 2, 3, 4, 5]

init [1, 2, 3]
-}

