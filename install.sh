#!/usr/bin/env bash
set -euo pipefail

bash "$(dirname "$0")/brew/install.sh"
bash "$(dirname "$0")/symlinks/install.sh"
