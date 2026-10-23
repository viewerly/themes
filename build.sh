#!/usr/bin/env bash
# Packs every theme folder (one with a viewerly-plugin.toml) into dist/<id>-<version>.vplugin:
# a zip with the manifest at its root, which is what Viewerly installs.
#
#   ./build.sh            every theme
#   ./build.sh nord one   just these
set -euo pipefail
root="$(cd "$(dirname "$0")" && pwd)"
out="$root/dist"
mkdir -p "$out"

# A top-level `key = "value"` from a manifest.
field() { sed -n "s/^$1 = \"\(.*\)\"$/\1/p" "$2" | head -n 1; }

if [ $# -gt 0 ]; then folders=("$@"); else folders=(); for f in "$root"/*/viewerly-plugin.toml; do folders+=("$(basename "$(dirname "$f")")"); done; fi

for folder in "${folders[@]}"; do
  manifest="$root/$folder/viewerly-plugin.toml"
  [ -f "$manifest" ] || { echo "$folder has no viewerly-plugin.toml" >&2; exit 1; }
  id="$(field id "$manifest")"
  version="$(field version "$manifest")"
  file="$out/$id-$version.vplugin"
  rm -f "$file"
  # -X leaves out extended attributes and -D directory entries, so the zip holds only the files.
  (cd "$root/$folder" && zip -qrXD "$file" . -x '.*' -x '*/.*')
  echo "$file"
done
