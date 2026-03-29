set_title() {
    echo -ne "\033]0;${@}\007"
}

# Prefer OpenSSH's parser: same argv as a real ssh, including options and a remote command.
_color_ssh_parse_destination() {
    local out
    out=$(command ssh -G "$@" 2>/dev/null) || return 1
    [[ -n "$out" ]] || return 1
    remote_user=$(print -r "$out" | command awk '/^user / { print $2; exit }')
    remote_host=$(print -r "$out" | command awk '/^hostname / { print $2; exit }')
    [[ -n "$remote_host" ]] || return 1
    remote_host="${remote_host%%.*}"
}

# When ssh -G is unavailable, use the first non-option argument as the destination.
_color_ssh_parse_destination_fallback() {
    local -a args=("$@")
    local i=1
    local arg
    while (( i <= $#args )); do
        arg=$args[i]
        if [[ $arg == -- ]]; then
            (( ++i ))
            continue
        fi
        if [[ $arg != -* ]]; then
            _color_ssh_split_user_host "$arg"
            remote_host="${remote_host%%.*}"
            return 0
        fi
        case $arg in
            -[bcDeEeFfIiJLlmOopQRWw])
                if [[ ${#arg} -eq 2 ]]; then
                    (( i += 2 ))
                else
                    (( ++i ))
                fi
                ;;
            -o)
                (( i += 2 ))
                ;;
            -o*)
                (( ++i ))
                ;;
            *)
                (( ++i ))
                ;;
        esac
    done
    if (( i <= $#args )); then
        _color_ssh_split_user_host "$args[i]"
        remote_host="${remote_host%%.*}"
        return 0
    fi
    return 1
}

_color_ssh_split_user_host() {
    local dest="$1"
    if [[ "$dest" == *@* ]]; then
        remote_user="${dest%%@*}"
        remote_host="${dest#*@}"
    else
        remote_user=$(whoami)
        remote_host="$dest"
    fi
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

    local host=${1}
    local color
    color=$(
        command awk -F':' -v h="$host" '
            $1 == h || index($1, h ".") == 1 { print $2; exit }
        ' "$color_file"
    )
    if [[ ! -z ${color} ]]; then
        osascript -e 'tell application "Terminal" to set current settings of selected tab of window 1 to (first settings set whose name is "'${color}'")'
    fi
}

ssh() {
    local remote_user remote_host

    if ! _color_ssh_parse_destination "$@"; then
        _color_ssh_parse_destination_fallback "$@" || {
            remote_user=$(whoami)
            remote_host=${$(hostname)%%.*}
        }
    fi

    set_title "${remote_user}@${remote_host}"
    set_color "${remote_host}"

    command ssh "$@"

    unset remote_host
    unset remote_user
    set_title "$(whoami)@${$(hostname)%%.*}"
    set_color "Default"
}
