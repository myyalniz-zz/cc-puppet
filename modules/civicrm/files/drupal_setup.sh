#!/bin/bash

cd /usr/share/nginx
rm -rf html
sudo wget https://ftp.drupal.org/files/projects/drupal-7.38.tar.gz
sudo tar -xvzf drupal-7.38.tar.gz
sudo sudo mv drupal-7.38 html

cd /usr/share/nginx/html/sites/default
sudo mkdir files
sudo chown -R www-data files
sudo cp default.settings.php settings.php
sudo chmod 777 settings.php
