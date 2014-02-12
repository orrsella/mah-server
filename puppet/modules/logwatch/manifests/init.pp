class logwatch($email) {

    # Install Logwatch To Keep An Eye On Things
    package { 'logwatch':
        ensure => present
    }

    file { '/etc/cron.daily/00logwatch':
        ensure => file,
        content => "/usr/sbin/logwatch --output mail --mailto $email --detail high",
        require => Package['logwatch']
    }
}