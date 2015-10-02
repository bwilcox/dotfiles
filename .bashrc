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
