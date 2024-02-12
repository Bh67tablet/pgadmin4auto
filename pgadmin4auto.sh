#!/bin/bash
# autoinstall on ubuntu
sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
#
sudo apt -y update
#sudo apt -y dist-upgrade
sudo apt -y install curl
sudo apt -y install software-properties-common apt-transport-https wget ca-certificates libpq5 gnupg2
curl -fsSL https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/pgadmin.gpg
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'
sudo apt -y update
#sudo apt -y dist-upgrade
sudo apt -y install pgadmin4
sudo apt -y install net-tools expect
#
netstat -tulpen
cat > /home/ubuntu/ipga4w.sh << EOF
#!/usr/bin/expect
set timeout 30
spawn /usr/pgadmin4/bin/setup-web.sh --yes
expect "Email address: "
send "admin@local.domain\r"
expect "Password: "
send "Admin123\r"
expect "Retype password:"
send "Admin123\r"
expect "Apache successfully restarted."
EOF
chmod u+x /home/ubuntu/ipga4w.sh
sudo /home/ubuntu/ipga4w.sh
