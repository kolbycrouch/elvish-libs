# Output `$true` if `$x` is a string.
fn is-string {|x|
  eq (kind-of $x) string
}

# Output `$true` if `$x` is a number.
fn is-num {|x|
  eq (kind-of $x) number
}

# Output `$true` if `$x` is a list.
fn is-list {|x|
  eq (kind-of $x) list
}

# Output `$true` if `$x` is a map.
fn is-map {|x|
  eq (kind-of $x) map
}

# Output `$true` if `$x` is a function.
fn is-fn {|x|
  eq (kind-of $x) fn
}

# Output `$true` if `$x` is an even number.
fn is-even {|x|
  eq (% $x 2) (num 0)
}

# Output `$true` if `$x` is an odd number.
fn is-odd {|x|
  eq (% $x 2) (num 1)
}

# Output `$true` if container `$x` has no elements/keys.
fn is-empty {|x|
  eq (count $x) (num 0)
}

# Output a map where all keys from the map `$c` have been
# overwritten with the same keys from `$r`.
#
# Note: Ignores any key in `$r` that isn't in `$c`.
fn record {|c r|
  var m = [&]
  for i [(keys $c)] { 
    if (has-key $r $i) {
      set m[$i] = $r[$i]
    } else {
      set m[$i] = $c[$i]
    }
  }
  put $m
}
