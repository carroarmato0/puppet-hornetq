class hornetq::configuration (
  $queues               = undef,
  $bridges              = undef,
  $connectors           = undef,
  $acceptors            = undef,
  $broadcast_groups     = undef,
  $discovery_groups     = undef,
  $cluster_connections  = undef,
  $security_settings    = undef,
  $address_settings     = undef,
  $connection_factories = undef,
  $jms_queues           = undef,
) inherits hornetq  {

  ##
  # hornetq-beans.xml
  ##

  file { "${hornetq::confdir}/stand-alone/puppet/hornetq-beans.xml":
    ensure  => file,
    owner   => $hornetq::user,
    group   => $hornetq::group,
    content => template('hornetq/hornetq-beans.xml'),
    notify  => Service['hornetq'],
  }

  ##
  # hornetq-configuration.xml
  ##

  concat { "${hornetq::confdir}/stand-alone/puppet/hornetq-configuration.xml":
    owner   => $hornetq::user,
    group   => $hornetq::group,
    notify  => Service['hornetq'],
  }

  concat::fragment {'conf_head':
    target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-configuration.xml",
    content => template('hornetq/conf/conf_head.erb'),
    order   => '00',
  }

  concat::fragment {'conf_tail':
    target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-configuration.xml",
    content => template('hornetq/conf/conf_tail.erb'),
    order   => '99',
  }

  if $queues != undef {
    concat::fragment {'conf_queues':
      target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-configuration.xml",
      content => template('hornetq/conf/conf_queues.erb'),
      order   => '05',
    }
  }

  if $bridges != undef {
    concat::fragment {'conf_bridges':
      target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-configuration.xml",
      content => template('hornetq/conf/conf_bridges.erb'),
      order   => '10',
    }
  }

  if $connectors != undef {
    concat::fragment {'conf_connectors':
      target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-configuration.xml",
      content => template('hornetq/conf/conf_connectors.erb'),
      order   => '15',
    }
  }

  if $acceptors != undef {
    concat::fragment {'conf_acceptors':
      target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-configuration.xml",
      content => template('hornetq/conf/conf_acceptors.erb'),
      order   => '20',
    }
  }

  if $broadcast_groups != undef {
    concat::fragment {'conf_broadcast_groups':
      target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-configuration.xml",
      content => template('hornetq/conf/conf_broadcast_groups.erb'),
      order   => '25',
    }
  }

  if $discovery_groups != undef {
    concat::fragment {'conf_discovery_groups':
      target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-configuration.xml",
      content => template('hornetq/conf/conf_discovery_groups.erb'),
      order   => '30',
    }
  }

  if $cluster_connections != undef {
    concat::fragment {'conf_cluster_connections':
      target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-configuration.xml",
      content => template('hornetq/conf/conf_cluster_connections.erb'),
      order   => '35',
    }
  }

  if $security_settings != undef {
    concat::fragment {'conf_security_settings':
      target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-configuration.xml",
      content => template('hornetq/conf/conf_security_settings.erb'),
      order   => '40',
    }
  }

  if $address_settings != undef {
    concat::fragment {'conf_address_settings':
      target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-configuration.xml",
      content => template('hornetq/conf/conf_address_settings.erb'),
      order   => '99',
    }
  }

  ##
  # hornetq-jms.xml
  ##

  concat { "${hornetq::confdir}/stand-alone/puppet/hornetq-jms.xml":
    owner   => $hornetq::user,
    group   => $hornetq::group,
    notify  => Service['hornetq'],
  }

  concat::fragment {'jms_head':
    target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-jms.xml",
    content => template('hornetq/conf/jms_head.erb'),
    order   => '00',
  }

  concat::fragment {'jms_tail':
    target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-jms.xml",
    content => template('hornetq/conf/jms_tail.erb'),
    order   => '99',
  }

  if $connection_factories != undef {
    concat::fragment {'jms_connection_factory':
      target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-jms.xml",
      content => template('hornetq/conf/jms_connection_factory.erb'),
      order   => '05',
    }
  }

  if $jms_queues != undef {
    concat::fragment {'jms_queues':
      target  => "${hornetq::confdir}/stand-alone/puppet/hornetq-jms.xml",
      content => template('hornetq/conf/jms_queues.erb'),
      order   => '10',
    }
  }

  ##
  # hornetq-users.xml
  ##

  file { "${hornetq::confdir}/stand-alone/puppet/hornetq-users.xml":
    ensure  => file,
    owner   => $hornetq::user,
    group   => $hornetq::group,
    content => template('hornetq/hornetq-users.xml'),
    notify  => Service['hornetq'],
  }

  ##
  # jndi.properties
  ##

  file { "${hornetq::confdir}/stand-alone/puppet/jndi.properties":
    ensure  => file,
    owner   => $hornetq::user,
    group   => $hornetq::group,
    content => template('hornetq/jndi.properties'),
    notify  => Service['hornetq'],
  }

  ##
  # logging.properties
  ##

  file { "${hornetq::confdir}/stand-alone/puppet/logging.properties":
    ensure  => file,
    owner   => $hornetq::user,
    group   => $hornetq::group,
    content => template('hornetq/logging.properties.erb'),
    notify  => Service['hornetq'],
  }

}