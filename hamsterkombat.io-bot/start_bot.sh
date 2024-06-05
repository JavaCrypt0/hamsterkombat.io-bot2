#!/bin/bash

# Function to print colored messages
colorEcho() {
    case $1 in
        "red")
            echo "\033[0;31m$2\033[0m"
            ;;
        "green")
            echo "\033[0;32m$2\033[0m"
            ;;
        "yellow")
            echo "\033[0;33m$2\033[0m"
            ;;
        "white")
            echo "\033[0;37m$2\033[0m"
            ;;
    esac
}

# Check for Node.js installation
if ! command -v node &> /dev/null
then
    colorEcho yellow "Node.js is not installed. Starting installation..."

    # Install Node.js using Homebrew
    if ! command -v brew &> /dev/null
    then
        colorEcho yellow "Homebrew is not installed. Installing Homebrew first..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    brew install node

    # Check installation success
    if ! command -v node &> /dev/null
    then
        colorEcho red "Node.js installation failed. Please install it manually."
        exit 1
    fi
    colorEcho green "Node.js has been successfully installed."
else
    colorEcho green "Node.js is already installed."
fi

# Install npm dependencies
colorEcho white "Installing npm dependencies..."
npm install

# Run bot.js
colorEcho white "Running bot.js..."
node bot.js
