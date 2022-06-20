USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
    echo You are Non root user
    echo You can run this script as root user or with sudo
    exit 1
fi

yum install maven -y
useradd roboshop
cd /home/roboshop
rm -rf shipping
curl -s -L -o /tmp/shipping.zip "https://github.com/roboshop-devops-project/shipping/archive/main.zip"
unzip /tmp/shipping.zip
mv shipping-main shipping
cd shipping
mvn clean package
mv target/shipping-1.0.jar shipping.jar
sed -i -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' /home/roboshop/shipping/systemd.service
mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl restart shipping
systemctl enable shipping
