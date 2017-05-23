group { "puppet":
	ensure => "present",
}

Exec { 
	path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] 
}

$hadoop_home = "/home/vagrant"

exec { 'apt-get update':
	command => 'apt-get update',
}

package { "openjdk-6-jdk" :
	ensure => present,
	require => Exec['apt-get update'],
}

exec { "download_hadoop":
	command => "wget -O /home/vagrant/hadoop1.2.1.tar.gz  https://archive.apache.org/dist/hadoop/core/hadoop-1.2.1/hadoop-1.2.1.tar.gz",
	path => $path,
	unless => "ls /home/vagrant | grep hadoop1.2.1",
	require => Package["openjdk-6-jdk"],
}

exec { "unpack_hadoop" :
	command => "tar -zxf /home/vagrant/hadoop1.2.1.tar.gz",
	path => $path,
	creates => "${hadoop_home}/hadoop1.2.1",
	require => Exec["download_hadoop"],
}
