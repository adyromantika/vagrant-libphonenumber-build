class update {
	exec { "apt-get update" :
		path => "/usr/bin"
	}

	class { 'apt':
		always_apt_update    => false,
		disable_keys         => undef,
		proxy_host           => false,
		proxy_port           => '',
		purge_sources_list   => false,
		purge_sources_list_d => false,
		purge_preferences_d  => false,
		update_timeout       => undef
	}

	include apt

	apt::source { 'puppet_debian_experimental':
	  	location          => 'http://ftp.de.debian.org/debian/',
	  	release           => 'experimental',
	  	repos             => 'main',
	  	required_packages => 'debian-keyring debian-archive-keyring',
	  	key               => '8B48AD6246925553',
	  	key_server        => 'subkeys.pgp.net',
	  	include_src       => false
	}

}
