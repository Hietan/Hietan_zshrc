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

# Homebrew
if exist "/home/linuxbrew"; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
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

# aliases
if command_exist "xclip"; then
	alias clipcopy='xclip -selection clipboard'  # Copy text to the clipboard using xclip
	alias clippaste='xclip -selection clipboard -o'  # Paste text from the clipboard using xclip
fi
alias killport='function _killport(){ sudo kill -9 $(lsof -t -i :"$1"); }; _killport'  # Kills a process running on a specified port
alias reload="exec \$SHELL -l"  # Reload the shell
if command_exist "ghq" && command_exist "peco"; then
	alias repo='cd $(ghq list -p | peco)'  # Navigate to a directory selected from a list of repositories using ghq and peco
fi
alias update='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean'  # Updates and upgrades the system, removes unnecessary packages, and cleans up
if command_exist "nvim"; then
	alias v='nvim'  # Opens Neovim
	alias vimrc='nvim ~/.vimrc'  # Edit the Vim configuration file using Neovim
	alias zshrc='nvim ~/.zshrc'  # Edit the Zsh configuration file using Neovim
fi
