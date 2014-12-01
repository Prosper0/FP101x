import Prelude hiding ((||))

-- Not OK
b || c
  | b == c = True
  | otherwise = False

main = do
  print $ False || False
  print $ False || True
  print $ True || False
  print $ True || True
