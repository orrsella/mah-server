class sudoers {

    # Make sure sudoers file has the appropriate permissions
    file { '/etc/sudoers':
        owner => 'root',
        group => 'root',
        mode  => '440'
    }
}