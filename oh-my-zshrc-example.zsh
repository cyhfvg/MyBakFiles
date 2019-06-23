# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

# For example: add yourself some shortcuts to projects you often work on.
#
# brainstormr=~/Projects/development/planetargon/brainstormr
# cd $brainstormr

# zplug
source ~/.zplug/init.zsh

zplug "mafredri/zsh-async", from:github, defer:0

# 语法高亮
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
# 命令提示
zplug "zsh-users/zsh-autosuggestions", from:github

# 从oh-my-zsh 插件 获取插件
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
# 终端历史记录提示
zplug "plugins/history-substring-search", from:oh-my-zsh
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# oh-my-zsh主题
zplug "themes/frisk", from:oh-my-zsh, as:theme

# 管理主题
zplug 'dracula/zsh', as:theme
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# zplug 管理自身
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# 确保未安装的插件 安装
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

