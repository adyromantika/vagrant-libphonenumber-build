class subversion {
	package { [ 'subversion' ]:
		require => [ Exec['apt-get update'] ],
		ensure => latest,
	}
}