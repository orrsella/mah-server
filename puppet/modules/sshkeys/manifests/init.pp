class sshkeys($user, $ssh_pub_key, $ssh_key_type) {

    # Ensure the .ssh directory exists with the right permissions
    file { "/home/$user/.ssh":
        ensure  =>  directory,
        owner   =>  $user,
        group   =>  $user,
        mode    =>  '0700',
        require =>  File["/home/$user"],
    }

    # Add user's SSH key
    ssh_authorized_key { $user:
        ensure  => present,
        name    => $user,
        user    => $user,
        type    => $ssh_key_type,
        key     => $ssh_pub_key,
        require => File["/home/$user/.ssh"]
    }
}