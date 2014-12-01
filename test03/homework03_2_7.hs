import Prelude hiding ((||))

-- Not OK
b || True = b
_ || True = True

main = do
  print $ False || False
  print $ False || True
  print $ True || False
  print $ True || True

