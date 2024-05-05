
echo -e "\e[31mInstalling mysql\e[0m"
dnf install mysql-server -y

echo -e "\e[31mEnable and start mysql\e[0m"
systemctl enable mysqld
systemctl start mysqld
echo -e "\e[31mSecure Installing mysql root password\e[0m"
mysql_secure_installation --set-root-pass $1
# --set-root-pass ExpenseApp@1
