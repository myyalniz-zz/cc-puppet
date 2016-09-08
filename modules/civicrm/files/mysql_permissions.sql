create database IF NOT EXISTS drupal_cvc ;
use drupal_cvc;
grant all on drupal_cvc.* to 'drupaluser_cvc'@'localhost' identified by 'drplcvc2016' ;

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, TRIGGER, CREATE ROUTINE, ALTER ROUTINE ON civicrm.* TO 'civicrm_user'@'localhost' IDENTIFIED BY 'cvcrm2016';

GRANT SELECT ON civicrm.* TO 'drupaluser_cvc'@'localhost' ;
