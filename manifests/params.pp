# Defaults
class hornetq::params {

  $user          = 'hornetq'
  $group         = 'hornetq'
  $basedir       = '/opt/hornetq'
  $log_level     = 'DEBUG'
  $log           = '/var/log/hornetq/hornetq.log'
  $configuration = 'non-clustered'

}