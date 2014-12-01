import Prelude hiding ((&&))

-- OK
True && True = True
_ && _ = False

main = do
  print $ False && False
  print $ False && True
  print $ True && False
  print $ True && True
