
source common.sh
rm -f /tmp/expense.log

heading Installing Nginx
dnf install nginx -y &>>/tmp/expense.log
STAT $?

heading copy expense config file
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log
STAT $?

heading clean old content
rm -rf /usr/share/nginx/html/* &>>/tmp/expense.log
STAT $?

heading download frontend content
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/expense.log
STAT $?
cd /usr/share/nginx/html

heading Extract content
unzip /tmp/frontend.zip &>>/tmp/expense.log
STAT $?

heading Restart service
systemctl restart nginx &>>/tmp/expense.log
systemctl enable nginx &>>/tmp/expense.log
STAT $?



