# `color-ssh.plugin.zsh`
Change the theme as you SSH into production boxes. If we're still doing that. An
[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) plugin for macOS.

## Introduction

I wrote this plug-in because I want it to be obvious when I've a lot of windows
open and one of them is connected to a production host.

## Installation

Clone the plugin into your Oh My Zsh custom plugins directory:

    cd $ZSH_CUSTOM/plugins/
    git clone https://github.com/johnsyweb/color-ssh

### Enabling the plugin

Cloning alone does not load the plugin. Add `color-ssh` to the `plugins` array in your `~/.zshrc` (see the [Oh My Zsh plugins wiki](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)):

    plugins=(git color-ssh)

Use spaces between names; **do not** separate plugin names with commas. Add any other plugins you already use to the same array, then reload your configuration (`source ~/.zshrc`) or open a new terminal.

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

`color-ssh` is released under the [MIT License](LICENSE).

## Thanks

If you find this plug-in useful, please follow this repository on
[GitHub](https://github.com/johnsyweb/color-ssh). If you have
something to say, you can contact [johnsyweb](https://www.johnsy.com/contact/).

