
#!/bin/bash
set -euo pipefail

APP_NAME="Macsploit.api"
INSTALL_DIR="$HOME/Library/Application Support/Macsploit.api"

printf '\n%s\n' "=================================="
printf '  %s Installer\n' "$APP_NAME"
printf '%s\n\n' "=================================="

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Error: This installer requires macOS."
  exit 1
fi

ARCH="$(uname -m)"

case "$ARCH" in
  arm64)
    echo "Detected Apple Silicon Mac."
    ;;
  x86_64)
    echo "Detected Intel Mac."
    ;;
  *)
    echo "Error: Unsupported processor architecture: $ARCH"
    exit 1
    ;;
esac

if ! command -v python3 >/dev/null 2>&1; then
  echo "Python 3 is not installed."
  echo "Install Python 3, then run this installer again."
  exit 1
fi

mkdir -p "$INSTALL_DIR"
chmod 700 "$INSTALL_DIR"

printf '\nInstallation directory:\n%s\n' "$INSTALL_DIR"
printf '\nPython version: '
python3 --version

printf '\nMacsploit.api setup directory created successfully.\n'
echo "The remote agent has not been installed yet."
echo "No remote connection or background service was started."
