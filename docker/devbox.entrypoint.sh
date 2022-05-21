#!/usr/bin/env bash
set -euo pipefail
# If no arguments, drop into a bash shell.
# If arguments are passed and the first argument is "test", run the test suite,
# otherwise execute what was passed.
# If arguments are passed and the first argument is "integration", run the integration test suite.
if [[ $# == 0 ]]; then
  /bin/bash
else
  exec "$@"
fi