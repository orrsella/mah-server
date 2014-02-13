class ghost {

    # package { 'nodejs':
    #     ensure => present
    # }

    # Install semver, required by nodejs installer
    # package { 'semver':
    #     ensure   => installed,
    #     provider => gem,
    # }

    # Install nodejs
    class { 'nodejs':
        version => 'v0.10.25',
        make_install => true
    }

    # ghost version
    $version = '0.4.1'

    # file { "ghost-$version.zip":
    #     ensure => present,
    #     path => "/opt/ghost-$version/",
    #     source => "http://ghost.org/zip/ghost-$version.zip",
    #     require => Class['nodejs']
    # }

    wget::fetch { "http://ghost.org/zip/ghost-$version.zip":
        destination => "/opt/ghost-$version/ghost-$version.zip",
        timeout     => 0,
        verbose     => false,
        require     => Class['nodejs']
    }
}
