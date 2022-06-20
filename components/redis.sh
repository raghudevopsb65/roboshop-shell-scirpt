USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
    echo You are Non root user
    echo You can run this script as root user or with sudo
    exit 1
fi

curl -L https://raw.githubusercontent.com/roboshop-devops-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
yum install redis-6.2.7 -y

sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf
systemctl enable redis
systemctl start redis

