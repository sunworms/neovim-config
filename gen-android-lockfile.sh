#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${1:-$(pwd)}"
ANDROID_DIR="$REPO_ROOT/android"
ANDROID_INIT="$ANDROID_DIR/init.lua"

if [[ ! -f "$ANDROID_INIT" ]]; then
	echo "error: $ANDROID_INIT not found (pass the repo root as an argument if you're running this from elsewhere)" >&2
	exit 1
fi

if ! command -v nix >/dev/null 2>&1; then
	echo "error: nix not found on PATH" >&2
	exit 1
fi

PACK_BLOCK="$(awk '/vim\.pack\.add\(\{/,/^\}\)/' "$ANDROID_INIT")"

if [[ -z "$PACK_BLOCK" ]]; then
	echo "error: couldn't find a vim.pack.add({...}) block in $ANDROID_INIT" >&2
	exit 1
fi

SCRATCH="$(mktemp -d)"
trap 'rm -rf "$SCRATCH"' EXIT

mkdir -p "$SCRATCH/nvim"
printf '%s\n' "$PACK_BLOCK" > "$SCRATCH/nvim/init.lua"

echo "Resolving plugin commit(s) with a scratch Neovim..."
XDG_CONFIG_HOME="$SCRATCH" XDG_DATA_HOME="$SCRATCH/data" XDG_STATE_HOME="$SCRATCH/state" \
	nix run -f '<nixpkgs>' neovim -- --headless -u "$SCRATCH/nvim/init.lua" -c "quit"

LOCKFILE="$SCRATCH/nvim/nvim-pack-lock.json"

if [[ ! -f "$LOCKFILE" ]]; then
	echo "error: lockfile wasn't generated - check the Neovim output above" >&2
	exit 1
fi

cp "$LOCKFILE" "$ANDROID_DIR/nvim-pack-lock.json"
echo "wrote $ANDROID_DIR/nvim-pack-lock.json:"
cat "$ANDROID_DIR/nvim-pack-lock.json"
