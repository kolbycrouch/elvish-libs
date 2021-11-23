use ./list
use ./type

fn match {|list|
  if (eq (type:is-odd (count $list)) $true) {
    fail "match requires pairs of booleans and callables"
  }
  all $list |
    each {|x| if (eq $x $true) { f = (list:next-elem $list $x); $f; return}}
}