# Output a container that has applied `$f` to all elements/values of `$x`.
# Works on the map type by applying `$f` to the value of all keys.
fn map [f x]{
  if (not-eq (count $f[arg-names]) (num 1)) {
  	fail "Callable in argument 0 must have 1 parameter."
  }

  if (and (not-eq (kind-of $x) list) (not-eq (kind-of $x) map)) {
    fail "Argument 1 must have type: List or Map."
  } elif (eq (kind-of $x) list) {
  	put [(each $f $x)]
  } else {
  	keys $x | each [z]{ put [$z  ($f $x[$z])] } | make-map
  }
}