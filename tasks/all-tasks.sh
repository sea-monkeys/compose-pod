#!/bin/bash
# --------------------------------------
# All setup tasks
# --------------------------------------
set -e  # Exit immediately if any script returns a non-zero exit code

echo "⏳ Running git configuration..."
/home/tasks/git-configuration.sh

echo "⏳ Setting up Oh My Bash..."
/home/tasks/oh-my-bash.sh

echo "⏳Installing extensions..."
/home/tasks/extensions.sh

echo "🎉 All setup scripts completed successfully!"

# Execute the original CMD if any was provided
exec "$@"