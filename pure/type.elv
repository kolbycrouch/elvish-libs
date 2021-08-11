# Output `$true` if `$x` is a string.
fn is-string [x]{
  eq (kind-of $x) string
}

# Output `$true` if `$x` is a number.
fn is-num [x]{
  eq (kind-of $x) number
}

# Output `$true` if `$x` is a list.
fn is-list [x]{
  eq (kind-of $x) list
}

# Output `$true` if `$x` is a map.
fn is-map [x]{
  eq (kind-of $x) map
}

# Output `$true` if `$x` is an even number.
fn is-even [x]{
  eq (% $x 2) (num 0)
}

# Output `$true` if `$x` is an odd number.
fn is-odd [x]{
  eq (% $x 2) (num 1)
}