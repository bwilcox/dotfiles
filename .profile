# What OS are we on?
os_name=`uname`

# Function to change the title manually
function title {
  case ${os_name} in
    "AIX")
      echo "\033]0;$@\007"
      echo "\033k$@\033\\"
      ;;
    *)
      echo -ne "\033]0;$@\007"
      echo -ne "\033k$@\033\\"
      ;;
  esac
}

# Change the title on logout to the host we ssh'ed in from
function treset {
  ip=$(echo $SSH_CLIENT | awk '{print $1}')
  if [[ -n $ip ]]; then
    name=$(nslookup $ip | grep 'name =' |awk '{print $4}' | awk -F'.' '{print $1}')
    if [[ -z $name ]]; then
      name="Unknown"
    fi
    case ${os_name} in
      "AIX")
        # attempt to reset the window title
        echo "\033]0;${name}\007"
        # attempt to reset the screen title
        echo "\033k${name}\033\\"
        ;;
      *)
        # attempt to reset the window title
        echo -ne "\033]0;${name} \007"
        # attempt to reset the screen title
        echo -ne "\033k${name} \033\\"
        ;;
    esac
  fi
}

# Set my editor to be vi
EDITOR=/usr/bin/vim
set -o vi

# Set my prompt
PS1="`id -un`-`uname -n`:\$PWD 
\$ "

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

    PATH=$PATH:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/scripts:/usr/ucb:/usr:bin/X11:/sbin:/bin:/usr/es/sbin/cluster/sbin:/usr/es/sbin/cluster/utilities:$HOME/bin:/usr/ust/scripts:/usr/lpp/mmfs/bin:/opt/freeware/bin:/opt/freeware/bin
    ;;

  "Darwin")
    # Look for git and change the prompt
    if [ -f "/Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh" ] ; then
      source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
      export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\n\$ "'
      export GIT_PS1_SHOWDIRTYSTATE=1
      export GIT_PS1_SHOWUNTRACKEDFILES=1
      export GIT_PS1_SHOWCOLORHINTS=1
      export GIT_PS1_SHOWUNTRACKEDFILES=1
    fi

    PATH=$PATH:/usr/bin:/usr/sbin:/usr/local/bin:/sbin:/bin:$HOME/bin
    ;;

  *)
    PATH=$PATH:/usr/bin:/usr/sbin:/usr/local/bin:/sbin:/bin:$HOME/bin
    ;;
esac

# Set the title of the window to the hostname of the server
title `hostname`

# Set a nicer timeout value
TMOUT=30000

export EDITOR PS1 PATH TMOUT

# If the bash shell is available, execute it.
case ${os_name} in
  "AIX")
    if [[ -e /usr/bin/bash ]]; then
      export SHELL=/usr/bin/bash
      /usr/bin/bash
    fi
    ;;
  "Darwin")
    if [[ -e /bin/bash ]]; then
      export SHELL=/bin/bash
      /bin/bash
    fi
    ;;
  *)
    # We're probably good.
    ;;
esac


mesg n
trap treset EXIT
