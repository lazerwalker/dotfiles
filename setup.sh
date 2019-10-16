echo "Creating an SSH key for you..."
ssh-keygen -t rsa

echo "Please add this public key to Github \n"
echo "https://github.com/account/ssh \n"
read -p "Press [Enter] key after this..."

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing things via brew"
brew_apps=(
  git 
  hub 
  gcc 
  gpg2 
  macvim 
  mas
)
brew cask install ${brew_apps[@]}

echo "Installing RVM and the latest Ruby..."
gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm
echo "Installing xcselect and latest Xcode CLI tools"
gem install xcode-install
xcversion install-cli-tools

echo "In another CLI tab, run 'xcversion list --all' and 'xcversion install [latest version]''"
read -p "Press [Enter] when ready..."

echo "Symlinking gitconfig"
ln -s "$dir/gitconfig" ~/.gitconfig

echo "Cleaning up brew"
brew cleanup

echo "Installing homebrew cask"
brew tap homebrew/cask-fonts

#Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH..."
curl -L http://install.ohmyz.sh | sh

echo "Symlinking zshrc and oh-my-zsh config"
ln -s "$dir/zshrc" ~/.zshrc
ln -s "$dir/ohmyzsh-custom" ~/.oh-my-zsh/custom

echo "Setting ZSH as shell..."
chsh -s /bin/zsh

# Apps
apps=(
  1password 
  alfred 
  android-studio 
  backblaze 
  bartender 
  bettertouchtool 
  caffeine 
  calibre 
  encryptme 
  daisydisk 
  dash 
  deckset
  dropbox 
  dropshare 
  fantastical 
  firefox
  flux 
  font-fira-code
  keybase 
  google-chrome 
  iterm2 
  licecap
  little-snitch 
  macdown 
  ngrok 
  nvalt 
  omnifocus 
  1password
  slack 
  soundsource
  spotify
  steam
  sync 
  unity-hub
  vlc 
  visual-studio-code
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

brew cask alfred link

brew cask cleanup
brew cleanup

echo "Installing QuickLook plugins..."
quicklook_plugins=(
  qlcolorcode 
  qlstephen 
  qlmarkdown
  quicklook-json
  qlimagesize
  webpquicklook
  qlvideo
)
brew cask install ${quicklook_plugins[@]}

echo "Installing the mas tool and some MAS apps"
mas_apps=(
  451640037 # Classic Color Meter
  418138339 # HTTP Client
  928871589 # Noizio
  1303222628 # Paprika
  964792805 # ??? Currently unavailable
  525180431 # Pixen
  413965349 # Soulver
  425424353 # The Unarchiver
  1384080005 # Tweetbot
  985367838 # Outlook
)
mas install  ${mas_apps[@]}

echo "Set up Dropbox and Sync!"
read -p "Press enter when done."


# Set hostname
echo "what should the hostname be?"
read hostname
sudo scutil --set ComputerName $hostname && \
sudo scutil --set HostName $hostname && \
sudo scutil --set LocalHostName $hostname && \
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $hostname

echo "setting some system preferences..."

#"Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

#"Disabling OS X Gate Keeper"
#"(You'll be able to install any app you want from here on, not just Mac App Store apps)"
sudo spctl --master-disable
sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no
defaults write com.apple.LaunchServices LSQuarantine -bool false

#"Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

#"Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

#"Saving to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

#"Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

#"Disable smart quotes and smart dashes as they are annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

#"Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

#"Disabling press-and-hold for keys in favor of a key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

#"Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

#"Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

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

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Don't create .DS_Store on network or USB drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable keyboard autocorrect
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Dock settings
defaults write com.apple.dock static-only -bool true
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock 'orientation' -string 'left'
defaults write com.apple.dock autohide -bool true

killall Dock

#"Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

#"Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#"Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

#"Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

#"Preventing Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

#"Disable the sudden motion sensor as its not useful for SSDs"
sudo pmset -a sms 0

#"Speeding up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400

#"Setting screenshots location to ~/Desktop"
defaults write com.apple.screencapture location ~/Sync/Screenshots

#"Setting screenshot format to PNG"
defaults write com.apple.screencapture type -string "png"

killall SystemUIServer

#"Hiding Safari's bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false

#"Hiding Safari's sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

#"Disabling Safari's thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

#"Enabling Safari's debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

#"Making Safari's search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

#"Removing useless icons from Safari's bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

#"Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

#"Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

#"Use `~/Downloads/Incomplete` to store incomplete downloads"
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Incomplete"

killall Finder

echo "Symlinking VSCode settings..."
ln -s "$dir/vscode/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json
ln -s "$dir/vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json


echo "Setting up Keybase..."
keybase install

echo "Installed, time to log in and add your device..."
keybase login

echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
# TODO: Manually install latest node?

# TODO: bashmarks? https://github.com/huyng/bashmarks

echo "----------"
echo "Go to keyboard settings and map caps lock to ctrl"
echo "Then disable autocorrect (spelling, capitalization, 2 spaces -> period)"
read -p "Press [Enter] when done..."

echo "----------"
echo "Safari Setup: Manually install extensions for 1password, Ghostery, and AdBlock"
read -p "Press [Enter] when done..."

echo "----------"
echo "Install Solarized into iTerm and Xcode"
read -p "Press [Enter] when done..."

echo "----------"
echo "Set up your personal mail by going to Fastmail and generating a new app password. It'll give you a one-click config download link."
read -p "Press [Enter] when done..."

echo "----------"
echo "Set up GCal with an app password. Add it both to the system and to Fantastical"
read -p "Press [Enter] when done..."

echo "----------"
echo "Set up Alfred:"
echo "1. Remove system Spotlight shortcut (Keyboard -> Shortcuts -> Spotlight)"
echo "2. Confirm Alfred shortcut is Cmd+Space"
echo "3. Activate PowerPack (license key in 1password)"
read -p "Press [Enter] when done..."

echo "----------"
echo "VS Code:"
echo "TODO for Em: confirm your symlink setup includes extensions"
read -p "Press [Enter] when done..."

echo "----------"
echo "Set up BetterTouchTool:"
echo "1. License is in 1p"
echo "2. 3-finger swipe up -> Cmd+T"
echo "3. 3-finger swipe down -> Cmd+W"
echo "4. 3-finger tap -> middle click"
echo "5. Cmd + Alt + Ctrl + Enter -> Maximize current window"
echo "6. Cmd + Alt + Ctrl + Left/Right -> Maximize to left/right side"
echo "7. Set up window snapping"
read -p "Press [Enter] when done..."

echo "----------"
echo "Fantastical:"
echo "Set keyboard shortcut to Cmd+Shift+C"
echo "License is in 1p"
read -p "Press [Enter] when done..."

echo "----------"
echo "Set default Safari search engine to DuckDuckGo:"
echo "Open new browser tab, click magnifying glass in search/URL bar, click DDG"
read -p "Press [Enter] when done..."

echo "----------"
echo "Trackpad settings: disable data detectors, force click, and mission control swipe."
echo "Enable tap to click"
read -p "Press [Enter] when done..."

echo "----------"
echo "Siri settings: move from Cmd+Space to Option+Space"
read -p "Press [Enter] when done..."

echo "----------"
echo "Set up OmniFocus"
echo "OmniSyncServer and license key in 1p"
echo "Keyboard shortcut = Cmd+Shift+O"
read -p "Press [Enter] when done..."

echo "----------"
echo "Set iTerm font to Fira Code"
echo "Open Solarized iterm .itermcolors file, then set Preferences -> Profiles -> Colors -> Load presets"
read -p "Press [Enter] when done..."

echo "----------"
echo "Configure Dropshare"
echo "Settings -> General -> [Start at Login, Install CLI Tools]"
echo "Connection: bucket name + domain alias are both 'uploads.lazerwalker.com' (get keys from AWS)"
echo "Uploads: https://dropshare.zendesk.com/hc/en-us/articles/201268771-How-to-set-up-a-custom-URL-shortener"
echo "Screenshots -> Legacy Mode -> Enable"
echo "Sync -> Use it"
read -p "Press [Enter] when done..."

echo "----------"
echo "Set up Bartender, using common sense"
read -p "Press [Enter] when done..."

echo "----------"
echo "TODO: Figure out how to install and set up Karabiner how I like"
echo "Complex modifications: Change caps_lock to control if pressed with other keys, escape if pressed laone"
echo "Alternatively: See if BetterTouchTool can do this"
read -p "Press [Enter] when done..."

echo "...and you're done!"

