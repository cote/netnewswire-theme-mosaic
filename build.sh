#!/bin/bash
# Package each src/<Theme>/ into build/<Theme>.nnwtheme/.
# Pass --install to also copy into NetNewsWire's macOS theme dir.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC="$ROOT/src"
BUILD="$ROOT/build"
INSTALL_BASE="$HOME/Library/Containers/com.ranchero.NetNewsWire-Evergreen/Data/Library/Application Support/NetNewsWire/Themes"

INSTALL=0
if [ "${1:-}" = "--install" ]; then
	INSTALL=1
fi

shopt -s nullglob
themes=("$SRC"/*/)
if [ ${#themes[@]} -eq 0 ]; then
	echo "no themes found under $SRC" >&2
	exit 1
fi

for dir in "${themes[@]}"; do
	name="$(basename "$dir")"
	out="$BUILD/$name.nnwtheme"

	for f in Info.plist stylesheet.css template.html; do
		if [ ! -f "$dir/$f" ]; then
			echo "missing: $dir$f" >&2
			exit 1
		fi
	done

	rm -rf "$out"
	mkdir -p "$out"
	cp "$dir/Info.plist" "$out/Info.plist"
	cp "$dir/stylesheet.css" "$out/stylesheet.css"
	cp "$dir/template.html" "$out/template.html"
	echo "built $out"

	if [ "$INSTALL" -eq 1 ]; then
		install_dir="$INSTALL_BASE/$name.nnwtheme"
		mkdir -p "$INSTALL_BASE"
		rm -rf "$install_dir"
		cp -R "$out" "$install_dir"
		echo "installed $install_dir"
	fi
done
