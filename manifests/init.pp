# Puppet Hornetq Module
#
# $service            Ensure Hornet is running or stopped [running (default)|stopped]
# $user               User owning the files and daemon user
# $group              Group owning the files
# $basedir            Installation directory of Hornetq
# $datadir            Location where the persistent data is kept
# $confdir            Location where the configurations are stored
# $logdir             Location where the hornetq.log file will be placed
# $log_level          Set the log level in the log file
# $version            Manage version of the package
# $backup             Perform a copy of the data upon AUTOMATED version/package change [true|false (default)]
# $backupdir          Location where the backup of the data will be placed (same directory by default)
# $configuration      Folder name within the confdir containing the actual configuration xml's (default is 'puppet' which is fully managed)
# $java_xms           Set Java's initial memory allocation pool
# $java_xmx           Set Java's maximum memory allocation pool
# $java_extra_args    Pass extra arguments to the java init script
class hornetq (
  $service          = $hornetq::params::service,
  $user             = $hornetq::params::user,
  $group            = $hornetq::params::group,
  $basedir          = $hornetq::params::basedir,
  $datadir          = $hornetq::params::datadir,
  $confdir          = $hornetq::params::confdir,
  $logdir           = $hornetq::params::logdir,
  $log_level        = $hornetq::params::log_level,
  $version          = $hornetq::params::version,
  $backup           = $hornetq::params::backup,
  $backupdir        = $hornetq::params::backupdir,
  $configuration    = $hornetq::params::configuration,
  $java_xms         = $hornetq::params::java_xms,
  $java_xmx         = $hornetq::params::java_xmx,
  $java_extra_args  = undef,
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

}