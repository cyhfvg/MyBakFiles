<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [My Backup Files](#my-backup-files)
  - [nodejs](#nodejs)
  - [oh-my-zsh](#oh-my-zsh)
  - [SpaceVim](#spacevim)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# My Backup Files
## nodejs
use nvm manage nodejs version;
1.install nvm
```bash
bash nvmInstall.sh
```
2.activate
```bash
source ~/.nvm/nvm.sh
```
3.install nodejs
```bash
nvm install node
```
4.use installed nodejs
```bash
nvm use node
```

## oh-my-zsh
use oh-my-zsh manage zsh

1.install zsh
```bash
sudo apt install zsh
```
2.install oh-my-zsh
```bash
sh oh-my-zsh-install.sh
```
3.use my custom oh-my-zsh config

3.1.install zplug
```bash
export ZPLUG_HOME=~/.zplug
git clone https://github.com/zplug/zplug $ZPLUG_HOME
```
3.2.copy config file to ~/.oh-my-zsh/custom/example.zsh
```bash
cp ./oh-my-zsh-example.zsh ~/.oh-my-zsh/custom/example.zsh
```
4.activate oh-my-zsh
```bash
# change default shell to zsh
chsh -s $(which zsh)
# activate
source ~/.zshrc
```

## SpaceVim
1.install
```bash
bash ./spaceVimInstall.sh
```
