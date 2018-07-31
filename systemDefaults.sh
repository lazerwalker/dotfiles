#!/bin/bash

# Show all file extensions
defaults write -g AppleShowAllExtensions -bool true

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles true

# Show full path in finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Unhide user library
chflags nohidden ~/Library

# Show 'quit finder' option
defaults write com.apple.finder QuitMenuItem -bool true && \
killall Finder

# Expand save panel by defaults
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true && \
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Don't create .DS_Store on network or USB drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable keyboard autocorrect
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Set hostname
sudo scutil --set ComputerName "calculon" && \
sudo scutil --set HostName "calculon" && \
sudo scutil --set LocalHostName "calculon" && \
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "calculon"

# Dock settings
defaults write com.apple.dock static-only -bool true
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock 'orientation' -string 'left'
defaults write com.apple.dock autohide -bool true

killall Dock
