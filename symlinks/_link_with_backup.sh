link_with_backup() {
  local src="$1" dest="$2"
  local ts
  ts="$(date +%Y%m%d-%H%M%S)"

  if [ -z "$src" ] || [ -z "$dest" ]; then
    echo "usage: link_with_backup <src> <dest>" >&2
    return 2
  fi
  if [ ! -e "$src" ]; then
    echo "ERROR: source '$src' does not exist." >&2
    return 1
  fi

  mkdir -p "$(dirname "$dest")"

  if [ -L "$dest" ]; then
    # existing symlink
    local cur
    cur="$(readlink "$dest")"
    if [ "$cur" = "$src" ]; then
      echo "OK: $dest already links to $src, skipping."
      return 0
    else
      echo "Replacing symlink: $dest -> $cur  with  $src"
      ln -sfn "$src" "$dest"
      return 0
    fi
  elif [ -e "$dest" ]; then
    # real file/dir
    echo "Backing up existing: $dest -> ${dest}.backup.$ts"
    mv "$dest" "${dest}.backup.$ts"
    ln -s "$src" "$dest"
    echo "Symlinked $dest -> $src"
    return 0
  else
    ln -s "$src" "$dest"
    echo "Symlinked $dest -> $src"
    return 0
  fi
}
