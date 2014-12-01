import Prelude hiding ((||))

-- OK
False || False = False
False || True = True
True || False = True
True || True = True

main = do
  print $ False || False
  print $ False || True
  print $ True || False
  print $ True || True