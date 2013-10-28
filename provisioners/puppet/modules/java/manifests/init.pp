class java {
  exec { "download java" :
		command => "wget --no-check-certificate --no-cookies --header \"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com\" \"http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jre-7u45-linux-x64.tar.gz\"",
		path => "/usr/bin",
		cwd => "/tmp",
		onlyif => "test ! -d /opt/jre1.7.0_45",
	}

	exec { "extract java" :
		command => "tar xfvz /tmp/jre-7u45-linux-x64.tar.gz",
		path => [ "/bin", "/usr/bin" ],
		cwd => "/opt",
		require => Exec["download java"],
		onlyif => "test ! -d /opt/jre1.7.0_45",
	}

	file { 'java.sh':
		path => '/etc/profile.d/java.sh',
		ensure => file,
		owner => root,
		group => root,
		mode => 644,
		source => 'puppet:///modules/java/java.sh',
		require => [ Exec["download java"], Exec["extract java"] ]
	}
}
