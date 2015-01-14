# Defaults
class hornetq::params {

  $service       = 'running'
  $user          = 'hornetq'
  $group         = 'hornetq'
  $basedir       = '/opt/hornetq'
  $datadir       = '/opt/hornetq/data'
  $backupdir     = $basedir
  $confdir       = '/opt/hornetq/config'
  $logdir        = '/var/log/hornetq'
  $log_level     = 'DEBUG'
  $version       = 'latest'
  $configuration = 'non-clustered'
  $backup        = false

}