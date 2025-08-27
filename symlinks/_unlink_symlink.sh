unlink_symlink() {
  local dest="$1"

  if [ -z "$dest" ]; then
    echo "usage: unlink_symlink <dest>" >&2
    return 2
  fi

  if [ -L "$dest" ]; then
    echo "Removing symlink: $dest"
    rm "$dest"
  elif [ -e "$dest" ]; then
    echo "$dest exists but is not a symlink. Skipping."
  else
    echo "$dest does not exist."
  fi
}
