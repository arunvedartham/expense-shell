echo Installation Nginx
dnf install nginx -y

echo Copy expense config file
cp expense.conf /etc/nginx/default.d/expense.conf

echo clean old content
rm -rf /usr/share/nginx/html/*

echo dowload frontend content
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip
cd /usr/share/nginx/html

echo extract content
unzip /tmp/frontend.zip

echo restart service
systemctl restart nginx
systemctl enable nginx



