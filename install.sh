#!/usr/bin/env bash
set -euo pipefail

REPO_LIST="${1:-repo-packages.txt}"
AUR_LIST="${2:-aur-packages.txt}"

# Check lists exist
if [[ ! -f $REPO_LIST && ! -f $AUR_LIST ]]; then
  echo "Provide at least one list: $REPO_LIST or $AUR_LIST"
  exit 1
fi

# Ensure pacman DB is available (assumes running on Arch)
echo "Updating pacman DB..."
sudo pacman -Sy

# Install repo packages
if [[ -f $REPO_LIST ]]; then
  echo "Installing repo packages from $REPO_LIST..."
  sudo pacman -S --needed - < "$REPO_LIST"
fi

# Ensure yay exists; if not, build and install it
if ! command -v yay >/dev/null 2>&1; then
  echo "yay not found — installing yay..."
  sudo pacman -S --needed --noconfirm base-devel git
  tmpdir=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
  pushd "$tmpdir/yay" >/dev/null
  makepkg -si --noconfirm
  popd >/dev/null
  rm -rf "$tmpdir"
fi

# Install AUR packages with yay
if [[ -f $AUR_LIST ]]; then
  echo "Installing AUR packages from $AUR_LIST..."
  yay -S --needed - < "$AUR_LIST"
fi

echo "Done."

