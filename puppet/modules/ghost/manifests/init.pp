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
}