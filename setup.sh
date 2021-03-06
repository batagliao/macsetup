#!/bin/sh

function vscode(){
    CONTENTS="/Applications/Visual Studio Code.app/Contents"
    ELECTRON="$CONTENTS/MacOS/Electron"
    CLI="$CONTENTS/Resources/app/out/cli.js"
    ELECTRON_RUN_AS_NODE=1 "$ELECTRON" "$CLI" "$1"
    exit $?
}

# detect if homebrew is installed to install or update
if test ! $(which brew); then
  echo "Installing Xcode ..."
  xcode-select --install

  echo "Installing Homebrew ..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  # echo "Installing Cask"
  # brew tap homebrew/cask-cask
else
  echo "Updating Homebrew ..."
  brew update
  wait
  brew upgrade
  wait
fi

sudo xcodebuild -license
wait
brew doctor
wait

cd ~/
git clone https://github.com/batagliao/macsetup.git

brew install zsh zsh-completions
wait

#set zsh as shell
chsh -s $(which zsh)

# configure .dot files
cp ~/macsetup/dotfiles/.z* .

#install zprezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
wait

brew install mono
brew install openssl
#The latest version of OpenSSL is required to use .NET Core.
#It was already installed, but you may need to link it:
ln -s /usr/local/opt/openssl/lib/libcrypto.1.0.0.dylib /usr/local/lib/
ln -s /usr/local/opt/openssl/lib/libssl.1.0.0.dylib /usr/local/lib/

brew install wget


# install Antigen - zsh plugin manager
curl -L git.io/antigen > $HOME/antigen.zsh
source $HOME/antigen.zsh

# install nvm - node version manager
# curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
# install nvm using Antigen 
antigen bundle lukechilds/zsh-nvm
antigen apply

source $HOME/.zshrc


# install fonts used in term
brew tap caskroom/fonts 
brew cask install font-inconsolata-for-powerline
brew cask install font-inconsolata-g-for-powerline

brew cask install iterm2

# configure iterm2
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/macsetup/dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
wait

### utitlities
# brew cask install teamviewer
brew cask install spectacle
brew cask install send-to-kindle
brew cask install android-file-transfer
brew cask install etcher
brew cask install sensiblesidebuttons
brew cask install smcfancontrol

### image editing
brew cask install gimp


### ftp
brew cask install filezilla
#brew cask install yummy-ftp


### communication
#brew cask install skype
brew cask install whatsapp
brew cask install telegram
brew cask install slack


### music
brew cask install spotify


### browsers
brew cask install google-chrome
brew cask install vivaldi
#brew cask install firefox


### programming languages
# install latest node
nvm install node
# brew cask install java
brew cask install java8
brew cask install dotnet
#Zsh users may need to symlink the dotnet binary:
ln -s /usr/local/share/dotnet/dotnet /usr/local/bin
# brew cask install r-app
brew install golang


### programming tools
brew cask install mysqlworkbench
brew cask install dbeaver-community
brew cask install visual-studio-code
#brew cask install android-studio
brew cask install intellij-idea-ce
# brew cask install rstudio
brew cask install teamsql
brew cask install eclipse-jee
brew cask install postman
brew cask install docker


# # installing extensions for vs code
# vscode --install-extension donjayamanne.python
# vscode --install-extension eg2.tslint
# vscode --install-extension fknop.vscode-npm
# vscode --install-extension k--kato.intellij-idea-keybindings
# vscode --install-extension leizongmin.node-module-intellisense
# vscode --install-extension miramac.vscode-exec-node
# vscode --install-extension ms-vscode.cpptools
# vscode --install-extension ms-vscode.csharp
# vscode --install-extension msjsdiag.debugger-for-chrome
# vscode --install-extension robertohuertasm.vscode-icons
# vscode --install-extension steoates.autoimport
# vscode --install-extension tungvn.wordpress-snippet
# vscode --install-extension wcwhitehead.bootstrap-3-snippets
# vscode --install-extension zhuangtongfa.Material-theme
# vscode --install-extension mrmlnc.vscode-apache
# vscode --install-extension t-sauer.autolinting-for-javascript
# vscode --install-extension bungcip.better-toml
# vscode --install-extension pivotal.vscode-manifest-yaml
# vscode --install-extension peterjausovec.vscode-docker
# vscode --install-extension dbaeumer.vscode-eslint
# vscode --install-extension donjayamanne.githistory
# vscode --install-extension ms-vscode.go
# vscode --install-extension vscjava.vscode-java-pack
# vscode --install-extension redhat.java
# vscode --install-extension vscjava.vscode-maven
# vscode --install-extension christian-kohler.path-intellisense
# vscode --install-extension ms-python.python


### Quick look plugins
#Some plugins to enable different files to work with Mac Quicklook. Includes features like syntax highlighting, markdown rendering, preview of jsons, patch files, csv, zip files etc.
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install qlprettypatch
brew cask install quicklook-csv
brew cask install betterzipql
brew cask install webpquicklook
brew cask install suspicious-package


### brew cleanup
brew cleanup
brew linkapps


### mac defaults
# General UI/UX
# ----------------------------------------------------------------------

# Disable Menu bar transparency
#defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Enable snap-to-grid for desktop icons
#/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Always show scrollbars
#defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Save to disk (not to iCloud) by default
#defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable automatic termination of inactive apps
#defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Disable Resume system-wide
#defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Disable press-and-hold for keys in favor of key repeat
#defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
#defaults write NSGlobalDomain KeyRepeat -int 0

# Trackpad: swipe between pages with three fingers
#defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

# Don’t automatically rearrange Spaces based on most recent use
#defaults write com.apple.dock mru-spaces -bool false


# Dock
# ----------------------------------------------------------------------

# Dock: enable the 2D Dock
#defaults write com.apple.dock no-glass -bool true

# Dock: position the Dock on the left
defaults write com.apple.dock orientation left

# Dock: set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# Dock: show indicator lights for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Dock: make icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Dock: don’t animate opening applications
defaults write com.apple.dock launchanim -bool false

# Dock: use the scale effect for window minimizing
defaults write com.apple.dock mineffect scale

# Dock: speed up Mission Control animations
#defaults write com.apple.dock expose-animation-duration -float 0.1


# Finder
# ----------------------------------------------------------------------

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder: empty Trash securely by default
#defaults write com.apple.finder EmptyTrashSecurely -bool true

# Finder: disable window and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
#defaults write com.apple.finder QuitMenuItem -bool true

# Finder: show the ~/Library folder (in OS X Lion)
chflags nohidden ~/Library

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: use list view in all windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true


# Panels
# ----------------------------------------------------------------------

# Panels: expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Panels: expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Panels: disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Panels: enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3


# Screen
# ----------------------------------------------------------------------

# Screen: require password immediately after sleep or screen saver begins
#defaults write com.apple.screensaver askForPassword -int 1
#defaults write com.apple.screensaver askForPasswordDelay -int 0

# Screen: save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Screen: disable shadow in screenshots
#defaults write com.apple.screencapture disable-shadow -bool true

# Screen: enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2


# Disks
# ----------------------------------------------------------------------

# Disks: avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disks: disable Time Machine prompts
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disks: disable local Time Machine backups
#hash tmutil &> /dev/null && sudo tmutil disablelocal

# Disks: disable disk image verification
# defaults write com.apple.frameworks.diskimages skip-verify -bool true
# defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
# defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true


# iTunes
# ----------------------------------------------------------------------

# iTunes: make ⌘ + F focus the search input
#defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add "Target Search Field" "@F"

# iTunes: disable the Ping sidebar in iTunes
#defaults write com.apple.iTunes disablePingSidebar -bool true

# iTunes: disable all the other Ping stuff
#defaults write com.apple.iTunes disablePing -bool true


# Misc
# ----------------------------------------------------------------------

# Misc: only use UTF-8 in Terminal.app
#defaults write com.apple.terminal StringEncodings -array 4

# Misc: disable Dictionary results
#defaults write com.apple.spotlight DictionaryLookupEnabled -bool false

# Misc: disable auto-correct
#defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

for app in "Dashboard" "Dock" "Finder" "SystemUIServer" "iTunes"; do
    killall "$app" > /dev/null 2>&1
done
