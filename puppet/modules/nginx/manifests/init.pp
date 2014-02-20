class nginx {

    package { 'nginx':
        ensure => present
    }

    file { '/etc/nginx/nginx.conf':
        ensure  => present,
        source  => 'puppet:///modules/nginx/nginx.conf',
        require => Package['nginx']
    }

    file { '/etc/nginx/sites-available/ghost.conf':
        ensure  => present,
        source  => 'puppet:///modules/nginx/sites-available/ghost.conf',
        require => File['/etc/nginx/nginx.conf']
    }

    file { '/etc/nginx/sites-enabled/ghost.conf':
        ensure  => link,
        target  => '/etc/nginx/sites-available/ghost.conf',
        require => File['/etc/nginx/sites-available/ghost.conf'],
        before  => Service['nginx']
    }

    service { 'nginx':
        ensure    => running,
        enable    => true,
        subscribe => [File['/etc/nginx/sites-available/ghost.conf'], File['/etc/nginx/nginx.conf']]
    }
}
