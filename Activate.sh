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
sshpass -p 'alpine' scp -p $SN/Records root@localhost:'/./';
sshpass -p 'alpine' scp -p ./chflags root@localhost:'/./usr/bin/';
sshpass -p 'alpine' scp -p ./ldrestart root@localhost:'/./usr/bin/';
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'chmod 00755 /usr/bin/chflags'; 
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'chmod 00755 /usr/bin/ldrestart'; 
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'cd /System/Library && launchctl unload LaunchDaemons/com.apple.mobileactivationd.plist';
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'tar -xvf /./Records -C /./';
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'rm /./Records';
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'record=$(find /private/var/containers/Data/System -iname "internal"); cd $record/../ && cp -rp /private/var/mobile/Backup/* ./';
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'rm -rf /private/var/mobile/Backup';
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'record=$(find /private/var/containers/Data/System -iname "internal"); cd $record/../ && chown -R mobile ./*'; 
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'record=$(find /private/var/containers/Data/System -iname "internal"); cd $record/../ && chmod -R 00666 ./*'; 
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'record=$(find /private/var/containers/Data/System -iname "internal"); cd $record/../ && chflags -R uchg ./*'; 
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'cd /System/Library && launchctl load LaunchDaemons/com.apple.mobileactivationd.plist';
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'uicache --all';
sshpass -p 'alpine' ssh -o StricthostKeyChecking=no root@localhost 'ldrestart';
read -p 'Verifique';
