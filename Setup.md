* Install Homebrew, and `brew tap caskroom/cask`
* Log into MAS and install MAS things
* Install `brew` / `brew cask` things
* Generate SSH keys, add to GitHub
* clone dotfiles
* `./systemDefaults.sh`
* Install oh-my-zsh (This sets zsh as my custom shell. `symlinks.sh` adds my custom zshrc and my custom oh-my-zsh plugins)
* `./symlinks.sh`
* install RVM and `gem install xcode-install` and 

* Bashmarks (wait til I have zsh config)
* Configure visor

**Install Solarized for iTerm** 

## Set up Solarized
There's a `Solarized` folder that contains various plugins with instructions.

I typically set everything to Solarized Dark, except Terminal.app gets Solarized Light so I can tell at a glance if I'm running it instead of iTerm2.

VS Code already has Solarized installed.

## Use Fira Code as a code font

* Open Fira Code -> ttf -> add all fonts to font book

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
* Set default browser to DuckDuckGo

## Keyboard Settings
* Caps lock as ctrl
* Disable autocorrect (spelling, capitalization, two spaces -> period)
* Shortcuts -> Full Keyboard Access -> Tab focus across all controls

## Trackpad Settings
* Disable data detectors
* Disable force click
* Disable mission control swipe

## Siri Settings
* Move from Cmd+Space to Option+Space

## Dock Settings
* Left side
* Hidden by defualt

## VS Code
* Config files covered by symlink.sh

## Keybase

`keybase install`, use an existing device to provision

## OmniFocus
* Set keyboard shortcut to Cmd+Shift+O
* Log in with OmniSyncServer
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