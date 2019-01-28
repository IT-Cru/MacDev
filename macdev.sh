#!/bin/bash

# Define directories.
dirCommandLineTools="/Library/Developer/CommandLineTools"

# Define binaries.
binHomebrew="/usr/local/bin/brew"

# Define apps.
appDocker="/Applications/Docker.app"
appFirefox="/Applications/Firefox.app"
appGoogleChrome="/Applications/Google Chrome.app"
appiTerm="/Applications/iTerm.app"
appPhpStorm="/Applications/PhpStorm.app"
appSlack="/Applications/Slack.app"
appSpotify="/Applications/Spotify.app"

# Define tools.
toolComposer="/usr/local/opt/composer"
toolDDev="/usr/local/opt/ddev"
toolGitFlow="/usr/local/opt/git-flow-avh"
toolPHP="/usr/local/opt/php"
toolVim="/usr/local/opt/vim"

function checkRequirements() {

# Install XCode CommandLineTools.
if [ ! -d "${dirCommandLineTools}" ]
then
    echo -e "Install CommandLineTools\n"
    xcode-select --install
fi

# Install or update Homebrew.
if [ ! -f "${binHomebrew}" ]
then
    echo -e "Install Homebrew\n"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo -e "Add caskroom/cask repository"
    ${binHomebrew} tap caskroom/cask
    echo -e "Add drud/ddev repository"
    ${binHomebrew} tap drud/ddev
elif [ -f "${binHomebrew}" ]
then
    echo -e "Update Homebrew\n"
    ${binHomebrew} tap caskroom/cask
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
    ${binHomebrew} cask install $3
elif [ -d "$1" ]
then
    echo -e "$2: already installed"
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

checkRequirements

checkTool "${toolPHP}" "PHP" "php"
checkTool "${toolComposer}" "Composer" "composer"
checkTool "${toolGitFlow}" "GitFlow" "git-flow-avh"
checkTool "${toolVim}" "Vim" "vim"

# Install terminal related stuff.
checkApp "${appiTerm}" "iTerm" "iterm2"

# Install browsers.
checkApp "${appFirefox}" "Firefox" "firefox"
checkApp "${appGoogleChrome}" "Google Chrome" "google-chrome"

# Install docker.
checkApp "${appDocker}" "Docker" "docker"
checkTool "${toolDDev}" "DDev" "ddev"

# Install IDE.
checkApp "${appPhpStorm}" "PhpStorm" "phpstorm"

# Install working helpers.
checkApp "${appSpotify}" "Spotify" "spotify"
checkApp "${appSlack}" "Slack" "slack"

# Upgrade installed stuff.
${binHomebrew} upgrade

# Cleanup Homebrew.
${binHomebrew} cleanup
