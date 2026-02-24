#!/usr/bin/env bash

# 1. Get current kitty state and use jq to filter os window by name
DATA=$(kitty @ ls | jq)

# 2. Use fzf to select one of the results from the active sessions

# 3. Switch the to selected session or do nothing if non where selected

