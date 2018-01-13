#!/bin/bash
# Petit script à l'arrache, vite fait sur le gaz, pour installer nextcloud
# Se base sur docker et un container
# ça simplifie l'installation, mais c'est probablement
# plus compliqué pour installer le HTTPS
cd
mkdir tmp
cd tmp
# Mise à jour du système :
echo '>> Mise à jour du système...'
sudo apt-get update ; sudo apt-get dist-upgrade -y
echo '<< Fin mise à jour du système'
echo '>> Installation docker'
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo adduser pi docker
# (pour installer un docker récent et que le user pi fasse partie du groupe docker)
echo '<< Fin installation docker'
echo '>> Préparation machine hote'
sudo mkdir /var/www && sudo mkdir /var/www/html && sudo chown -R www-data:www-data /var/www && sudo mkdir /var/log/apache2 && sudo chown -R www-data:www-data /var/log/apache2
echo '<< Fin préparation machine hote'
echo 'ATTENTION : il faudra se déconnecter et reconnecter pour que les modifications soient prises en compte'
echo '>> Préparation machine virtuelle (container docker)'
wget https://github.com/hmag/docker/archive/master.zip
unzip -q master.zip
rm master.zip
mv docker-master docker
cd docker/hmalpine/Build
./Build.sh
echo '<< Fin préparation machine virtuelle (container docker)'
echo '>> Récupération NextCloud'
cd /var/www/html
sudo -u www-data wget https://download.nextcloud.com/server/releases/nextcloud-12.0.4.zip
sudo -u www-data unzip -q nextcloud-12.0.4.zip
sudo -u www-data rm nextcloud-12.0.4.zip 
echo '<< Fin récupération NextCloud'
echo 'Une fois déconnecté / reconnecté, lancer la machine "hmalpine" par :'
echo '/home/pi/tmp/docker/hmalpine/run_hmalpine.sh'
echo 'NextCloud est accessible sur http://<ip>/nextcloud'
