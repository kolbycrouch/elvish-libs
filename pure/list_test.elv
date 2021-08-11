use ../contrib/test
use ./list

(test:set list [
  (test:set take [
    (test:is { put [(list:take 2 [1 2 3 4])] } [1 2])
    (test:is { put [(list:take -2 [1 2 3 4])] } [3 4])
  ])
  (test:set contains [
    (test:is { list:contains [foo 2 bar] foo } $true)
    (test:is { list:contains [[foo] [bar]] [foo] } $true)
    (test:is { list:contains [foo bar] baz } $false)
  ])
  (test:set contains-any [
    (test:is { list:contains-any [foo 2 bar] fo } $true)
    (test:is { list:contains-any [foo 2 bar] fooo } $false)
  ])
  (test:set search-list [
    (test:is { list:search-list [foo bar] foo } foo)
    (test:is { list:search-list [[foo] [bar]] [foo] } [foo])
    (test:is { list:search-list [[&foo=bar]] [&foo=bar] } [&foo=bar])
  ])
  (test:set has-index [
    (test:is { list:has-index [foo bar] 1 } $true)
    (test:is { list:has-index [foo bar] -1 } $true)
    (test:is { list:has-index [foo bar] 2 } $false)
  ])
  (test:set append [
    (test:is { list:append [foo bar] baz } [foo bar baz])
    (test:is { list:append [[foo] [bar]] [baz] } [[foo] [bar] [baz]])
  ])
  (test:set prepend [
    (test:is { list:prepend [foo bar] baz } [baz foo bar])
    (test:is { list:prepend [[foo] [bar]] [baz] } [[baz] [foo] [bar]])
  ])
  (test:set index-elem [
    (test:is { list:index-elem [foo bar baz] baz } (num 2))
    (test:is { list:index-elem [[foo] [bar] [baz]] [baz] } (num 2))
  ])
  (test:set next-elem [
    (test:is { list:next-elem [foo bar baz] bar } baz)
    (test:is { list:next-elem [foo bar baz] baz } $nil)
  ])
  (test:set prev-elem [
    (test:is { list:prev-elem [foo bar baz] bar } foo)
    (test:is { list:prev-elem [foo bar baz] foo } $nil)
  ])
  (test:set after-elem [
    (test:is { list:after-elem [foo bar baz] foo } [bar baz])
    (test:is { list:after-elem [foo bar baz] baz } [])
  ])
  (test:set before-elem [
    (test:is { list:before-elem [foo bar baz] baz } [foo bar])
    (test:is { list:before-elem [foo bar baz] foo } [])
  ])
])