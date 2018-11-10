#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# Customize to your needs...
autoload -Uz promptinit
promptinit

# set java 8 as default
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export PATH=$PATH:JAVA_HOME/bin # add java bin to path

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

eval $(/usr/libexec/path_helper -s)

export PATH="/usr/local/opt/go/bin:$PATH"
export GOPATH="$HOME/go/"
