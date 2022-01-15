# Output a list where all elements are values of map `$x`.
fn vals {|x|
  put [(all [(keys $x)] |
    each {|k| put $x[$k]})]
}

# Output a map where all key/values of maps `$m` are merged.
fn merge {|@m|
	var nm = [&]
	each {|x|
		each {|y|
			set nm[$y] = $x[$y]
		} [(keys $x)]
	} $m
	put $nm
}