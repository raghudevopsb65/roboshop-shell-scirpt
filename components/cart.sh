source components/common.sh

CHECK_ROOT

PRINT "Setting Up NodeJS YUM Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
CHECK_STAT $?

echo "Installing NodeJS"
yum install nodejs -y &>>${LOG}
CHECK_STAT $?

echo "Creating Application User"
useradd roboshop &>>${LOG}
CHECK_STAT $?

echo "Downloading Cart Content"
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>${LOG}
CHECK_STAT $?

cd /home/roboshop

echo "Remove old Content"
rm -rf cart  &>>${LOG}
CHECK_STAT $?

echo "Extract Cart Content"
unzip /tmp/cart.zip &>>${LOG}
CHECK_STAT $?

mv cart-main cart
cd cart

echo "Install NodeJS Dependencies for Cart Component"
npm install &>>${LOG}
CHECK_STAT $?

echo "Update SystemD Configuration"
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' /home/roboshop/cart/systemd.service &>>${LOG}
CHECK_STAT $?

echo "Setup SystemD Configuration"
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>${LOG}
CHECK_STAT $?

systemctl daemon-reload
systemctl enable cart

echo "Start Cart Service"
systemctl restart cart &>>${LOG}
CHECK_STAT $?
