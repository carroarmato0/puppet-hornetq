# puppet-hornetq
Puppet module for Hornetq

This module manages the installation and configuration of the Hornetq messaging system.

## Requirements

You will need to have a working copy of Java 7 or greater, either installed with a package statement or managed through a dedicated Java Puppet Module (recommended).

Concat puppet module

## Notes

The module assumes hornetq is installed in /opt/hornet


## Usage

# Instantiation

```
include {'hornetq':}
```

# Use alternative configuration file location not managed by puppet

```
class {'hornetq':
  confdir       => '/opt/hornetq/config', # needed in combination with configuration
  configuration => 'non-clustered',
}
```

# Take a tar.gz copy of the data folder upon automated version or package change

```
class {'hornetq':
  backup    => true,
  backupdir => '/srv/backup/hornetq,
}
```

# non-cluster configuration example

```
include hornetq

class {'hornetq::configuration':
  connectors        => [
    {
      name   => 'netty',
      params => {
        host => '${hornetq.remoting.netty.host:localhost}',
        port => '${hornetq.remoting.netty.port:5445}',
      },
    },
    {
      name   => 'netty-throughput',
      params => {
        host          => '${hornetq.remoting.netty.host:localhost}',
        port          => '${hornetq.remoting.netty.port:5455}',
        'batch-delay' => '50',
      },
    },
  ],
  acceptors         => [
    {
      name   => 'netty',
      params => {
        host          => '${hornetq.remoting.netty.host:localhost}',
        port          => '${hornetq.remoting.netty.batch.port:5455}',
      },
    },
    {
      name   => 'netty-throughput',
      params => {
        host              => '${hornetq.remoting.netty.host:localhost}',
        port              => '${hornetq.remoting.netty.batch.port:5455}',
        'batch-delay'     => '50',
        'direct-delivery' => "false",
      },
    },
  ],
  security_settings => [
    {
      match   => '#',
      permissions => [
        { type  => 'createNonDurableQueue', roles => 'guest', },
        { type  => 'deleteNonDurableQueue', roles => 'guest', },
        { type  => 'consume',               roles => 'guest', },
        { type  => 'send',                  roles => 'guest', },
      ],
    },
  ],
  address_settings  => [
    {
      match                               => '#',
      'redelivery-delay'                  => '0',
      'max-delivery-attempts'             => '5',
      'dead-letter-address'               => 'jms.queue.DLQ',
      'expiry-address'                    => 'jms.queue.ExpiryQueue',
      'message-counter-history-day-limit' => '10',
      'max-size-bytes'                    => '10485760',
      'page-size-bytes'                   => '10485760',
      'address-full-policy'               => 'BLOCK',
      'redistribution-delay'              => '0',
    },
  ]
}
```