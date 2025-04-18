#!/bin/bash
# log.sh
# Simple logger
# Usage: log <level> <message>

RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
NC=$(tput sgr0)

log() {
  local level="$1"
  local message="$2"

  case "$level" in
  error)
    printf "%sERROR%s %s\n" "${RED}" "${NC}" "$message" >&2
    ;;
  info)
    printf "%sINFO%s %s\n" "${BLUE}" "${NC}" "$message"
    ;;
  *)
    printf "LOG %s\n" "$message"
    ;;
  esac
}
