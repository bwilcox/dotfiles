# What OS are we on?
os_name=`uname`

# Function to change the title manually
function title {
  echo -ne "\033]0;$@\007"
  echo -ne "\033k$@ \033\\"
}


# Set my editor to be viEDITOR=/usr/bin/vim
set -o vi

# Set my prompt
PS1="`id -un`-`uname -n`:\$PWD 
% "

# Set OS specific things
case ${os_name} in
  "AIX")
    # CVS setup
    export CVSROOT=:ext:$LOGNAME@nim1p1x:/var/lib/cvsroot
    export CVS_RSH=/usr/bin/ssh
    export CVSEDITOR=/usr/bin/vi
    export CVSHOME=$HOME/cvs

    # DSH setup
    export DSH_TIMEOUT="10"
    export DSH_NODE_RSH="/usr/bin/ssh"
    export WCOLL=${CVSHOME}/hosts/dsh/aix
    export DSH_PATH=$PATH
    export DCP_NODE_RCP=/usr/bin/scp
    export DCP_NODE_OPTS="-q"
    export DSH_NODE_OPTS="-q"
    export DSH_NODEGROUP_PATH=${CVSHOME}/hosts/dsh

    # AIX team faq setup
    export FAQCONF=/usr/ust/faq/faq_conf.sh
    alias faq=/usr/ust/scripts/faq

    # Look for git and change the prompt
    if [ -f "/opt/freeware/doc/git-1.8.5.4/contrib/completion/git-prompt.sh" ] ; then
      source /opt/freeware/doc/git-1.8.5.4/contrib/completion/git-prompt.sh
      export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\n% "'
      export GIT_PS1_SHOWDIRTYSTATE=1
      export GIT_PS1_SHOWUNTRACKEDFILES=1
      export GIT_PS1_SHOWCOLORHINTS=1
      export GIT_PS1_SHOWUNTRACKEDFILES=1
    fi

    PATH=$PATH:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/scripts:/usr/ucb:/usr:bin/X11:/sbin:/bin:/usr/es/sbin/cluster/sbin:/usr/es/sbin/cluster/utilities:$HOME/bin:/usr/ust/scripts:/usr/lpp/mmfs/bin:/opt/freeware/bin:/opt/freeware/bin
    ;;

  "Darwin")
    # Look for git and change the prompt
    if [ -f "/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh" ] ; then
      source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh
      export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\n\$ "'
      export GIT_PS1_SHOWDIRTYSTATE=1
      export GIT_PS1_SHOWUNTRACKEDFILES=1
      export GIT_PS1_SHOWCOLORHINTS=1
      export GIT_PS1_SHOWUNTRACKEDFILES=1
    fi

    PATH=$PATH:/usr/bin:/usr/sbin:/usr/local/bin:/sbin:/bin:$HOME/bin

    alias j9="export JAVA_HOME=`/usr/libexec/java_home -v 9`; java -version"
    alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
    ;;

  *)
    PATH=$PATH:/usr/bin:/usr/sbin:/usr/local/bin:/sbin:/bin:$HOME/bin
    ;;
esac

# Set the title of the window to the hostname of the server
title `hostname`

# Set a nicer timeout value
#TMOUT=30000

export EDITOR PS1 PATH TMOUT

mesg n

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
