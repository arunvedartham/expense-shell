source common.sh
rm -f /tmp/expense.log

if [ -z "$1" ]; then
  echo "Input MySQL Password is Missing"
  exit 1
fi

heading "Disable NodeJS default version"
dnf module disable nodejs -y &>>/tmp/expense.log
STAT $?

heading "Enable NodeJS 20"
dnf module enable nodejs:20 -y &>>/tmp/expense.log
STAT $?

heading "Install NodeJS"
dnf install nodejs -y &>>/tmp/expense.log
STAT $?

# useradd expense

heading "Add Expense User"
id expense &>>/tmp/expense.log
if [ $? -ne 0 ]; then
  useradd expense &>>/tmp/expense.log
fi
STAT $?

# cp backend.service /etc/systemd/system/backend.service

heading "Setup Backend Service"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
STAT $?

heading "Delete Existing Application Directory"
rm -rf /app
STAT $?

# mkdir /app

heading "Create Application Directory"
mkdir /app &>>/tmp/expense.log
STAT $?

# curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip

heading "Download Backend Code"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
STAT $?

cd /app

# unzip /tmp/backend.zip

heading "Extract Backend code"
unzip /tmp/backend.zip &>>/tmp/expense.log
STAT $?

# npm install

heading "Download NodeJS App Dependencies"
npm install &>>/tmp/expense.log
STAT $?

# dnf install mysql -y

heading "Install MySQL Client"
dnf install mysql -y &>>/tmp/expense.log
STAT $?

# mysql -h 172.31.30.152 -uroot -pExpenseApp@1 < /app/schema/backend.sql

heading "Load Schema"
mysql -h 172.31.24.141 -uroot -p$1 < /app/schema/backend.sql &>>/tmp/expense.log
STAT $?

heading "Start Backend Service"
systemctl daemon-reload
systemctl enable backend
systemctl restart backend
STAT $?
