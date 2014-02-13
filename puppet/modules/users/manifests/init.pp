class users($user, $password) {

    # Create user group
    group { $user:
        ensure => present
    }

    # Create user
    user { "$user":
        ensure      => present,
        gid         => $user,
        password    => $password,
        managehome  => true,
        shell       => '/bin/bash',
        home        => "/home/$user",
        require     => Group[$user],
    }

    # Ensure the home directory exists with the right permissions
    file { "/home/$user":
        ensure  => directory,
        owner   => $user,
        group   => $user,
        mode    => '0750',
        require => User[$user]
    }

    # Ensure the .ssh directory exists with the right permissions
    file { "/home/$user/.ssh":
        ensure  =>  directory,
        owner   =>  $user,
        group   =>  $user,
        mode    =>  '0700',
        require =>  File["/home/$user"],
    }

    file { "/home/$user/.profile":
        ensure  => present,
        source  => 'puppet:///modules/users/.profile',
        require => File["/home/$user"]
    }

    file { "/home/$user/.bashrc":
        ensure  => present,
        source  => 'puppet:///modules/users/.bashrc',
        require => File["/home/$user"]
    }

    file { "/home/$user/.bash_aliases":
        ensure  => present,
        source  => 'puppet:///modules/users/.bash_aliases',
        require => File["/home/$user"]
    }
}