use ./list
use ./map
use ./type

fn -check-params [f n]{
  if (not-eq (count $f[arg-names]) (num $n)) {
    fail "callable in argument 0 must have" $n "parameters"
  }
}

fn -check-for-cont [x]{
  if (and (not (type:is-list $x)) (not (type:is-map $x))) {
    fail "argument 1 must have type: list or map"
  }
}

# Output a container that has applied `$f` to all elements/values of `$x`.
# Works on the map type by applying `$f` to the value of all keys.
fn map [f x]{
  -check-params $f 1
  -check-for-cont $x

  if (type:is-list $x) {
    put [(each $f $x)]
  } else {
    keys $x |
      each [z]{ put [$z  ($f $x[$z])]} |
      make-map
  }
}

# Output a container with elements/values from `$x` that have output `$true` when `$f` is applied.
# Works on the map type by testing the values of all keys in `$x` and outputing a
# new map with only key/values pairs whos values tested `$true`.
fn filter [f x]{
  -check-params $f 1
  -check-for-cont $x
  
  if (type:is-list $x) {
    put [(each [e]{ if ($f $e) { put $e}} $x)]
  } else {
    keys $x |
      each [k]{ if ($f $x[$k]) { put [$k  $x[$k]]}} |
      make-map
  }
}

# Output a cumulative value gathered from reducing a container `$x` with `$f`.
# Works on the map type by accumulating the value of each key.
fn reduce [f x]{
  -check-params $f 2
  -check-for-cont $x

  vals = (if (type:is-map $x) { map:vals $x} else { put $x})
  fin = $nil
  all $vals |
    each [e]{
      if (eq $fin $nil) { fin = $e}
      if (not-eq (list:next-elem $vals $e) $nil) {
        fin = ($f $fin (list:next-elem $vals $e))
      }}
  put $fin
}

# Output a function where the parameters of `$f` have been partially supplied by elements of`$x`.
fn partial [f x]{
  -check-for-cont $x

  if (type:is-list $x) {
    put [@a]{ $f $@x $@a}
  }
}

# Output a function that takes 1 parameter, and applies all functions in list `$f` to it.
fn compose [f]{
  -check-for-cont $f
  
  reduce [a b]{
    put [x]{ $b ($a $x)}
  } $f
}