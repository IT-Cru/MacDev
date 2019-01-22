#!/bin/bash

# Define directories.
dirCommandLineTools="/Library/Developer/CommandLineTools"

# Define binaries.
binHomebrew="/usr/local/bin/brew"

# Define apps.
appFirefox="/Applications/Firefox.app"
appGoogleChrome="/Applications/Google Chrome.app"
appiTerm="/Applications/iTerm.app"
appPhpStorm="/Applications/PhpStorm.app"
appSpotify="/Applications/Spotify.app"


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
elif [ -f "${binHomebrew}" ]
then
    echo -e "Update Homebrew\n"
    ${binHomebrew} update
else
    echo -e "ERROR: Homebrew can't be installed or updated"
    exit 1
fi


# Install iTerm and other shells.
if [ ! -d "${appiTerm}" ]
then
    echo -e "Install iTerm\n"
    brew cask install iterm2
fi


# Install browsers.
if [ ! -d "${appFirefox}" ]
then
    echo -e "Install firefox browser\n"
    brew cask install firefox
fi
if [ ! -d "${appGoogleChrome}" ]
then
    echo -e "Install google-chrome browser\n"
    brew cask install google-chrome
fi


# Install IDE.
if [ ! -d "${appPhpStorm}" ]
then
    echo -e "Install PhpStorm\n"
    brew cask install phpstorm
fi


# Install working helpers.
if [ ! -d "${appSpotify}" ]
then
    echo -e "Install Spotify\n"
    brew cask install spotify
fi


# Cleanup Homebrew.
${binHomebrew} cleanup
