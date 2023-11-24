function man
  set -x MANPAGER 'sh -c "col -bx | bat --language=man --decorations=never"'
  set -x MANROFFOPT '-c'
  command man $argv
  return $status
end
