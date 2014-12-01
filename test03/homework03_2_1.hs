import Prelude hiding ((||))

-- OK
False || False = False
_ || _ = True

main = do
  print $ False || False
  print $ False || True
  print $ True || False
  print $ True || True


