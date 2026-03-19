#!/bin/bash

# SDGAMER Banner
cat << "EOF"
  ____  ____   ____    _    __  __ _____ ____  
 / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ 
 \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |
  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < 
 |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\

EOF

# Backup Check Prompt
while true; do
    read -p "Do you take a backup? (y/n): " yn
    case $yn in
        [Yy]* ) 
            echo "Starting SDGAMER Addon Installation..."
            sleep 2
            break
            ;;
        [Nn]* ) 
            echo "Installation cancelled. Returning to previous menu..."
            exit 0
            ;;
        * ) 
            echo "Please answer y or n."
            ;;
    esac
done

# Original Installation Commands
git clone https://github.com/sdgamer8263-sketch/adon.git
cd adon
cd Email
sudo mv /root/adon/Email/1.zip /var/www/pterodactyl/
sudo mv /root/adon/Email/app.php /var/www/pterodactyl/config/
sudo mv /root/adon/Email/admin.blade.php /var/www/pterodactyl/resources/views/layouts/
sudo mv /root/adon/Email/AccountCreated.php /var/www/pterodactyl/app/Notifications/
sudo mv /root/adon/Email/SendPasswordReset.php /var/www/pterodactyl/app/Notifications/
sudo mv /root/adon/Email/AddedToServer.php /var/www/pterodactyl/app/Notifications/
sudo mv /root/adon/Email/RemovedFromServer.php /var/www/pterodactyl/app/Notifications/
sudo mv /root/adon/Email/ServerInstalled.php /var/www/pterodactyl/app/Notifications/
sudo mv /root/adon/Email/MailTested.php /var/www/pterodactyl/app/Notifications/

cd /var/www/pterodactyl
yes | unzip 1.zip
COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader
php artisan migrate --seed --force
php artisan view:clear
php artisan cache:clear
php artisan queue:restart
chown -R www-data:www-data /var/www/pterodactyl/*

# Cleanup
sudo rm -rf /root/adon
rm 1.zip

echo "Installation Complete!"
