class ghost {

    # Install nodejs
    class { 'nodejs':
        version => 'v0.10.25',
        make_install => true
    }

    # ghost version
    $version = '0.4.1'

    file { "/opt/ghost/":
        ensure  => directory
    }

    # hack to only extract the archive it ghost doesn't already exist
    $ghost = file('/opt/ghost/package.json', '/dev/null')

    if ($ghost == '') {
        archive { "ghost-$version":
            ensure    => present,
            url       => "http://ghost.org/zip/ghost-$version.zip",
            extension => 'zip',
            checksum  => false,
            target    => '/opt/ghost',
            require   => File['/opt/ghost/'],
            notify    => Exec['/usr/local/node/node-default/bin/npm install --production']
        }
    }

    exec { '/usr/local/node/node-default/bin/npm install --production':
        cwd         => '/opt/ghost',
        refreshonly => true,
    }

    file { '/opt/ghost/config.js':
        ensure  => present,
        source  => 'puppet:///modules/ghost/config.js',
        require => File['/opt/ghost/']
    }

    file { '/etc/init/ghost.conf':
        ensure => present,
        source => 'puppet:///modules/ghost/ghost.conf'
    }

    service { 'ghost':
        ensure    => running,
        enable    => true,
        subscribe => File['/opt/ghost/config.js'],
        require   => File['/etc/init/ghost.conf']
    }
}
