#!/bin/bash

# Quickshell Workspace Manager widget toggler

script_path=$(realpath "$(dirname "$0")")
widget="$script_path/WorkspaceManager.qml"
process="quickshell.*WorkspaceManager.qml"

if [[ ! -f "$widget" ]]; then
  echo "WorkspaceManager.qml not found at $widget"
  exit 1
fi

if pgrep -f "$process" >/dev/null; then
  pkill -f "$process"
else
  quickshell -p "$widget"
fi
