# Puppet Hornetq Module
#
# $service      Ensure Hornet is running or stopped [running (default)|stopped]
# $user         User owning the files and daemon user
# $group        Group owning the files
# $basedir      Installation directory of Hornetq
# $datadir      Location where the persistent data is kept
# $confdir      Location where the configurations are stored
# $version      Manage version of the package
# $log          Location of the log file
# $log_level    Set the log level in the log file
# $backup       Perform a copy of the data upon AUTOMATED version/package change [true|false (default)]
# $backupdir    Location where the backup of the data will be placed (same directory by default)
class hornetq (
  $service       = $hornetq::params::service,
  $user          = $hornetq::params::user,
  $group         = $hornetq::params::group,
  $basedir       = $hornetq::params::basedir,
  $datadir       = $hornetq::params::datadir,
  $confdir       = $hornetq::params::confdir,
  $version       = $hornetq::params::version,
  $log           = $hornetq::params::log,
  $log_level     = $hornetq::params::log_level,
  $backup        = $hornetq::params::backup,
  $backupdir     = $hornetq::params::backupdir,
  $configuration = $hornetq::params::configuration,
) inherits hornetq::params {

  include hornetq::package
  include hornetq::config
  include hornetq::service

  Class['hornetq::package'] ->
  Class['hornetq::config'] ->
  Class['hornetq::service']

  ## Checks

  if (!( $service in ['running','stopped'])){
    fail('Unrecognized service, use running or stopped')
  }

  if (!( $log_level in ['ALL','OFF','DEBUG','FINEST','FINER','FINE','CONFIG','INFO','WARNING','SEVERE'])){
    fail('Unrecognized log level, use ALL, OFF, DEBUG, FINEST, FINER, FINE, CONFIG, INFO, WARNING, or SEVERE')
  }

  if (!( $configuration in ['clustered','non-clustered','replicated','shared-store'])){
    fail('Unrecognized configuration, use clustered, non-clustered, replicated or shared-store')
  }



}