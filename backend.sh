source common.sh
rm -f /tmp/expense.log

HEADING "Disable NodeJS default version"
dnf module disable nodejs -y &>>/tmp/expense.log
STAT $?

HEADING "Enable NodeJS 20"
dnf module enable nodejs:20 -y &>>/tmp/expense.log
STAT $?

HEADING "Install NodeJS"
dnf install nodejs -y &>>/tmp/expense.log
STAT $?

# useradd expense

HEADING "Add Expense User"
id expense &>>/tmp/expense.log
if [ $? -ne 0 ]; then
  useradd expense &>>/tmp/expense.log
fi
STAT $?

# cp backend.service /etc/systemd/system/backend.service

HEADING "Setup Backend Service"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
STAT $?

HEADING "Delete Existing Application Directory"
rm -rf /app
STAT $?

# mkdir /app

HEADING "Create Application Directory"
mkdir /app &>>/tmp/expense.log
STAT $?

# curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip

HEADING "Download Backend Code"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
STAT $?

cd /app

# unzip /tmp/backend.zip

HEADING "Extract Backend code"
unzip /tmp/backend.zip &>>/tmp/expense.log
STAT $?

# npm install

HEADING "Download NodeJS App Dependencies"
npm install &>>/tmp/expense.log
STAT $?

# dnf install mysql -y

HEADING "Install MySQL Client"
dnf install mysql -y &>>/tmp/expense.log
STAT $?

# mysql -h 172.31.30.152 -uroot -pExpenseApp@1 < /app/schema/backend.sql

HEADING "Load Schema"
mysql -h 172.31.30.152 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/expense.log
STAT $?

HEADING "Start Backend Service"
systemctl daemon-reload
systemctl enable backend
systemctl restart backend
STAT $?