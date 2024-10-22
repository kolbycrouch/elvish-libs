use ./list
use ./map
use ./type

# Output a container that has applied `$f` to all elements/values of `$x`.
# Works on the map type by applying `$f` to the value of all keys.
fn map {|f x|
  if (type:is-list $x) {
    put [(each $f $x)]
  } else {
    keys $x |
      each {|z| put [$z  ($f $x[$z])]} |
      make-map
  }
}

# Output a container with elements/values from `$x` that have output `$true` when `$f` is applied.
# Works on the map type by testing the values of all keys in `$x` and outputing a
# new map with only key/values pairs whos values tested `$true`.
fn filter {|f x|
  if (type:is-list $x) {
    put [(each {|e| if ($f $e) { put $e}} $x)]
  } else {
    keys $x |
      each {|k| if ($f $x[$k]) { put [$k  $x[$k]]}} |
      make-map
  }
}

# Output a cumulative value gathered from reducing a container `$x` with `$f`.
# Works on the map type by accumulating the value of each key.
fn reduce {|f x|
  var vals = (if (type:is-map $x) { map:vals $x} else { put $x})
  var fin = $nil
  all $vals |
    each {|e|
      if (eq $fin $nil) { set fin = $e}
      if (not-eq (list:next-elem $vals $e) $nil) {
        set fin = ($f $fin (list:next-elem $vals $e))
      }}
  put $fin
}

# Output a function where the parameters of `$f` have been partially supplied by elements of`$x`.
fn partial {|f x|
  if (type:is-list $x) {
    put {|@a| $f $@x $@a}
  }
}

# Output a function that takes 1 parameter, and applies all functions in list `$f` to it.
fn compose {|f|
  reduce {|a b|
    put {|x| $b ($a $x)}
  } $f
}

# Output a function that wraps `$f` with a cache of previous outputs from calling `$f`.
fn memoize {|f|
  var cache = [&]
  put {|@args|
    if (has-key $cache $args) {
      all $cache[$args]
    } else {
      set cache[$args] = [($f $@args)]
      all $cache[$args]
    }
  }
}