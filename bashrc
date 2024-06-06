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
    ranger --choosedir=$HOME/.rangerExit "$@"
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

alias et="vim ~/.local/share/ranger/tagged"
alias clt="rm ~/.local/share/ranger/tagged; touch ~/.local/share/ranger/tagged"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#aaaaaa,fg+:#ffffff,bg:#000000,bg+:#ff00ff
  --color=hl:#00ffff,hl+:#00ffff,info:#ff60ff,marker:#00ffff
  --color=prompt:#6040ff,spinner:#ff60ff,pointer:#ffffff,header:#6040ff
  --color=gutter:#000000,border:#6040ff,separator:#6040ff,scrollbar:#ff00ff
  --color=preview-scrollbar:#ff00ff,label:#ff60ff,query:#aaaaaa
  --border="rounded" --border-label="Results" --border-label-pos="0" --preview-window="border-rounded"
  --margin="2" --prompt="> " --marker="*" --pointer=">"
  --separator="─" --scrollbar="▋" --info="right"

  --walker=file,dir,follow,hidden
  '

zzc() {
    fzsel=$(fzf --preview="preview {}" +m --border-label="Change Directory" "$@")

    if [[ -n "$fzsel" ]] ; then
        fzsel=$(readlink -f "$fzsel")

        if [[ -d "$fzsel" ]] ; then
            cd "$fzsel"
        elif [[ -e "$fzsel" ]] ; then
            fzsel=$(dirname "$fzsel")
            cd "$fzsel"
        fi
    fi
}

zzv() {
    fzsel=$(fzf --preview="preview {}" +m --border-label="Vim File" "$@")

    if [[ -n "$fzsel" ]] ; then
        fzsel=$(readlink -f "$fzsel")

        if [[ -d "$fzsel" ]] ; then
            cd "$fzsel"
            vim
        elif [[ -e "$fzsel" ]] ; then
            parent=$(dirname "$fzsel")
            cd "$parent"
            vim "$fzsel"
        fi
    fi
}


zzr() {
    fzsel=$(fzf --preview="preview {}" +m --border-label="Ranger File/Directory" "$@")

    if [[ -n "$fzsel" ]] ; then
        fzsel=$(readlink -f "$fzsel")

        if [[ -d "$fzsel" ]] ; then
            cd "$fzsel"
            ra
        elif [[ -e "$fzsel" ]] ; then
            parent=$(dirname "$fzsel")
            cd "$parent"
            ra --selectfile="$fzsel"
        fi
    fi
}


zzt() {
    fzsel=$(fzf --preview="preview {}" -m --border-label="Tag Files" "$@")

    echo "$fzsel" | while read -r line ; do
        line=$(readlink -f "$line")

        if [[ -z "$line" ]] ; then
            continue
        fi

        grep -Fqx "$line" ~/.local/share/ranger/tagged || echo "$line" >> ~/.local/share/ranger/tagged

    done
}

stimer() {
    if [[ -n "$1" ]] ; then
        seconds=$(("$1"))

        if [[ "$2" == "m" ]] ; then
            seconds=$(("$seconds" * 60))
        fi
    else
        seconds=$((5 * 60))
    fi


    echo "$seconds" > $HOME/.i3btimer
    pkill --signal SIGRTMIN+4 i3blocks
}


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
