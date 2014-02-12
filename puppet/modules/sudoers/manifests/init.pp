class sudoers($user) {

    # Make sure sudoers file has the appropriate permissions
    file { '/etc/sudoers':
        owner => 'root',
        group => 'root',
        mode  => '440'
    }

    file { "/etc/sudoers.d/$user":
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '440',
        content => "$user     ALL=NOPASSWD: ALL\n"
    }
}