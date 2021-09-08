#!/usr/bin/env bash

# Example usage: ./args-starter.sh --flag --param test arg1 arg2

set -Eeuo pipefail
set -x

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

parse_params() {
  # default values of variables set from params
  flag=0
  param=''

  while :; do
    case "${1-}" in
    -f | --flag) flag=1 ;;  # example flag
    -p | --param)           # example named parameter
      param="${2-}"
      shift
      ;;
    -?*) echo "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  args=("$@")
  return 0
}

parse_params "$@"

echo "flag: ${flag}"
echo "param: ${param-}"
echo "arguments: ${args[*]-}"