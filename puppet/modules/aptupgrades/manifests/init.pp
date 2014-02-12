class aptupgrades {

    # Enable automatic security updates
    package { 'unattended-upgrades':
        ensure => present
    }

    file { '/etc/apt/apt.conf.d/10periodic':
        ensure => file,
        source => 'puppet:///modules/aptupgrades/10periodic'
        require => Packace['unattended-upgrades']
    }

    file { '/etc/apt/apt.conf.d/50unattended-upgrades':
        ensure => file,
        source => 'puppet:///modules/aptupgrades/50unattended-upgrades'
        require => Packace['unattended-upgrades']
    }
}