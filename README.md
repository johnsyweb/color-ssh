# `color-ssh.plugin.zsh`
Change the theme as you SSH into production boxes. An
[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh). Requires OS X.

## Introduction

I wrote this plug-in because I want it to be obvious when I've a lot of windows
open and one of them is connected to a production host.

## Installation

    cd $ZSH_CUSTOM/plugins/
    git clone git://github.com/johnsyweb/color-ssh

## Settings

Servers and their color-schemes are defined in `${HOME}/.server_colors`. Here's
an example:

    Default:Solarized Dark xterm-256color
    my-dev-host:Ocean
    my-qa-host:Grass
    my-uat-host:Novel
    my-production-host:Red Sands
    my-other-production-host:Red Sands

## License

color-ssh is licensed under the same terms as oh-my-zsh itself (see 
[the README](https://github.com/robbyrussell/oh-my-zsh#readme)).

## Thanks

If you find this plug-in useful, please follow this repository on
[GitHub](https://github.com/johnsyweb/color-ssh). If you have
something to say, you can contact [johnsyweb](http://johnsy.com/about/) on
[Twitter](http://twitter.com/johnsyweb/) and
[GitHub](https://github.com/johnsyweb/).

