# Puppet Hornetq Module
#
# $user      		User owning the files and daemon user
# $group     		Group owning the files
# $basedir   		Installation directory of Hornetq
# $log       		Location of the log file
# $log_level 		Set the log level in the log file

class hornetq (
	$user      		 = $hornetq::params::user,
	$group     		 = $hornetq::params::group,
	$basedir   		 = $hornetq::params::basedir,
	$log       		 = $hornetq::params::log,
	$log_level 		 = $hornetq::params::log_level,
	$configuration = $hornetq::params::configuration,
) inherits hornetq::params {

	include hornetq::package
	include hornetq::config
	include hornetq::service

	Class['hornetq::package'] ->
	Class['hornetq::config'] ->
	Class['hornetq::service']

	## Checks

  if (!( $log_level in ['ALL','OFF','DEBUG','FINEST','FINER','FINE','CONFIG','INFO','WARNING','SEVERE'])){
    fail('Unrecognized log level, use ALL, OFF, DEBUG, FINEST, FINER, FINE, CONFIG, INFO, WARNING, or SEVERE')
  }

  if (!( $configuration in ['clustered','non-clustered','replicated','shared-store'])){
    fail('Unrecognized configuration, use clustered, non-clustered, replicated or shared-store')
  }

}