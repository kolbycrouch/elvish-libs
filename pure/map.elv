# Output a list where all elements are values of map `$x`.
fn vals [x]{
  put [(all [(keys $x)] |
    each [k]{ put $x[$k]})]
}