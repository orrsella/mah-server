class tools {

    # Install additional tools
    package { 'ifstat':
        ensure => present
    }

    package { 'htop':
        ensure => present
    }
}