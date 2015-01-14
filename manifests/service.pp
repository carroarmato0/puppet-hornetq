class hornetq::service {

  service { 'hornetq':
    enable      => true,
    ensure      => $hornetq::service,
    hasrestart  => true,
    hasstatus   => true,
    subscribe   => Package['hornetq'],
    require     => Class['hornetq'],
  }

}