# -- http://www.jayway.com/2014/01/15/how-to-switch-jdk-version-on-mac-os-x-maverick/
#    Example use: setjdk 1.7 - selects the latest installed JDK version of the 1.7 branch
#    Example use: setjdk 1.7.0_51 - select a specific version
#    Run /usr/libexec/java_home -h to get more details on how to choose versions
function setjdk() {
  if [ $# -ne 0 ]; then
    removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
    if [ -n "${JAVA_HOME+x}" ]; then
      removeFromPath $JAVA_HOME
    fi
    export JAVA_HOME=`/usr/libexec/java_home -v $@`
    export PATH=$JAVA_HOME/bin:$PATH
  fi
}

function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}
