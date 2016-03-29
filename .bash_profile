# Android SDK Path
export ANDROID_HOME=/Applications/Android\ Studio.app/sdk
export PATH=$PATH:/Applications/Android\ Studio.app/sdk/tools
export PATH=$PATH:/Applications/Android\ Studio.app/sdk/platform-tools

# ctags alias 
alias ctags='brew --prefix`/bin/ctags'

# Java SDK switch
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
setjdk() {
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export PATH=/usr/local/bin:$PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
