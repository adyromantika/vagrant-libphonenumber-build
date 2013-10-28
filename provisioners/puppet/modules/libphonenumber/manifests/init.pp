class libphonenumber {

	$runas = "vagrant"

	case $runas {
		root: { 
			$workpath = "/usr/src"
		}
		default: {
			$workpath = "/home/${runas}"
		}
	}

	package { [ 'protobuf-compiler', 'libprotobuf-dev', 'libgtest-dev', 'libre2-dev', 'libicu-dev', 'libboost-dev', 'libboost-thread-dev' ]:
		require => [ Exec['apt-get update'], Class['update'] ],
		ensure => latest,
	}

	exec { "update source":
		command => "sudo -u ${runas} svn up",
		path => "/usr/bin",
		cwd => "${workpath}/libphonenumber-read-only",
		onlyif => "test -d ${workpath}/libphonenumber-read-only",
		require => Class["subversion"],
	}

	exec { "get source":
		command => "sudo -u ${runas} svn co http://libphonenumber.googlecode.com/svn/trunk libphonenumber-read-only",
		path => "/usr/bin",
		cwd => "${workpath}",
		onlyif => "test ! -d ${workpath}/libphonenumber-read-only",
		require => Class["subversion"],
	}

	file { 'build':
		path => "${workpath}/libphonenumber-read-only/cpp/build",
		ensure => directory,
		owner => $runas,
		group => $runas,
		purge => false,
		require => [ Exec["update source"], Exec["get source"] ],
	}

	file { 'libphonenumber-build.sh':
		path => "${workpath}/libphonenumber-build.sh",
		ensure => file,
		owner => $runas,
		group => $runas,
		mode => 755,
		#source => 'puppet:///modules/libphonenumber/build.sh'
		content => template('libphonenumber/build.erb'),
	}

	file { 'libphonenumber-install.sh':
		path => "${workpath}/libphonenumber-install.sh",
		ensure => file,
		owner => $runas,
		group => $runas,
		mode => 755,
		#source => 'puppet:///modules/libphonenumber/install.sh'
		content => template('libphonenumber/install.erb'),
	}
}
