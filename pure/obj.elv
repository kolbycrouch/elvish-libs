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
	cls = []
  els = [&]

	ob = $obj
	if (eq (kind-of $inherit) "map") {
		ob = (map:merge $inherit $obj)
	}
	
	all [(keys $ob)] | each {|x|
    if (eq (kind-of $ob[$x]) "fn") {
			cls = [(all $cls) (put $x "=" $obj[$x][def]";")]
		} else {
			els[$x] = $ob[$x]
		}
	}

  ns = $nil

	eval &ns=(ns $els) &on-end={|n| ns = $n} (str:join " " $cls)

	put $ns
}