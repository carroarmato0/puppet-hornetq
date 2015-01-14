class hornetq::package {

  # Linux-Native Asynchronous I/O Access Library
  if $::kernel == 'Linux' {
    package { 'libaio':
      ensure => installed,
      notify => Service['hornetq'],
    }
  }

  package { 'hornetq':
    ensure => $hornetq::version,
  }

}