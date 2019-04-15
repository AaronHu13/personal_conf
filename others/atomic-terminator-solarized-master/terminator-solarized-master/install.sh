echo "begin to install THE VIP SOFTWARES..."

echo "1st TMUX..."
sudo apt install tmux  -y #install tmux
mkdir -p ~/.tmux
# powerline 
pip install --user powerline-status
git clone https://github.com/erikw/tmux-powerline.git ~/.tmux/tmux-powerline

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf ~/.confhub/tmux-config/tmux.conf ~/.tmux.conf
ln -sf ~/.confhub/tmux-config/tmux-powerlinerc ~/.tmux-powerlinerc

echo "2nd ZSH WITH OH~MY~ZSH"
sudo apt install zsh  -y #install zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
cp ~/.zshrc ~/.zshrc.bak
ln -sf ~/.confhub/zsh-config/zshrc ~/.zshrc
ln -sf ~/.confhub/zsh-config/npmrc ~/.npmrc
mkdir -p ~/.m2 && ln -sf ~/.confhub/zsh-config/maven.xml ~/.m2/settings.xml

git clone git://github.com/seebi/dircolors-solarized.git ~/dircolors-solarized
cp ~/dircolors-solarized/dircolors.256dark ~/.dircolors
eval 'dircolors .dircolors'

echo "begin to install SourceCodeProFonts..."
mkdir -p ~/.fonts && cp fonts/* ~/.fonts/
echo "\n* Updating font cache"
sudo fc-cache -f -v
echo "\n* Looking for 'Source Code Pro' in installed fonts"
fc-list | grep "Source Code Pro"

echo "final switch default bash to zsh..."
chsh -s /bin/zsh
source ~/.zshrc

echo "3rd VIM"
ln -sf ~/.confhub/vim-config/editorconfig ~/.editorconfig
ln -sf ~/.confhub/vim-config/vimrc.before.fork ~/.vimrc.before.fork
ln -sf ~/.confhub/vim-config/vimrc.before.local ~/.vimrc.before.local
ln -sf ~/.confhub/vim-config/vimrc.bundles.local ~/.vimrc.bundles.local
ln -sf ~/.confhub/vim-config/vimrc.local ~/.vimrc.local

sudo apt install -y silversearcher-ag vim vim-gui-common cmake python-dev build-essential 
git clone https://github.com/spf13/spf13-vim.git ~/.spf13-vim
sh ~/.spf13-vim/bootstrap.sh
cd ~/.vim/bundle/YouCompleteMe && ./install.sh

# awesome
echo "4th AwesomeWM"
mkdir -p ~/tmp
sudo apt install -y awesome awesome-extra gnome-settings-daemon
git clone --recursive https://github.com/lcpz/awesome-copycats.git ~/tmp/awesome-copycats
mv -bv ~/tmp/awesome-copycats/* ~/.config/awesome; rm -rf ~/tmp/awesome-copycats
ln -sf ~/.confhub/awesomewm-config/rc.lua ~/.config/awesome/rc.lua

