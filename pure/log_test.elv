use ../contrib/test
use ./log

(test:set log [
  (test:set console [
    (test:is { log:console foo} (echo (styled "==> INFO: foo" white)))
    (test:is { log:console &level=warning foo} (echo (styled "==> WARNING: foo" yellow)))
  ])
  (test:set log [
    (test:is { log:log &min=info foo} (echo (styled "==> INFO: foo" white)))
    (test:is { log:log &level=warning foo} (echo (styled "==> WARNING: foo" yellow)))
  ])
])