#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

############################################################
TERM=kitty
export EDITOR=/usr/bin/vim

alias kt="vim ~/.config/kitty/kitty.conf"
alias tt="vim /home/user1/.config/terminator/config"

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
alias todo="vim ~/Desktop/todo.txt +\"color default\""
alias plan="vim ~/plan.txt +\"color default\""
alias li="vim ~/Desktop/links.txt +\"color default\""
alias vimc="cd ~/.vim/colors"
alias ka="killall $@"
alias vol="sh /usr/share/i3blocksScripts/volumeDisplay.sh"

cleanhistory() {
	rm ~/.viminfo
	rm ~/.bash_history
    rm -rf ~/.cache
    rm ~/.lesshst
    rm ~/.rangerExit
    rm ~/.python_history
	history -cw
}

sc() {
	vim ~/Desktop/scratch.txt
}

alias gstat="git status"
alias gb="git branch"
alias gcom="git commit"

export PATH=/home/USERNAMEGOESHERE/VSCode-linux-x64/bin:$PATH
export PATH=/home/USERNAMEGOESHERE/Games/execScripts:$PATH

vom () {
    com=$(python3 ~/scripts/vimOpen.py $@)
    eval $com
}

rwall () {
    feh --randomize --bg-fill ~/shared/random*
}

alias ohaton="ssh ohaton"
alias proc="ps -U USERNAMEGOESHERE"

alias xin="sh ~/.xinputStuff"
alias sls="screen -ls $@"
alias sr="screen -r $@"

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
