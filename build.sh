# Set up dev environment on macOS Big Sur

###################################################################################################
# Install Homebrew
###################################################################################################
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


###################################################################################################
# A few adjustments to make things bearable
###################################################################################################
brew install --cask karabiner-elements
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write com.apple.finder AppleShowAllFiles YES


###################################################################################################
# Vim
###################################################################################################
brew install macvim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


###################################################################################################
# zsh/oh-my-zsh
###################################################################################################
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo chown -R $(whoami) /usr/local/share/zsh /usr/local/share/zsh/site-functions
chmod u+w /usr/local/share/zsh /usr/local/share/zsh/site-functions

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zdharma/fast-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting
git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips


###################################################################################################
# asdf + languages
###################################################################################################
brew install coreutils curl git
# Install asdf directly and NOT WITH HOMEBREW. It messes with the node keychain and I can't fix it :)
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

asdf plugin-add ruby
asdf install ruby latest
asdf global ruby $(asdf latest ruby)
gem install bundler

asdf plugin-add python
asdf install python 2.7.17
asdf install python latest
asdf global python $(asdf latest python) 2.7.17

brew install gpg coreutils
asdf plugin-add nodejs
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-previous-release-team-keyring'
asdf install nodejs latest
asdf global nodejs $(asdf latest nodejs)

asdf plugin-add yarn
asdf install yarn latest
asdf global yarn $(asdf latest yarn)


###################################################################################################
# Dotfiles
###################################################################################################
mkdir ~/code
git clone https://github.com/bdavi/dotfiles.git ~/code/dotfiles
~/code/dotfiles/scripts/install_dotfiles


###################################################################################################
# Databases
###################################################################################################
# Postgres
# Install Postres.app: https://postgresapp.com/downloads.html
# Install pgAdmin4 from here: https://www.pgadmin.org/download/pgadmin-4-macos/

# Configure your $PATH to use the included command line tools (optional):
sudo mkdir -p /etc/paths.d && echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp

# MongoDB
# Install MongoDB Compass from here: https://www.mongodb.com/try/download/compass
brew tap mongodb/brew
brew install mongodb-community@4.4
brew services start mongodb-community@4.4

# Redis
brew install redis
brew services start redis


###################################################################################################
# Apps & Tools
###################################################################################################
brew install ranger
brew install tmux
brew install --cask iterm2
brew install --cask alfred
brew install --cask keepassxc
brew install --cask gimp
brew install --cask chromium
brew install --cask firefox
brew install --cask slack
brew install --cask vlc
brew install --cask skitch
brew install --cask balenaetcher
brew install pandoc
brew install --cask libreoffice
brew install the_silver_searcher
brew tap heroku/brew && brew install heroku
brew install --cask rectangle

# Manual Install
# https://sensible-side-buttons.archagon.net/
