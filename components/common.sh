CHECK_ROOT() {
  USER_ID=$(id -u)
  if [ $USER_ID -ne 0 ]; then
      echo -e "\e[31mYou should be running this script as root user or sudo this script\e[0m"
      exit 1
  fi
}

CHECK_STAT() {
if [ $1 -ne 0 ]; then
  echo -e "\e[31mFAILED\e[0m"
  exit 2
else
  echo -e "\e[32mSUCCESS\e[0m"
fi
}

LOG=/tmp/roboshop.log
rm -f $LOG
