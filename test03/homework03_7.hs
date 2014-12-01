-- remove 0 [1,2,3,4] = [2,3,4]

-- not OK
remove1 n xs = take n xs ++ drop n xs

-- not OK
remove2 n xs = drop n xs ++ take n xs

-- not OK
remove3 n xs = take (n + 1) xs ++ drop n xs

-- OK
remove4 n xs = take n xs ++ drop (n + 1) xs
