# Download latest stable release using the code below or browse to github.com/drush-ops/drush/releases.
php -r "readfile('https://s3.amazonaws.com/files.drush.org/drush.phar');" > drush
# Or use our upcoming release: php -r "readfile('https://s3.amazonaws.com/files.drush.org/drush.phar');" > drush

# Test your install.
php drush core-status

# Make `drush` executable as a command from anywhere. Destination can be anywhere on $PATH.
chmod +x drush
sudo mv drush /usr/bin

# Optional. Enrich the bash startup file with completion and aliases.
drush -y init

