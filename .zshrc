# Function to check if a directory or file exists in the given path
exist() {
	[ -e "$1" ]
}

# Function to check if a command exists
command_exist() {
  command -v "$1" >/dev/null 2>&1
}

# Oh My Zsh
if exist "$HOME/.oh-my-zsh"; then
	export ZSH="$HOME/.oh-my-zsh"
	ZSH_THEME="hietan"
	HYPHEN_INSENSITIVE="true"
	plugins=(
		aliases
		alias-finder
		git
		git-flow
		docker
		yarn
		zsh-autosuggestions
	)
	source $ZSH/oh-my-zsh.sh

	# alias-finder
	zstyle ':omz:plugins:alias-finder' autoload yes
	zstyle ':omz:plugins:alias-finder' exact yes
fi

# Linuxrew
if exist "/home/linuxbrew"; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin/"
fi

# nvm (JavaScript)
if exist "$HOME/.nvm"; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Cargo (Rust)
if exist "$HOME/.cargo"; then
	. "$HOME/.cargo/env"
fi

# Rye (Python)
if exist "$HOME/.rye/"; then
	source "$HOME/.rye/env"
fi

# Anaconda (Python)
if exist "/opt/anaconda3"; then
	__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
	if [ $? -eq 0 ]; then
		eval "$__conda_setup"
	else
		if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
			. "/opt/anaconda3/etc/profile.d/conda.sh"
		else
			export PATH="/opt/anaconda3/bin:$PATH"
		fi
	fi
	unset __conda_setup
fi

# Gem (Ruby)
if exits "$HOME/gems"; then
	export GEM_HOME="$HOME/gems"
	export PATH="$HOME/gems/bin:$PATH"
fi

# Flutter
if exist "$HOME/.flutter"; then
	export PATH="$HOME/.flutter/flutter/bin:$PATH"
fi

# Neovim
if command_exist "nvim"; then
	alias v='nvim'  # Opens Neovim
	alias vimrc='nvim ~/.vimrc'  # Edit the Vim configuration file using Neovim
	alias zshrc='nvim ~/.zshrc'  # Edit the Zsh configuration file using Neovim
fi

# fzf
if command_exist "fzf"; then
	source < (fzf --zsh)
fi

# aliases
if command_exist "xclip"; then
	alias clipcopy='xclip -selection clipboard'  # Copy text to the clipboard using xclip
	alias clippaste='xclip -selection clipboard -o'  # Paste text from the clipboard using xclip
fi

if command_exist "ghq" && command_exist "peco"; then
	alias repo='cd $(ghq list -p | peco)'  # Navigate to a directory selected from a list of repositories using ghq and peco
fi

alias update='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean'  # Updates and upgrades the system, removes unnecessary packages, and cleans up
alias killport='function _killport(){ sudo kill -9 $(lsof -t -i :"$1"); }; _killport'  # Kills a process running on a specified port
alias reload="exec \$SHELL -l"  # Reload the shell
