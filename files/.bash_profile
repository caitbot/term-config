#--- Prompt Control  ---#
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
export PS1='\u@\H:\w$ '

#--- PATH  ---#
PATH="/usr/local/sbin:${PATH}"
CLASSPATH="."
export CLASSPATH

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"

# Anaconda + Brew Workaround
export SANS_ANACONDA=$PATH
export ANACONDA_PATH="/usr/local/anaconda3/bin"
PATH="${ANACONDA_PATH}:${PATH}"
alias perseus="export PATH="${SANS_ANACONDA}" && echo Disabled Anaconda for Homebrew."
alias medusa="export PATH="${ANACONDA_PATH}:${SANS_ANACONDA}" && echo Re-enabled Anaconda."

brew () {
  perseus
  command brew "$@"
  medusa
}

export PATH

# --- Shell Title Control --- #
function settitle () {
  case "$BASH_COMMAND" in
    *\033]0*)
      # The command is trying to set the title bar as well;
      # this is most likely the execution of $PROMPT_COMMAND.
      # In any case nested escapes confuse the terminal, so don't
      # output them.
      ;;
    *)
      CMD=$(HISTTIMEFORMAT= history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//")
      echo -ne "\033]0;${USER}@${HOSTNAME}: ${CMD}\007"
      ;;
  esac
}

function title () {
  PROMPT_COMMAND="echo -ne '\033]0;$1\007'"
}

MIN_VERSION="4.1"
function version { echo "$@" | gawk -F. '{ printf("%03d%03d%03d\n", $1,$2,$3); }'; }
if [ "$(version "$BASH_VERSION")" -gt "$(version "$MIN_VERSION")" ]; then
  # open a file descriptor on the TTY *once*, instead of doing it over and over
  # the trailing "||:" prevents this from being an error if it fails
  exec {tty_fd}>/dev/tty ||:

  # when running the code in the trap, use that file descriptor
  # similarly, the ||: means our DEBUG trap never returns false
  trap '[[ $tty_fd ]] && settitle >&$tty_fd ||:' DEBUG
fi
