yum install python36 gcc python3-devel -y
useradd roboshop
cd /home/roboshop
rm -rf payment
curl -L -s -o /tmp/payment.zip "https://github.com/roboshop-devops-project/payment/archive/main.zip"
unzip /tmp/payment.zip
mv payment-main payment
cd /home/roboshop/payment
pip3 install -r requirements.txt

USER_ID=$(id -u roboshop)
GROUP_ID=$(id -g roboshop)

sed -i -e "/^uid/ c uid = ${USER_ID}" -e "/^gid/ c gid = ${GROUP_ID}" /home/roboshop/payment/payment.ini
sed -i -e 's/CARTHOST/cart.roboshop.internal/' -e 's/USERHOST/user.roboshop.internal/' /home/roboshop/payment/systemd.service

mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
