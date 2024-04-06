#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

############################################################
TERM=kitty
export EDITOR=/usr/bin/nvim

alias vim="/usr/bin/nvim $@"

alias kt="vim ~/.config/kitty/kitty.conf"
alias tt="vim ~/.config/terminator/config"

alias prof="vim ~/.bashrc"
alias ic="vim ~/.config/i3/config"
alias ib="vim ~/.config/i3blocks/config"

alias des="cd ~/Desktop && clear && ls"
alias dow="cd ~/Downloads && clear && ls"
alias doc="cd ~/Documents && clear && ls"
alias shr="cd ~/shared && clear && ls"

ba() {
    cd "$OLDPWD"
}


back() {
    cd "$OLDPWD"
}

alias clr="clear"
alias cls="clear && ls"

ra() {
    ranger --choosedir=$HOME/.rangerExit $@
    RANGEREXIT="$(cat ~/.rangerExit)"
    cd "$RANGEREXIT"
}

cl() {
	cd "$@"
	clear && ls
}


up() {
	cd ..
	let num=$(($1 - 1))
	while [ $(($num > 0)) == "1" ]; do
		cd ..
		num=$(($num - 1))
	done
	clear && ls
}


alias src="source ~/.bashrc"

alias vimr="vim ~/.vimrc"
alias rrco="vim ~/.config/ranger/commands.py"
alias rrc="vim ~/.config/ranger/rc.conf"
alias todo="vim ~/Desktop/todo.txt"
alias plan="vim ~/plan.txt"
alias li="vim ~/Desktop/links.txt"
alias vimc="cd ~/.vim/colors"
alias ka="killall $@"

cleanhistory() {
	rm ~/.viminfo
	rm ~/.bash_history
    rm -rf ~/.cache
    rm ~/.lesshst
    rm ~/.rangerExit
    rm ~/.python_history
    rm ~/.local/share/recently-used.xbel
	history -cw
}

cleanhistory2() {
    cleanhistory
    rm ~/.local/share/nvim/telescope_history
    rm ~/.local/share/nvim/harpoon.json
    rm -rf ~/.local/share/ranger
    rm ~/.local/share/nvim/.netrwhist
    rm -rf ~/.local/state/nvim/shada
    rm -rf ~/.local/state/nvim/swap
    rm -rf ~/.local/state/nvim/undo
    rm ~/.local/state/nvim/log
    rm ~/.local/state/nvim/luasnip.log
}

sc() {
	vim ~/Desktop/scratch.txt
}

alias gstat="git status"
alias gb="git branch"
alias gcom="git commit"

export PATH=~/VSCode-linux-x64/bin:$PATH
export PATH=~/Games/execScripts:$PATH
export PATH=~/scripts:$PATH

vom () {
    com=$(python3 ~/scripts/vimOpen.py $@)
    eval $com
}

rwall () {
    feh --randomize --bg-fill ~/shared/random*
}

alias ohaton="ssh ohaton"
alias proc="ps -U $(whoami)"

alias xin="sh ~/.xinputStuff"
alias sls="screen -ls $@"
alias sr="screen -r $@"

## NEW LAPTOP STUFF
alias nvc="cd ~/.config/nvim"
alias scr="cd ~/scripts && clear && ls"
alias out-hdmi="sh ~/scripts/hdmi.sh"
alias out-laptop="sh ~/scripts/laptop.sh"

lt () {
    local x="*"

    if [ -v 1 ]; then
        x="$1"
    fi

    ranger --list-tagged-files "$x"
}

alias rt="vim ~/.local/share/ranger/tagged"
alias clt="rm ~/.local/share/ranger/tagged; touch ~/.local/share/ranger/tagged"


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
