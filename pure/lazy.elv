# list takes an arguement `$l` and outputs a function
# that outputs the next element of `$l` on each subsequent call.
# always outputs `$nil` after the last element in `$l`.
fn list {|l|
  var cache = $l
  put {
    if (eq (count $cache) (num 0)) {
      put $nil
    } else {
      put $cache[0]
      set cache = [(drop 1 $cache)]
    }
  }
}
