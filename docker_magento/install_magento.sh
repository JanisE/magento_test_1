# Install Magento.
cd /var/www/html/

composer create-project --no-interaction --repository-url=https://repo.magento.com/ magento/project-community-edition magento 2.2.1

cd magento/

bin/magento setup:install --base-url=http://127.0.0.1:8234/magento/ \
--db-host=db --db-name=magento --db-user=magento --db-password=magento \
--admin-firstname=Magento --admin-lastname=User --admin-email=user@example.com \
--admin-user=admin --admin-password=admin123 --backend-frontname=admin \
--use-rewrites=1

# Install sample data.
cp /root/.composer/auth.json ./var/composer_home/

bin/magento sampledata:deploy
bin/magento module:enable --all
php -d memory_limit=1G bin/magento setup:upgrade
bin/magento cron:run
bin/magento cache:clean
bin/magento cache:flush

# Install custom modules.
cp -r /root/app/* ./app/
bin/magento module:enable --all
php -d memory_limit=1G bin/magento setup:upgrade
bin/magento cache:clean
bin/magento cache:flush

# Permissions for the web.
find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \; && find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} \; && chown -R :www-data . && chmod u+x bin/magento

