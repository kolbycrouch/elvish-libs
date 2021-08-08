use ./list


memo_cache = [&]

# Memo size. 1e7 == 10M.
memo_count = (num 1e7)

# Run a Callable, and memoize it if it hasn't been.
fn memo [x]{
  if (has-key $memo_cache (put $x)) {
    put $memo_cache[(put $x)]
  # Reset memo if number of keys is higher than $memo_count.
  } elif (>= (count [(keys $memo_cache)]) $memo_count) {
      memo_cache = [&]
  } else {
    tmp = ($x)
    memo_cache[(put $x)] = $tmp
    put $tmp
  }
}