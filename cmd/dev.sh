#!/bin/bash

# Project root directory
PROJECT_ROOT_DIR=$(pwd)

# Required GCC major version
REQUIRED_GCC_MAJOR_VERSION="13"

# Variable to store the newest error
NEWEST_ERROR=""
# Variables to store process IDs
C_PID=""

# Function to log errors
log_error() {
  local error_message="$1"
  NEWEST_ERROR="$error_message"
}

# Function to kill all background processes
cleanup() {
  echo "[svr] Cleaning up background processes..."

  # Kill C process if it is running
  if [[ -n "$C_PID" && -e /proc/$C_PID ]]; then
    kill -9 "$C_PID" && echo "[svr] Killed C process (PID: $C_PID)"
  else
    echo "[svr] C process PID: $C_PID has ended"
  fi

  # Kill any remaining background processes started by the script
  jobs -p | xargs -r kill

  # Reset terminal and clear screen
  reset
  clear

  if [[ -n "$NEWEST_ERROR" ]]; then
    echo "[err] $NEWEST_ERROR"
  fi
}

# Set the trap to call the cleanup function on script exit
trap cleanup EXIT

# Check if GCC is installed and running the required version
GCC_VERSION=$(gcc -dumpversion | cut -f1 -d.)
if [ "$GCC_VERSION" -ne "$REQUIRED_GCC_MAJOR_VERSION" ]; then
  log_error "GCC version $REQUIRED_GCC_MAJOR_VERSION is required, but version $GCC_VERSION is installed."
  exit 1
fi

echo "[svr] Using GCC version $GCC_VERSION"

# start C nodemon dev server
yarn mon &
MON_PID=$!
echo "[svr] Yarn mon process started with PID: $MON_PID"

wait "$MON_PID"
