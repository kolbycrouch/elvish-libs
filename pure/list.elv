# github.com/kolbycrouch/elvish-libs list module.
use str

# like `builtin:take`, except supports negative index.
fn take [n list]{
  if (< $n 0) {
    all [(all $list)][$n':']
  } else { builtin:take $n $@list }
}

# Output `$true` if `$list` contains element `$s`.
fn contains [list s]{
  all $list | each [i]{
    if (eq $i $s) {
      put $true
      return
    }
  }
  put $false
}

# Output `$true` if `$list` contains element with sub-string `$s`.
fn contains-any [list s]{
  all $list | each [i]{
    if (str:contains $i $s) {
      put $true
      return
    }
  }
  put $false
}

# Output `$s` if it is found in `$list`.
fn search-list [list s]{
  all $list | each [i]{
    if (str:contains $i $s) {
      put $i
    }
  }
}

# Output `$true` if `$list` contains index number `$i`.
fn has-index [list i]{
  if (< $i (count $list)) {
    put $false
    return
  }
  put $true
}

# Output new list with `$a` appended to `$list`.
fn append [list a]{
  put [(all $list) $a]
}

# Output new list with `$a` prepended to `$list`.
fn prepend [list a]{
  put [$a (all $list)]
}

# Output index number of `$str` in `$list`.
fn index-elem [list str]{
  rng = [(range 0 (count $list))]
  cnt = [0]
  all $list | each [i]{
    if (not-eq $i $str) {
      cnt = [(all $cnt) (+ 1 $cnt[-1])]
    } else { break }
  }
  put (num $cnt[-1])
}

# Output the element that comes after `$str` in `$list`.
fn next-elem [list str]{
  ind = (index-elem $list $str)
  if (< (count $list) (+ 2 $ind)) {
    put $nil
  } else { put $list[(+ 1 $ind)] }
}

# Output the element that comes before `$str` in `$list`.
fn prev-elem [list str]{
  ind = (index-elem $list $str)
  if (eq (- $ind 1) (num '-1')) {
    put $nil
  } else { put $list[(- 1 $ind)] }
}
