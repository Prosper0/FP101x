import Prelude hiding ((&&))

-- OK
a && b = if a then if b then True else False else False

main = do
  print $ False && False
  print $ False && True
  print $ True && False
  print $ True && True