#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./raster_2color_to_svg.sh input.png output.svg
#
# Output:
#   output.svg contains two vector layers:
#     - white fill (#ffffff)
#     - red fill   (#d00000)
#   No black background is included.

IN="${1:?missing input.png}"
OUT="${2:-output.svg}"

RED_HEX="#d00000"   # tweak if you want a different red
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# Get raster dimensions for SVG viewBox
W="$(magick identify -format "%w" "$IN")"
H="$(magick identify -format "%h" "$IN")"

# Build a 3-color palette: black, white, red
magick -size 1x1 xc:black \
       -size 1x1 xc:white \
       -size 1x1 "xc:${RED_HEX}" +append "$TMP/palette.png"

# 1) Remap image to EXACTLY those 3 colors (removes near-colors / anti-alias noise)
magick "$IN" \
  -alpha off -colorspace sRGB \
  -dither None -remap "$TMP/palette.png" \
  "$TMP/remap.png"

# 2) Create binary masks for each ink
# White mask: white -> white, everything else -> black
magick "$TMP/remap.png" -alpha off \
  -fill white -opaque white \
  -fill black +opaque white \
  -threshold 50% -type bilevel \
  "$TMP/white.pbm"

# Red mask: red -> white, everything else -> black
magick "$TMP/remap.png" -alpha off \
  -fill white -opaque "${RED_HEX}" \
  -fill black +opaque "${RED_HEX}" \
  -threshold 50% -type bilevel \
  "$TMP/red.pbm"

# 3) Trace each mask with potrace
# --turdsize removes tiny specks; lower it if you want MORE texture kept.
potrace "$TMP/white.pbm" -s \
  --fillcolor="#ffffff" --opttolerance 0.2 --alphamax 1.0 --turdsize 2 \
  -o "$TMP/white.svg"

potrace "$TMP/red.pbm" -s \
  --fillcolor="${RED_HEX}" --opttolerance 0.2 --alphamax 1.0 --turdsize 2 \
  -o "$TMP/red.svg"

# 4) Merge the <path> elements into one print-ready SVG
python3 - <<PY
import re, pathlib

w = pathlib.Path("$TMP/white.svg").read_text(encoding="utf-8", errors="ignore")
r = pathlib.Path("$TMP/red.svg").read_text(encoding="utf-8", errors="ignore")

# Extract all <path .../> elements (potrace outputs fill color per path)
paths_w = re.findall(r"<path\\b[^>]*/>", w)
paths_r = re.findall(r"<path\\b[^>]*/>", r)

svg = f'''<svg xmlns="http://www.w3.org/2000/svg" width="{int($W)}" height="{int($H)}" viewBox="0 0 {int($W)} {int($H)}">
  <!-- White layer -->
  <g id="white">
    {"\\n    ".join(paths_w)}
  </g>

  <!-- Red layer -->
  <g id="red">
    {"\\n    ".join(paths_r)}
  </g>
</svg>
'''
pathlib.Path("$OUT").write_text(svg, encoding="utf-8")
print("Wrote:", "$OUT")
PY
