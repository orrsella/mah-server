class ghost {

    # Install nodejs
    $node_ver = 'v0.10.25'

    class { 'nodejs':
        version      => $node_ver,
        make_install => false,
        with_npm     => true,
        target_dir   => '/usr/local/bin'
    }

    file { '/usr/bin/node':
        ensure  => link,
        target  => "/usr/local/node/node-$node_ver/bin/node",
        require => Class['nodejs']
    }

    file { '/usr/bin/npm':
        ensure  => link,
        target  => "/usr/local/node/node-$node_ver/bin/npm",
        require => Class['nodejs']
    }

    # ghost version
    $ghost_ver = '0.4.1'

    file { '/opt/ghost/':
        ensure  => directory
    }

    # hack to only extract the archive it ghost doesn't already exist
    $ghost = file('/opt/ghost/package.json', '/dev/null')

    if ($ghost == '') {
        archive { "ghost-$ghost_ver":
            ensure    => present,
            url       => "http://ghost.org/zip/ghost-$ghost_ver.zip",
            extension => 'zip',
            checksum  => false,
            target    => '/opt/ghost',
            require   => [File['/opt/ghost/'], Package['unzip']],
            notify    => Exec['/usr/bin/npm install --production']
        }
    }

    exec { '/usr/bin/npm install --production':
        cwd         => '/opt/ghost',
        refreshonly => true,
        require     => [File['/user/bin/npm'], File['/opt/ghost/package.json']]
    }

    file { '/opt/ghost/config.js':
        ensure  => present,
        source  => 'puppet:///modules/ghost/config.js',
        require => File['/opt/ghost/']
    }

    file { '/opt/ghost/content':
        ensure => link,
        target => '/opt/orrsella.com/ghost/content',
        require => File['/opt/ghost/']
    }

    file { '/etc/init.d/ghost':
        ensure  => present,
        source  => 'puppet:///modules/ghost/init.d/ghost',
        mode    => 755
    }

    # Install service control script. Can be controlled by: $ service ghost start/stop/restart/status
    service { 'ghost':
        ensure      => running,
        enable      => true,
        hasstatus   => true,
        hasrestart  => true,
        require     => File['/etc/init.d/ghost']
    }
}
