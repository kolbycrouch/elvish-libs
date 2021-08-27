use ../contrib/test
use ./fun

(test:set fun [
  (test:set map [
    (test:is { fun:map [n]{ + 2 $n} [1 2 3]} [(num 3) (num 4) (num 5)])
    (test:is { fun:map [n]{ + 2 $n} [&a=1 &b=2 &c=3]} [&a=(num 3) &b=(num 4) &c=(num 5)])
  ])
  (test:set filter [
    (test:is { fun:filter [n]{ >= $n 3} [1 2 3 4 5]} [3 4 5])
    (test:is { fun:filter [n]{ >= $n 2} [&a=1 &b=2 &c=3]} [&b=2 &c=3])
  ])
  (test:set reduce [
    (test:is { fun:reduce [a b]{ + $a $b} [1 2 3 4]} (num 10))
    (test:is { fun:reduce [a b]{ + $a $b} [&a=1 &b=2 &c=3 &d=4]} (num 10))
  ])
  (test:set partial [
    (test:is { (fun:partial [a b c]{ + $a $b $c} [4]) 2 4} (num 10))
  ])
  (test:set compose [
    (test:is { (fun:compose [[x]{ * 3 $x } [x]{ + 2 $x}]) 5} (num 17))
  ])
    (test:set memoize [
    (test:is { (fun:memoize { put foo})} foo)
  ])
])