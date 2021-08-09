use ../contrib/test
use ./fun

(test:set github.com/kolbycrouch/elvish-libs/pure/fun [
  (test:set map [
    (test:is { fun:map [n]{ + 2 $n} [1 2 3]} [(num 3) (num 4) (num 5)])
    (test:is { fun:map [n]{ + 2 $n} [&a=1 &b=2 &c=3]} [&a=(num 3) &b=(num 4) &c=(num 5)])
  ])
])