$user = 'orr'
$password = 'h2V8nQ6;9BNUv]PQr4LGXLK{t'
$ssh_pub_key = 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCshofvRTpbYHY/66JidVmFuL/NPB7VIxKfJgxjusd3kIhRTx8sjj6rLyXG1FhXNGovdrCB7mhrYbobVUdZr+ZvbrW0zqRgoSpG251Lob5qLul4XnJs2ArICJG5sD1BMZ/ZPwRwogfXt4StI9jjvHwt8kSl7Bm6+gSmismuFFmWJyh2f0H8BXVk7kf4Sk2MdwZv15zD3lc8CT/4WUs704J0/DFz464mKN1fPnhFu0yb1/XAMUN09BYfn8YTIYZoCCqDhYcRX0iLXNhM0ODjl/kkIfN64Sa9szJvSEONSJdhtkWMUgXTyPCqCgUKThmlVssxVxkIdWh8vxjDvb4rFSa1',
$ssh_key_type = 'ssh-rsa',
$logwatch_email = 'orrsella@gmail.com'

# Fail if we're not running on Ubuntu
if () fail('Not running on Ubuntu')

#########
# Users #
#########

# Create user group
group { $user:
    ensure => present
}

# Create user
user { "$user":
    ensure => present,
    gid => $user,
    password => $pwd,
    managehome => true,
    home   => "/home/$user",
    require => Group[$user],
}

############
# Security #
############

class { 'sshkeys':
    user => $user,
    ssh_pub_key => $ssh_pub_key,
    ssh_key_type => $ssh_key_type
}

class { 'sudoers': }
class { 'firewall': }
class { 'aptupgrades': }
class { 'fail2ban': }

class { 'logwatch':
    email => $logwatch_email
}



# setup default bachrc file