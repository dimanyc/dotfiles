
#!/usr/bin/env bash
set -euo pipefail

bash "$(dirname "$0")/brew/uninstall.sh"
bash "$(dirname "$0")/symlinks/uninstall.sh"

