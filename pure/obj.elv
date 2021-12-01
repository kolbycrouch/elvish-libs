use str

use ./map

# instance takes a map `$obj` as an arguement and outputs
# a namespace where all functions are redefined using `eval`
# after evaluating non-function key/values in the map.
# variables to non-functions become top-level variables in
# this namespace so later function definitions can modify them.
#
# The optional parameter `$inherit` is a map to be merged with `$obj`
#
# Non-function values in the map cannot reference other key/values
# in the same map without an extra parsing step. This has yet to be
# implemented.

fn instance {|&inherit=$nil obj|
	var cls = []
	var els = [&]

	var ob = $obj
	if (eq (kind-of $inherit) "map") {
		set ob = (map:merge $inherit $obj)
	}
	
	all [(keys $ob)] | each {|x|
		if (eq (kind-of $ob[$x]) "fn") {
			set cls = [(all $cls) (put $x "=" $obj[$x][def]";")]
		} else {
			set els[$x] = $ob[$x]
		}
	}

	var ns = $nil

	eval &ns=(ns $els) &on-end={|n| set ns = $n} (str:join " " $cls)

	put $ns
}