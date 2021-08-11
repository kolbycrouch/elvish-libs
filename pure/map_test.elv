use ../contrib/test
use ./map

(test:set map [
  (test:set vals [
    (test:is { map:vals [&a=1 &b=2 &c=3]} [1 2 3])
  ])
])