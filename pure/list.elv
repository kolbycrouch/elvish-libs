# github.com/kolbycrouch/elvish-libs list module.
use builtin
use str

# like `builtin:take`, except supports negative index.
fn take {|n list|
  if (< $n 0) {
    all [(all $list)][$n..]
  } else { builtin:take $n $list }
}

# Output `$true` if `$list` contains element `$e`.
fn contains {|list e|
  all $list | each {|i|
    if (eq $i $e) {
      put $true
      return
    }
  }
  put $false
}

# Output `$true` if `$list` contains element with sub-string `$s`.
fn contains-any {|list s|
  all $list | each {|i|
    if (str:contains $i $s) {
      put $true
      return
    }
  }
  put $false
}

# Output `$e` if it is found in `$list`.
fn search-list {|list e|
  all $list | each {|i|
    if (eq $i $e) {
      put $i
    }
  }
}

# Output `$true` if `$list` contains index number `$i`.
fn has-index {|list i|
  if (<= (count $list) $i) {
    put $false
    return
  }
  put $true
}

# Output new list with `$e` appended to `$list`.
fn append {|list e|
  put [(all $list) $e]
}

# Output new list with `$e` prepended to `$list`.
fn prepend {|list e|
  put [$e (all $list)]
}

# Output index number of `$e` in `$list`.
fn index-elem {|list e|
  rng = [(range 0 (count $list))]
  cnt = [0]
  all $list | each {|i|
    if (not-eq $i $e) {
      cnt = [(all $cnt) (+ 1 $cnt[-1])]
    } else { break }
  }
  put (num $cnt[-1])
}

# Output the element that comes after `$e` in `$list`.
fn next-elem {|list e|
  ind = (index-elem $list $e)
  if (< (count $list) (+ 2 $ind)) {
    put $nil
  } else { put $list[(+ 1 $ind)] }
}

# Output the element that comes before `$e` in `$list`.
fn prev-elem {|list e|
  ind = (index-elem $list $e)
  if (eq (- $ind 1) (num '-1')) {
    put $nil
  } else { put $list[(- 1 $ind)] }
}

# Output list of all elements after `$e` in `$list`.
fn after-elem {|list e|
  put $list[(+ 1 (index-elem $list $e))..]
}

# Output list of all elements before `$e` in `$list`.
fn before-elem {|list e|
  put $list[..(index-elem $list $e)]
}

# Output list with element `$e` removed from `$list`.
fn remove {|list e|
  put [(each {|x| if (eq $e $x) { } else { put $x}} $list)]
}