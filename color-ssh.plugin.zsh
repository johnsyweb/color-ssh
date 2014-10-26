set_title() {
    echo -ne "\033]0;${@}\007"
}

set_color() {
    type osascript &>/dev/null
    if [[ 0 != $? ]]; then
        return
    fi

    color_file="${HOME}/.server_colors"
    if [[ ! -f ${color_file} ]]; then
        echo "File [${color_file}] not found."
        echo "Format:"
        echo "hostname:Settings"
        return
    fi

    host=${1}
    color=$(awk -F':' '$1 ~ /'${host}'/ { print $2; exit }' ${color_file})
    if [[ ! -z ${color} ]]; then
        osascript -e 'tell application "iTerm" to set the background color of the current session of the current terminal to "'${color}'"'
    fi
}

ssh() {
    remote_host=${${@##*@}%%.*}
    if [[ $@ == *@* ]]; then
        remote_user=${${@##* }%%@*}
    else
        remote_user=$(whoami)
    fi

    set_title "${remote_user}@${remote_host}"
    set_color "${remote_host}"

    command ssh "$@"

    unset remote_host
    unset remote_user
    set_title "$(whoami)@${$(hostname)%%.*}"
    set_color "Default"
}

