source common.sh
heading Installing mysql
dnf install mysql-server -y

heading Enable and start mysql
systemctl enable mysqld
systemctl start mysqld

heading Secure Installing mysql root password
mysql_secure_installation --set-root-pass $1
# --set-root-pass ExpenseApp@1
