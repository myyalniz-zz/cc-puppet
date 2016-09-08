  

class nginx_repo {

   file { '/etc/apt/sources.list.d/nginx.list':
     path         => '/etc/apt/sources.list.d/nginx.list',
     ensure       => present,
     source       => ['puppet:///modules/civicrm/nginx.list'],
     require	  => File['/opt/civicrm/nginx_signing.key']
   }
   file { '/opt/civicrm':
     path	  => '/opt/civicrm',
     ensure       => directory,
   }
   file { '/opt/civicrm/nginx_signing.key':
     path         => '/opt/civicrm/nginx_signing.key',
     ensure       => present,
     source       => ['puppet:///modules/civicrm/nginx_signing.key'],
     require	  => File['/opt/civicrm']
   }
  
   exec {'nginx repo key':
    require => File['/opt/civicrm/nginx_signing.key'],
    command => "/usr/bin/apt-key add /opt/civicrm/nginx_signing.key",
   }
}

class php5_repo {

   file { '/etc/apt/sources.list.d/php5.list':
     path         => '/etc/apt/sources.list.d/php5.list',
     ensure       => present,
     source       => ['puppet:///modules/civicrm/php5.list'],
     require	  => File['/opt/civicrm/php5_signing.key']
   }
   file { '/opt/civicrm/php5_signing.key':
     path         => '/opt/civicrm/php5_signing.key',
     ensure       => present,
     source       => ['puppet:///modules/civicrm/php5_signing.key'],
     require	  => File['/opt/civicrm']
   }

   exec {'php5 repo key':
    require => File['/opt/civicrm/php5_signing.key'],
    command => "/usr/bin/apt-key add /opt/civicrm/php5_signing.key",
   }

}

class installations {
   exec { 'apt-update':
    command => '/usr/bin/apt-get update',
   }

   package  { 'php5':
    ensure  => latest,
   }
   package  { 'python-software-properties':
    ensure  => latest,
   }
   package  { 'php-pear':
    ensure  => latest,
   }
   package  { 'php5-cli':
    ensure  => latest,
   }
   package  { 'php5-common':
    ensure  => latest,
   }
   package  { 'php5-curl':
    ensure  => latest,
   }
   package  { 'php5-fpm':
    ensure  => latest,
   }
   package  { 'php5-gd':
    ensure  => latest,
   }
   package  { 'php5-json':
    ensure  => latest,
   }
   package  { 'php5-mcrypt':
    ensure  => latest,
   }
   package  { 'php5-mysql':
    ensure  => latest,
   }
   package  { 'php5-readline':
    ensure  => latest,
   }
   package  { 'nginx':
    ensure  => latest,
   }
   package  { 'mysql-server':
    ensure  => latest,
   }
   package  { 'mysql-client':
    ensure  => latest,
   }
}

class mysql_setup {
   file { '/opt/civicrm/mysql_permissions.sql':
     path         => '/opt/civicrm/mysql_permissions.sql',
     ensure       => present,
     source       => ['puppet:///modules/civicrm/mysql_permissions.sql'],
     require	  => File['/opt/civicrm']
   }
   exec {'create mysql permissions':
    require => File['/opt/civicrm/mysql_permissions.sql'],
    command => "/usr/bin/mysql -u root < /opt/civicrm/mysql_permissions.sql",
   }

}

class drupal_setup {

   file { '/opt/civicrm/drupal_setup.sh':
     path         => '/opt/civicrm/drupal_setup.sh',
     ensure       => present,
     source       => ['puppet:///modules/civicrm/drupal_setup.sh'],
     require	  => File['/opt/civicrm']
   }
   exec {'Extract drupal files':
    require => File['/opt/civicrm/drupal_setup.sh'],
    command => "/bin/bash /opt/civicrm/drupal_setup.sh",
   }

}

class drush_setup {

   file { '/opt/civicrm/drush_setup.sh':
     path         => '/opt/civicrm/drush_setup.sh',
     ensure       => present,
     source       => ['puppet:///modules/civicrm/drush_setup.sh'],
     require	  => File['/opt/civicrm']
   }
   exec {'Execute drush install':
    require => File['/opt/civicrm/drush_setup.sh'],
    command => "/bin/bash /opt/civicrm/drush_setup.sh",
   }

}

class nginx_config {

   file { '/etc/nginx/conf.d/default.nginx.conf':
     path         => '/etc/nginx/conf.d/default.nginx.conf',
     ensure       => present,
     source       => ['puppet:///modules/civicrm/default.nginx'],
     require	  => File['/opt/civicrm']
   }
   file { '/etc/nginx/conf.d/default-ssl.nginx.conf':
     path         => '/etc/nginx/conf.d/default-ssl.nginx.conf',
     ensure       => present,
     source       => ['puppet:///modules/civicrm/default-ssl.nginx'],
     require	  => File['/opt/civicrm']
   }
   exec {'Enable https config':
    command => "/bin/rm -f /etc/nginx/conf.d/default.conf",
   }

}

class memory_limit {
   exec {'Change memory limit':
    command => "/bin/sed -i -e 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php5/fpm/php.ini",
   }
}

class mysql_ini {

   file { '/etc/mysql/my.cnf':
     path         => '/etc/mysql/my.cnf',
     ensure       => present,
     source       => ['puppet:///modules/civicrm/my.cnf'],
     require	  => File['/opt/civicrm'],
     notify 	  => Exec['Reload mysql']
   }
   exec {'Reload mysql':
     command => "/etc/init.d/mysql reload",
     subscribe => File['/etc/mysql/my.cnf']
   }

}

node 'ip-172-31-28-212' {
	include nginx_repo 
	include php5_repo 
	include installations 
	include mysql_setup
	include drupal_setup
	include drush_setup
	include nginx_config
	include memory_limit
	include mysql_ini
}

node default {
	include nginx_repo 
	include php5_repo 
}
