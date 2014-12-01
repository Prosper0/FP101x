import Prelude hiding ((||))

-- OK
b || False = b
_ || True = True

main = do
  print $ False || False
  print $ False || True
  print $ True || False
  print $ True || True

