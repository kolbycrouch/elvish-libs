# Output a list where all elements are values of map `$x`.
fn vals {|x|
  put [(all [(keys $x)] |
    each {|k| put $x[$k]})]
}

# Output a map where all key/values of maps `$m` are merged.
fn merge {|@m|
	nm = [&]
	all $m | each {|x|
		all [(keys $x)] | each {|y|
			nm[$y] = $x[$y]
		}
	}
	put $nm
}