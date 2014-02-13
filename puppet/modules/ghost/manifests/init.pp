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

    file { "/opt/ghost-$version/":
        ensure  => directory
    }

    # wget::fetch { "http://ghost.org/zip/ghost-$version.zip":
    #     destination => "/opt/ghost-$version/ghost-$version.zip",
    #     timeout     => 0,
    #     verbose     => false,
    #     require     => File["/opt/ghost-$version/"]
    # }

    archive { "ghost-$version.zip":
        ensure  => present,
        url     => "http://ghost.org/zip/ghost-$version.zip",
        target  => "/opt/ghost-$version",
        require => File["/opt/ghost-$version/"]
    }
}
