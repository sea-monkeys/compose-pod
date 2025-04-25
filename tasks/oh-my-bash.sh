#!/bin/bash
# --------------------------------------
# Install Oh My Bash
# --------------------------------------
if [ -d "$HOME/.oh-my-bash" ]; then
    echo "🙂 Oh My Bash is already installed"
else
    echo "🤗 Installing Oh My Bash"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended
fi
