source common.sh
heading Installing mysql
dnf install mysql-server -y
echo exit status -$?

heading Enable and start mysql
systemctl enable mysqld
systemctl start mysqld
echo exit status -$?

heading Secure Installing mysql root password
mysql_secure_installation --set-root-pass $1
echo exit status -$?
# --set-root-pass ExpenseApp@1
