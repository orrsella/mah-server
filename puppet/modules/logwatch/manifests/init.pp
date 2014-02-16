class logwatch {

    package { 'logwatch':
        ensure => present
    }

    file { '/etc/cron.daily/00logwatch':
        ensure => file,
        content => "/usr/sbin/logwatch --output mail --mailto orrsella@gmail.com --detail high\n",
        require => Package['logwatch']
    }
}