#!/usr/bin/env bash

set -euo pipefail

echo "🛠️  Starting C development environment setup..."

# Update and upgrade package lists
echo "🔄 Updating system packages..."
sudo apt update -y &> /dev/null
echo "🔄 Upgrading system packages..."
sudo apt upgrade -y &> /dev/null

# Base dev tools (only install if missing)
DEV_TOOLS=(
  build-essential
  make
  wget
  curl
  git
  lsb-release
  gnupg
  software-properties-common
  pkg-config 
  python3
  python3-pip
  pipx
)

echo "📦 Checking and installing base development tools..."
for pkg in "${DEV_TOOLS[@]}"; do
  if ! dpkg -s "$pkg" &>/dev/null; then
    echo "⬇️  Installing $pkg..."
    sudo apt install -y "$pkg"
  else
    echo "✅ $pkg is already installed."
  fi
done

# Ensure pipx is initialized
echo "🔧 Ensuring pipx is ready..."
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo "🔧 Adding ~/.local/bin to PATH..."
    python3 -m pipx ensurepath
    export PATH="$HOME/.local/bin:$PATH"
else
    echo "✅ ~/.local/bin already in PATH."
fi

# Clangd-20 setup
if ! command -v clangd-20 &>/dev/null; then
    echo "⬇️  Installing Clangd 20 from LLVM APT..."
    curl -fsSL https://apt.llvm.org/llvm.sh | sudo bash -s -- 20
    sudo apt install -y clangd-20
else
    echo "✅ Clangd 20 already installed."
fi

# Set clangd-20 as default
if ! command -v clangd &>/dev/null || ! clangd --version | grep -q "clangd version 20"; then
    echo "🔧 Setting clangd-20 as default..."
    sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-20 100
else
    echo "✅ clangd is already set to version 20."
fi

# Bear (compile_commands.json generator)
if ! command -v bear &>/dev/null; then
    echo "⬇️  Installing Bear..."
    sudo apt install -y bear
else
    echo "✅ Bear already installed."
fi

# Conan (via pipx)
if ! command -v conan &>/dev/null; then
    echo "⬇️  Installing Conan via pipx..."
    pipx install conan
else
    echo "✅ Conan already installed."
fi

echo "🎉 Setup complete!"
