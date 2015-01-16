class hornetq::config {

  user { 'hornetq':
    comment => 'hornetq user',
    home    => '/opt/hornetq',
    ensure  => present,
    system  => true,
  }

  group {'hornetq':
    ensure => present,
    system => true,
  }

  # Service Script
  file { '/etc/init.d/hornetq':
    ensure    => file,
    mode      => '0755',
    content   => template('hornetq/hornetq.service2.erb'),
    notify    => [Exec['stop hornetq'],Service['hornetq']],
  }

  file { $hornetq::basedir:
    ensure => directory,
     owner  => $hornetq::user,
     group  => $hornetq::group,
  }

  file { "${hornetq::basedir}/config":
    ensure => directory,
    owner  => $hornetq::user,
    group  => $hornetq::group,
  }

  file { "${hornetq::basedir}/config/stand-alone/${hornetq::configuration}":
    ensure  => directory,
    owner   => $hornetq::user,
    group   => $hornetq::group,
  }

  exec { 'stop hornetq':
    command     => 'service hornetq stop',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin:/sbin',
    refreshonly => true,
  }

  file { $hornetq::logdir:
    ensure => directory,
    owner  => $hornetq::user,
    group  => $hornetq::group,
  }

  file { $hornetq::datadir:
    ensure => directory,
    owner  => $hornetq::user,
    group  => $hornetq::group,
  }

  # Logging properties
  file { "${hornetq::basedir}/config/logging.properties":
    ensure  => file,
    content => template('hornetq/logging.properties.erb'),
  }

  if $hornetq::backup {
    # Only backup if there is actual data in the data directory
    exec { 'Backup Data':
      command     => "tar -zcvf ${hornetq::backupdir}/data-`date +%F-%T`.tar.gz ${hornetq::datadir}",
      path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      subscribe   => Package['hornetq'],
      onlyif      => "ls -A ${hornetq::datadir}",
      refreshonly => true,
    }
  }

}