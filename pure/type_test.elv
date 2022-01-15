use ../contrib/test
use ./type

(test:set type [
  (test:set is-string [
    (test:is { type:is-string foo} $true)
    (test:is { type:is-string (num 1)} $false)
  ])
  (test:set is-num [
    (test:is { type:is-num (num 1)} $true)
    (test:is { type:is-num foo} $false)
  ])
  (test:set is-list [
    (test:is { type:is-list [1 2]} $true)
    (test:is { type:is-list (num 1)} $false)
  ])
  (test:set is-map [
    (test:is { type:is-map [&a=foo]} $true)
    (test:is { type:is-map [foo]} $false)
  ])
  (test:set is-fn [
    (test:is { type:is-fn { }} $true)
    (test:is { type:is-fn [foo]} $false)
  ])
  (test:set is-even [
    (test:is { type:is-even 2} $true)
    (test:is { type:is-even 1} $false)
  ])
  (test:set is-odd [
    (test:is { type:is-odd 1} $true)
    (test:is { type:is-odd 2} $false)
  ])
  (test:set is-empty [
    (test:is { type:is-empty []} $true)
    (test:is { type:is-empty [1]} $false)
  ])
  (test:set record [
    (test:is { type:record [&foo=1 &bar=2] [&foo=2 &bar=1]} [&foo=2 &bar=1])
    (test:is { type:record [&foo=1 &bar=2] [&baz=3]} [&foo=1 &bar=2])
  ])
])
