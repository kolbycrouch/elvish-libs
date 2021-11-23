use ../contrib/test
use ./map

(test:set map [
  (test:set vals [
    (test:is { map:vals [&a=1 &b=2 &c=3]} [1 2 3])
  ])
	(test:set merge [
		(test:is { map:merge [&a=1] [&b=2] [&c=3]} [&a=1 &b=2 &c=3])
	])
])