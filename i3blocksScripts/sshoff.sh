if [[ $(systemctl is-active sshd) == "inactive" ]] ; then
    echo "SSH OFF"
fi
