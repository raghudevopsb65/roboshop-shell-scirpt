CHECK_ROOT() {
  USER_ID=$(id -u)
  if [ $USER_ID -ne 0 ]; then
      echo You are Non root user
      echo You can run this script as root user or with sudo
      exit 1
  fi
}

