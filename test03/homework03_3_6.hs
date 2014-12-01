import Prelude hiding ((&&))

-- OK
a && b = if a then b else False

main = do
  print $ False && False
  print $ False && True
  print $ True && False
  print $ True && True