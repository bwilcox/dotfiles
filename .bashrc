os_name=`uname`
case $os_name in
  "AIX")
    source .bash_profile
    ;;
  "Darwin")
    source .bash_profile
    ;;
  *)
    ;;
esac

if [[ -d $HOME/.rvm/bin ]]; then
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
fi
