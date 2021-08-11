use ../contrib/test
use ./util

(test:set util [
  (test:set match [
    (test:is { util:match [(eq 1 2) { put foo} (eq 1 1) { put bar} (eq 2 2) { put baz}]} bar)
  ])
])