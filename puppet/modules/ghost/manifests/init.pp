class ghost {

    # Install nodejs
    class { 'nodejs':
        version => 'v0.10.25',
        make_install => false,
        target_dir => '/usr/bin'
    }

    # ghost version
    $version = '0.4.1'

    file { '/opt/ghost/':
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
            notify    => Exec['/usr/bin/npm install --production']
        }

        exec { '/usr/bin/npm install --production':
            cwd         => '/opt/ghost',
            refreshonly => true,
        }
    }

    # file { '/opt/ghost/config.js':
    #     ensure  => present,
    #     source  => 'puppet:///modules/ghost/config.js',
    #     require => File['/opt/ghost/']
    # }

    file { '/opt/ghost/content':
        ensure => link,
        target => '/opt/orrsella.com/ghost/content',
        require => File['/opt/ghost/']
    }

    file { '/opt/ghost/config.js':
        ensure => link,
        target => '/opt/orrsella.com/ghost/config.js',
        require => File['/opt/ghost/content']
    }

    # Install service control script. Can be controlled by:
    # $ service ghost start/stop/restart/
    # file { '/etc/init/ghost.conf':
    #     ensure => present,
    #     source => 'puppet:///modules/ghost/ghost.conf'
    # }

    # service { 'ghost':
    #     ensure    => running,
    #     enable    => true,
    #     subscribe => File['/opt/ghost/config.js'],
    #     require   => File['/etc/init/ghost.conf']
    # }


    # Install init.d script
    group { 'ghost':
        ensure => present
    }

    user { 'ghost':
        ensure => present,
        gid => 'ghost'
    }

    file { '/etc/init.d/ghost':
        ensure => present,
        source => 'puppet:///modules/ghost/init.d/ghost',
        owner  => 'ghost',
        group  => 'ghost',
        mode   => 755,
        require => User['ghost']
    }

    # Install service control script. Can be controlled by:
    # $ service ghost start/stop/restart/status
    service { 'ghost':
        ensure    => running,
        enable    => true,
        subscribe => File['/opt/ghost/config.js'],
        require   => File['/etc/init.d/ghost']
    }
}
