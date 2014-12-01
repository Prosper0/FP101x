import Prelude hiding ((&&))

-- not OK
a && b = if a then if b then False else True else False

main = do
  print $ False && False
  print $ False && True
  print $ True && False
  print $ True && True