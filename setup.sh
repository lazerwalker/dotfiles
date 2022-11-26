DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Apple should have already prompted you to install the Xcode CLI tools."
echo "If that didn't happen, go download those now!"
read -p "Then press [Enter] to continue."
echo ""

if [ -f "/home/lazerwalker/id_rsa.pub" ]; then
  echo "Creating an SSH key for you..."
  ssh-keygen -t rsa
  echo "Add it to the SSH agent!"
  echo "(https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)"
  read -p "Press [Enter] when done..."
  echo ""
else
  echo "You already have a public key, continuing using existing ~/.ssh/id_rsa.pub"
  echo ""
fi


# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"

fi


# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing things via brew"
brew_apps=(
  git
  git-lfs
  hub
  gcc 
  gpg2 
  macvim 
  mas
  robotsandpencils/made/xcodes
)
brew install ${brew_apps[@]}

echo "Setting up git-lfs"
git lfs install
git lfs install --system

echo "Installing RVM and the latest Ruby..."
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm

xcodes install --latest

read -p "Not sure how install works. Press [Enter] when that's running..."

echo "Symlinking gitconfig from $DIR/gitconfig"
ln -s "$DIR/gitconfig" ~/.gitconfig

echo "Cleaning up brew"
brew cleanup

echo "Installing homebrew cask"
brew tap homebrew/cask-fonts

echo "Setting ZSH as shell..."
chsh -s /bin/zsh

Echo "Installing starship..."
curl -sS https://starship.rs/install.sh | sh

Echo "Setting up Starship..."
eval "$(starship init zsh)"

#Install Zsh & Oh My Zsh
#echo "Installing Oh My ZSH..."
#curl -L http://install.ohmyz.sh | sh
#
#echo "Symlinking zshrc and oh-my-zsh config"
#ln -s "$DIR/zshrc" ~/.zshrc
#ln -s "$DIR/ohmyzsh-custom" ~/.oh-my-zsh/custom
#

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
  discord
  dropshare 
  fantastical 
  firefox
  flux 
  font-fira-code
  font-Fira-Code-nerd-font
  google-chrome 
  iterm2 
  karabiner-elements
  licecap
  little-snitch 
  macdown 
  ngrok 
  nvalt 
  omnifocus 
  pdfpen
  slack 
  soundsource
  spotify
  standard-notes
  steam
  sync 
  unity-hub
  vlc 
  visual-studio-code
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps with Cask..."
brew install --appdir="/Applications" ${apps[@]} --cask

brew alfred link --cask

brew cleanup

echo "Installing the mas tool and some MAS apps"
echo "First, you must log into the Mac App Store app"
read -p "Press [Enter] when ready to continue..."

mas_apps=(
  451640037 # Classic Color Meter
  418138339 # HTTP Client
  928871589 # Noizio
  1303222628 # Paprika
  525180431 # Pixen
  413965349 # Soulver
  425424353 # The Unarchiver

  # Safari extension (might not work?)
  1436953057 # Ghostery Lite
  568494494
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

# Remove Mission Control entirely (the pref pane doesn't let you disable the 'drag a window to the top of the screen' interaction, 
# which conflicts with how I use BetterTouchTool)
defaults write com.apple.dock mcx-expose-disabled -bool TRUE && killall Dock

killall Finder

echo "Symlinking VSCode settings..."
ln -s "$dir/vscode/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json
ln -s "$dir/vscode/settings.json" ~/Library/Application\ Support/Code/User/settings.json

echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
# TODO: Manually install latest node?

# TODO: bashmarks? https://github.com/huyng/bashmarks

echo "----------"
echo "Go to keyboard settings and map caps lock to ctrl"
echo "Then disable autocorrect (spelling, capitalization, 2 spaces -> period)"
echo "Finally, remove the Spotlight Cmd+Space keyboard shortcut"
read -p "Press [Enter] when done..."

echo "----------"
echo "Set up 1password"
echo "(Use iCloud for sync)"
read -p "Press [Enter] when done..."


echo "----------"
echo "Set up Alfred:"
echo "1. Activate PowerPack (mega supporter license key in 1password)"
echo "2. Confirm Alfred shortcut is Cmd+Space"
echo "3. TODO: Do settings sync? Can they sync?"
read -p "Press [Enter] when done..."

echo "----------"
echo "Safari Setup: Manually enable 1password, Ghostery, and Pocket extensions. They should be installed already."
echo "Then set the default search engine to DuckDuckGo:"
echo "(Open a new browser tab, then click the magnifying glass in the search/URL bar)"
read -p "Press [Enter] when done..."

echo "----------"
echo "Install Solarized into Xcode (TODO: Document this!)"
read -p "Press [Enter] when done..."

echo "----------"
echo "Set up your personal mail by going to Fastmail and generating a new app password. It'll give you a one-click config download link."
read -p "Press [Enter] when done..."

echo "----------"
echo "VS Code:"
echo "TODO for Em: add steps to this file to install extensions via the CLI"
read -p "Press [Enter] when done..."

echo "----------"
echo "Set up BetterTouchTool:"
echo "TODO: Syncing is experimental. Hopefully it'll Just Work next time I need this?"
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
echo "The license is in 1p"
echo "Set keyboard shortcut to Cmd+Shift+C"
echo "Set up Google account"
read -p "Press [Enter] when done..."

echo "----------"
echo "Confirm that the Calendar app has set up with my GCal"
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
echo "Set up iTerm"
echo "Set Solarized Dark (Preferences -> Profiles -> Colors -> Presets)"
echo "Set Fira code font (Preferences -> Profiles -> Text -> Font. Select it, and also enable ligatures)"
read -p "Press [Enter] when done..."


echo "----------"
echo "Configure Dropshare"
echo "Settings -> General -> [Start at Login, Install CLI Tools]"
echo "Connection: there's a .dsconn file in the password manager"
echo "URL Shortener: in 'Uploads'. Bit.ly, domain is lzrwlkr.me, access token in password manager "
echo "Screenshots -> Legacy Mode -> Enable"
echo "Sync -> Use it"
read -p "Press [Enter] when done..."

echo "----------"
echo "Set up Bartender, using common sense"
read -p "Press [Enter] when done..."

echo "----------"
echo "Set up Backblaze. There's an installer app that Alfred may not pick up, it'll be in /opt/homebrew/Caskroom/backblaze/[some folders]"
read -p "Press [Enter] when done..."

echo "----------"
echo "TODO: Figure out how to install and set up Karabiner how I like"
echo "Complex modifications: Change caps_lock to control if pressed with other keys, escape if pressed laone"
echo "Alternatively: See if BetterTouchTool can do this"
read -p "Press [Enter] when done..."

echo "...and you're done!"

