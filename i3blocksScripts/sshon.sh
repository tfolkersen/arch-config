if [[ $(systemctl is-active sshd) != "inactive" ]] ; then
    echo "[[ SSH ON ]]"
fi
