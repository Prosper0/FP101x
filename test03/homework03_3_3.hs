import Prelude hiding ((&&))

-- not OK
a && b = if not (a) then not (b) else True

main = do
  print $ False && False
  print $ False && True
  print $ True && False
  print $ True && True