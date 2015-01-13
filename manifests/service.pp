class hornetq::service {

	service { 'hornetq':
		enable      => true,
		ensure      => running,
		hasrestart  => true,
		hasstatus   => true,
		require     => Class['hornetq'],
	}

}