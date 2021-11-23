use ./list
use ./util

# Precedence of log levels.
precedence = [
  debug
  info
  warning
  error
  critical
]

# Print a styled `$s`.
fn -print {|&color=white s|
  echo (styled (echo '==> '$s) $color)
}

fn -print-critical {|s|
  -print 'CRITICAL: '$s &color=red
}

fn -print-debug {|s|
  -print 'DEBUG: '$s &color=blue
}

fn -print-error {|s|
  -print 'ERROR: '$s &color=bright-red
}

fn -print-info {|s|
  -print 'INFO: '$s
}

fn -print-warning {|s|
  -print 'WARNING: '$s &color=yellow
}

# Print `$s` with log level `$level`.
fn console {|&level=info s|
  util:match [
    (eq $level critical)
    { -print-critical $s}
    (eq $level debug)
    { -print-debug $s}
    (eq $level error)
    { -print-error $s}
    (eq $level info)
    { -print-info $s}
    (eq $level warning)
    { -print-warning $s}
  ]
}

# Takes a callable called `$handler` (that takes 1 string and 1 optional parameter `&level=`)
# and passes a log level `$level` and a string `$s` to it.
# Do nothing if `$level` is a lower precedence than `$min`.
fn log {|&handler=$console~ &level=info &min=warning s|
  if (list:contains (list:before-elem $precedence $min) $level) {
    return 
  } else {
    util:match [
      (eq $handler $console~)
      { $console~ &level=$level $s}
    ]
  }
}