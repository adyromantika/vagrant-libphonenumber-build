class buildtools {
	package { [ 'make', 'cmake', 'g++' ]:
		require => Exec['apt-get update'],
		ensure => latest,
	}
}