# github.com/kolbycrouch/elvish-libs argparse module.
use str
use ./list

# Output new map with cli args parsed.
fn parse [map]{
  newargs = []
  all $args | each [i]{
    if (str:contains $i '-') {
      newargs = [(all $newargs) $i]
    } elif (str:contains $i '--') {
      newargs = [(all $newargs) $i]
    }
  }
  newmap = $map
  all $newargs | each [i]{
    if (not (has-key $newmap (str:trim-left $i '-'))) {
      newmap[(str:trim-left $i '-')] = [&]
    }
    newmap[(str:trim-left $i '-')][val] = (list:next-elem $args $i)
  }
  put $newmap
}
