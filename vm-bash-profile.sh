# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

set -o vi
alias l='ls -aF'
alias ll='ls -alF'
alias dir='ls -altF'
alias c='clear'
alias h='history'

#
# Make shell a tad more readable (lighter blue on black background)
PS1="\u@\h$ "; export PS1
LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS

M2_HOME=/opt/apache-maven-3.3.9
PATH=${M2_HOME}/bin:${PATH}

#JAVA_HOME=/opt/java/jdk1.7.0_91
JAVA_HOME=/opt/java/jdk1.8.0_91
PATH=${JAVA_HOME}/bin:${PATH}

EDITOR=/usr/bin/vim

export PATH M2_HOME JAVA_HOME EDITOR
