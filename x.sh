#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
echo -e "Your FORTA UPDATE STARTED"
systemctl stop forta.service
echo -e "YOUR FORTA VERSION IS:"
forta version
echo -e "STOP FORTA SERVICE WAIT 10 sec"
sleep 10
cd $HOME
mkdir -p forta_backup
echo -e "Backup folder created"
cp -r .forta forta_backup/
cp /lib/systemd/system/forta.service forta_backup/
sleep 1
echo -e "Backup .forta and service created!"

apt update && sudo apt upgrade forta -y
cd $HOME
cp forta_backup/forta.service /lib/systemd/system/
echo -e "Restarting all services wait 5 sec"
sleep 1
systemctl daemon-reload
sleep 1
systemctl restart forta.service
sleep 3
forta version
sleep 1
watch 'forta status'
