#!/usr/bin/env bash

set -e

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

nvim --startuptime "$tmp" +qa

echo
echo "Neovim Config Startup Profile"
echo "============================"
echo
printf "%-12s %s\n" "TIME" "FILE"
printf "%-12s %s\n" "----" "----"

grep "$HOME/.config/nvim" "$tmp" |
awk '{ 
  time = sprintf("%.3f ms", $2)
  printf "%-12s %s\n", time, substr($0, index($0, $5)) 
}' |
sort -k1,1nr
