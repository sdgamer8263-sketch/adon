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
sudo rm -rf /root/adon
rm 1.zip
