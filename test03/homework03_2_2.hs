import Prelude hiding ((||))

-- OK
False || b = b
True || _ = True

main = do
  print $ False || False
  print $ False || True
  print $ True || False
  print $ True || True

