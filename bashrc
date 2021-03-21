#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

############################################################

alias prof="vim ~/.bashrc"
alias ic="vim ~/.config/i3/config"
alias ib="vim ~/.config/i3blocks/config"

alias des="cd ~/Desktop && clear && ls"
alias dow="cd ~/Downloads && clear && ls"
alias doc="cd ~/Documents && clear && ls"

alias clr="clear"
alias cls="clear && ls"

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
alias todo="vim ~/Desktop/todo.txt +\"color default\""
alias vimc="cd ~/.vim/colors"
alias ka="killall $@"

cleanhistory() {
	rm ~/.viminfo
	rm ~/.bash_history
	history -cw
}
