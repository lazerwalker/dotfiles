## Install the Installers

1. Install homebrew: https://brew.sh (it should be a shell one-liner)
2. Install Brew Cask: `brew tap caskroom/cask`
3. Install `brew` and `brew cask` things

## Install Software
1. Install Homebrew software (see SOFTWARE.md)
2. Install Brew Cask software (see SOFTWARE.md)
3. Install QuickLook plugins (see SOFTWARE.md)
4. Log into MAS and install MAS things (see SOFTWARE.md)

## Dev and pref setup
1. Generate SSH keys, add to GitHub
2. Clone this repo
3. Set up macOS prefs: `./systemDefaults.sh`
4. Install oh-my-zsh (This sets zsh as my custom shell. `symlinks.sh` adds my custom oh-my-zsh plugins)
5. Set up symlinks `./symlinks.sh`
6. Install RVM: http://rvm.io
7. Get the latest Ruby: `rvm list known` && `rvm install [VERSION]`
8. Install xcode-install: `gem install xcode-install`
9. Download the latest Xcode: `xcversion list --all` && `xcversion install [LATEST]`
10. Get nvm
11. Install Bashmarks: https://github.com/huyng/bashmarks

## Safari
* Install 1password extension
* Ghostery
* AdBlock

**Install Solarized for iTerm** 

## Set up Solarized
There's a `Solarized` folder that contains various plugins with instructions.

I typically set everything to Solarized Dark, except Terminal.app gets Solarized Light so I can tell at a glance if I'm running it instead of iTerm2.

VS Code already has Solarized installed.

## Use Fira Code as a code font
* Download la1test version from https://github.com/tonsky/FiraCode
* Open Fira Code -> ttf -> add all fonts to font book

# Mail / Calendar / Etc
* In my mail account settings, go to create a new app password. It'll have a one-click config download link.

## Alfred
* Keyboard -> Shortcuts -> Spotlight -> remove Cmd+Space
* Activate PowerPack (in 1p)
* TODO: Can I symlink in config?

## VS Code
* Config is handled by `symlinks.sh`

## BetterTouchTool
* License is in 1password
* 3-finger swipe up -> Cmd-T
* 3-finger swipe down -> Cmd-W
* 3-finger tap -> middle click
* Cmd+Alt+Ctrl+Enter: Maximize current window
* Cmd+Alt+Ctrl+Left: Maximize to left side
* Cmd+Alt+Ctrl+Right: Maximize to right side

## Fantastical
* Set shortcut to Cmd+Shift+C
* License is in 1password

## Safari
* Set default browser to DuckDuckGo: Open new browser tab, click magnifying glass in search/URL bar, click DDG

## Keyboard Settings
* Caps lock as ctrl
* Disable autocorrect (spelling, capitalization, two spaces -> period)
* Shortcuts -> Full Keyboard Access -> Tab focus across all controls

## Trackpad Settings
* Disable data detectors
* Disable force click
* Disable mission control swipe
* Enable tap to click

## Siri Settings
* Move from Cmd+Space to Option+Space

## Dock Settings
* Left side
* Hidden by defualt

## VS Code
* Config files covered by symlink.sh

## Keybase
* Install things: `keybase install`
* Provision the new device: `keybase login` and use another device to provision

## OmniFocus
* Log in with OmniSyncServer (info in 1password
* Set keyboard shortcut to Cmd+Shift+O
* License in 1p

## nvAlt
* Set keyboard shorcut to Cmd+Shift+N
* Log in with Simplenote

## iTerm
* Set font to Fira Code
* Open Solarized iterm folder, open .itermcolors files, set Preferences -> Profiles -> Colors -> Load Presets

## Dropshare
* Set screenshot folder: `defaults write com.apple.screencapture location ~/Sync/Screenshots; killall SystemUIServer`
* Settings
    * General
        * Start Dropshare at login
        * Install CLI Tools
    * Connection
        * Bucket name: uploads.lazerwalker.com
        * Keys: (Get from AWS)
        * Domain alias: uploads.lazerwalker.com
    * Uploads
        * Follow instructions to set up bit.ly URL shortener: https://dropshare.zendesk.com/hc/en-us/articles/201268771-How-to-set-up-a-custom-URL-shortener
    * Screenshots
        * Legacy Mode -> Enable Legacy Mode (system shortcut using folder)
    * Sync: Use it.
    

## Bartender
* Use common sense?

## Sync
* User/password in 1password
* Set folder to inside /Users/lazerwalker
