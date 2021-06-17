#!/bin/bash
echo "VERIFICANDO INSTALACIÓN DE DEPENDENCIAS";  sleep 3; clear;
Check=$(find /usr/bin -iname "LibimobiledeviceEXE");
if test -z "$Check"; 
  then
    echo 'DESCARGANDO DEPENDENCIAS NECESARIAS'; sleep 2; echo '==============================================';
    cd /usr/bin/ && git clone https://github.com/Brayan-Villa/LibimobiledeviceEXE; 
    cd /usr/bin/LibimobiledeviceEXE/ && mv ./* ../;
    echo '=============================================='; echo '';
    echo 'COMPLETADO!'; sleep 3; point1;
  else
    read -p 'PRECIONA ENTER PARA INICIAR';
fi
  SN=$(ideviceinfo | grep -w SerialNumber | awk '{printf $NF}');
iproxy 22 44 &>>/dev/nul&rm ~/.ssh/*
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'mount -o rw,union,update /';
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'record=$(find /private/var/containers/Data/System -iname "internal"); cd $record/../ && mkdir -p private/var/mobile/Backup';
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'record=$(find /private/var/containers/Data/System -iname "internal"); cd $record/../ && cp -rp internal activation_records private/var/mobile/Backup/';
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'record=$(find /private/var/containers/Data/System -iname "private"); cd $record/../ && tar -cf /./Record ./private /./private/var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist /./private/var/mobile/Library/FairPlay /./private/var/root/Library/Lockdown';
mkdir -p ./$SN
sshpass -p 'alpine' scp -p root@localhost:/./Record ./$SN/
read -p 'VERIFIQUE EL BACKUP DE SUS ARCHIVOS CON AYUDA DE 7z';
