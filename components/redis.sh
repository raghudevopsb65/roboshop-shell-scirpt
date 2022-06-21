source components/common.sh

CHECK_ROOT

PRINT "Setup YUM Repos"
curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>${LOG}
CHECK_STAT $?

PRINT "Install Redis"
yum install redis-6.2.7 -y &>>${LOG}
CHECK_STAT $?

PRINT "Configure Redis Config"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>${LOG}
CHECK_STAT $?

PRINT "Start Redis"
systemctl enable redis &>>${LOG} && systemctl restart redis &>>${LOG}

