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
        ensure => exists,
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

    archive { "ghost-$version":
        ensure    => present,
        url       => "http://ghost.org/zip/ghost-$version.zip",
        extension => 'zip',
        checksum  => false,
        target    => "/opt/ghost-$version",
        require   => File["/opt/ghost-$version/"]
    }

    # include nodejs

    # nodejs::npm { "/opt/ghost-$version:ghost":
    #     ensure      => present,
    #     install_opt => '--production',
    #     require     => Archive["ghost-$version"]
    #     # version => '2.5.9',
    # }

    exec { '/usr/local/node/node-default/bin/npm install --production':
        cwd         => "/opt/ghost-$version",
        subscribe   => Archive["ghost-$version"],
        refreshonly => true
    }
}
