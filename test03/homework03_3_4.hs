import Prelude hiding ((&&))

-- not OK!
a && b = if a then b

main = do
  print $ False && False
  print $ False && True
  print $ True && False
  print $ True && True