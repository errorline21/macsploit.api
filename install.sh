#!/bin/bash
set -euo pipefail

APP_NAME="Macsploit.api"
INSTALL_DIR="$HOME/Library/Application Support/Macsploit.api"
REPO_BASE="https://raw.githubusercontent.com/errorline21/macsploit.api/main"

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
    echo "Error: Python 3 is not installed."
    exit 1
fi

mkdir -p "$INSTALL_DIR"
chmod 700 "$INSTALL_DIR"

TEMP_FILE="$(mktemp)"
trap 'rm -f "$TEMP_FILE"' EXIT

echo
echo "Downloading agent..."

if ! curl --fail --silent --show-error \
    "$REPO_BASE/agent.py" \
    -o "$TEMP_FILE"; then
    echo "Error: Could not download agent.py."
    exit 1
fi

if ! grep -q 'def main():' "$TEMP_FILE"; then
    echo "Error: Downloaded agent.py did not pass validation."
    exit 1
fi

install -m 600 "$TEMP_FILE" "$INSTALL_DIR/agent.py"

echo
echo "Installation completed successfully."
echo "Agent location: $INSTALL_DIR/agent.py"
printf 'Python version: '
python3 --version

echo
echo "To check the agent, run:"
printf 'python3 "%s/agent.py" status\n' "$INSTALL_DIR"

echo
echo "Remote access is not enabled."
echo "No background service was started."
