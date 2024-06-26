source common.sh
rm -f /tmp/expense.log

if [ -z "$1" ]; then
  echo "Input MySQL Password is Missing"
  exit 1
fi

heading Installing mysql
dnf install mysql-server -y
if [ -$? -eq 0 ]; then
  echo SUCCESS
  else
  [ -$? -eq 1 ];
  echo FAILURE
fi

heading Enable and start mysql
systemctl enable mysqld &>>/tmp/expense.log
systemctl start mysqld &>>/tmp/expense.log
STAT $?

heading Secure Installing mysql root password
mysql_secure_installation --set-root-pass $1
echo exit status -$?
# --set-root-pass ExpenseApp@1
