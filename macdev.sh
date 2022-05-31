#!/bin/bash

# Define directories.
dirCommandLineTools="/Library/Developer/CommandLineTools"

# Define binaries.
binHomebrew="/usr/local/bin/brew"

# Define apps.
app1Password="/Applications/1Password 7.app"
appDocker="/Applications/Docker.app"
appFirefox="/Applications/Firefox.app"
appGoogleChrome="/Applications/Google Chrome.app"
appiTerm="/Applications/iTerm.app"
appLens="/Applications/Lens.app"
appPhpStorm="/Applications/PhpStorm.app"
appPostman="/Applications/Postman.app"
appSlack="/Applications/Slack.app"
appSpotify="/Applications/Spotify.app"

# Define tools.
toolAWSIAM="/usr/local/opt/aws-iam-authenticator"
toolDDev="/usr/local/opt/ddev"
toolRename="/usr/local/opt/rename"
toolVim="/usr/local/opt/vim"
toolWget="/usr/local/opt/wget"

function checkRequirements() {

# Install XCode CommandLineTools.
if xcode-select --install 2>&1 | grep installed;
then
  echo "XCode CommandLineTools already installed."
else
  echo "XCode CommandLineTools not installed yet."
  echo "Installing XCode CommandLineTools..."
fi

# Install or update Homebrew.
if [ ! -f "${binHomebrew}" ]
then
    echo -e "Install Homebrew\n"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo -e "Add drud/ddev repository"
    ${binHomebrew} tap drud/ddev
elif [ -f "${binHomebrew}" ]
then
    echo -e "Update Homebrew\n"
    ${binHomebrew} tap drud/ddev
    ${binHomebrew} update
else
    echo -e "ERROR: Homebrew can't be installed or updated"
    exit 1
fi
}

function checkApp() {
if [ ! -d "$1" ]
then
    echo -e "Install $2\n"
    ${binHomebrew} install --cask $3
elif [ -d "$1" ]
then
    echo -e "$2: already installed"
    ${binHomebrew} upgrade --cask $3
fi
}

function checkTool() {
    if [ ! -e "$1" ]
    then
        echo -e "Install $2\n"
        ${binHomebrew} install $3
    elif [ -d "$1" ]
    then
        echo -e "$2: already installed"
    fi
}

# Run check requirements for MacDev script.
checkRequirements

# Install some helper tools.
checkTool "${toolRename}" "rename" "rename"
checkTool "${toolVim}" "Vim" "vim"
checkTool "${toolWget}" "wget" "wget"

# Install terminal related stuff.
checkApp "${appiTerm}" "iTerm" "iterm2"

# Install browsers.
checkApp "${appFirefox}" "Firefox" "firefox"
checkApp "${appGoogleChrome}" "Google Chrome" "google-chrome"

# Install docker.
checkTool "${toolAWSIAM}" "AWS IAM" "aws-iam-authenticator"
checkApp "${appDocker}" "Docker" "docker"
checkTool "${toolDDev}" "DDev" "ddev"
checkApp "${appLens}" "Lens" "lens"

# Install IDE.
checkApp "${appPhpStorm}" "PhpStorm" "phpstorm"

# Install working helpers.
checkApp "${app1Password}" "1Password" "1password"
checkApp "${appPostman}" "Postman" "postman"
checkApp "${appSpotify}" "Spotify" "spotify"
checkApp "${appSlack}" "Slack" "slack"

# Upgrade installed stuff.
${binHomebrew} upgrade

# Cleanup Homebrew.
${binHomebrew} cleanup
