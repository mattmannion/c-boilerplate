#!/usr/bin/env bash

set -euo pipefail

# Check for sudo
if [[ "$EUID" -ne 0 ]]; then
    echo "Please run this script as root or with sudo:"
    echo "    sudo $0"
    exit 1
fi

# Base dev tools
echo "Installing base development tools..."
apt update
apt install -y build-essential make wget curl git lsb-release gnupg software-properties-common

# Add LLVM APT repo and install clangd-20
echo "Adding LLVM APT repo and installing Clang/Clangd 20..."
curl -fsSL https://apt.llvm.org/llvm.sh | bash -s -- 20
apt install -y clangd-20

# Set clangd-20 as default
echo "Configuring clangd alternatives..."
update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-20 100

# Install bear for compile_commands.json generation
echo "Installing Bear..."
apt install -y bear

# Optional: Install LLDB, LLD, clang-format if you use them
# apt install -y lldb-20 lld-20 clang-format-20

# Success message
echo "✅ All tools installed. You can now use clangd + bear + make for development."
