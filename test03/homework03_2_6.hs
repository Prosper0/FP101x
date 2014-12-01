import Prelude hiding ((||))

-- OK
b || c
  | b == c = c
  | otherwise = True

main = do
  print $ False || False
  print $ False || True
  print $ True || False
  print $ True || True
