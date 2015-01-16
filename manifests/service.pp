class hornetq::service {

  service { 'hornetq':
    ensure      => $hornetq::service,
    enable      => true,
    hasrestart  => true,
    hasstatus   => true,
    subscribe   => Package['hornetq'],
    require     => Class['hornetq'],
  }

}