#!/bin/bash
# installation de NextCloud sur un raspberry pi vierge
# sans utiliser docker (donc installation sur le host)
# attention : tente d'installer php7 depuis les dépôts,
# donc plutôt orienté raspbian stretch...
echo '>> Installation des packages nécessaires : '
sudo apt-get install -y apache2 php7.0-xml php7.0-cgi php7.0-mbstring php7.0-gd php7.0-curl php7.0-zip php7.0-sqlite3
sudo apt-get install -y php7.0-mcrypt php7.0-soap php7.0-bz2 php7.0-intl php-smbclient php7.0-gmp php-apcu php-memcached php-imagick libapache2-mod-php7.0
echo '<< Fin de l'installation des packages nécessaires'
echo '>> Récupération de NextCloud'
cd /var/www/html
# Récupération des fichiers 
sudo wget https://download.nextcloud.com/server/releases/nextcloud-12.0.4.zip
# Dézipper le résultat du téléchargement ...
sudo unzip -q nextcloud-12.0.4.zip
# Supprimer le zip devenu inutile
sudo rm nextcloud-12.0.4.zip
# Rendre www-data (user utilisé par le serveur web) propriétaire de nextcloud
sudo chown -R www-data:www-data /var/www/html/nextcloud
echo '<< Fin récupération NextCloud'
echo 'NextCloud est accessible sur http://<ip>/nextcloud'
cat << EOF
# Ajouter dans le fichier /etc/apache2/sites-available/000-default :
        <Directory />
                Options FollowSymLinks
                AllowOverride All
                Require all granted
        </Directory>
        <Directory /var/www/html/ >
                Options FollowSymLinks
                AllowOverride All
                Require all granted
        </Directory>
# et faire "sudo service apache2 reload " pour recharger la config
EOF

