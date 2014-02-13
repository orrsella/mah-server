$user = 'orr'
$password = 'h2V8nQ6;9BNUv]PQr4LGXLK{t'
$ssh_pub_key = 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCshofvRTpbYHY/66JidVmFuL/NPB7VIxKfJgxjusd3kIhRTx8sjj6rLyXG1FhXNGovdrCB7mhrYbobVUdZr+ZvbrW0zqRgoSpG251Lob5qLul4XnJs2ArICJG5sD1BMZ/ZPwRwogfXt4StI9jjvHwt8kSl7Bm6+gSmismuFFmWJyh2f0H8BXVk7kf4Sk2MdwZv15zD3lc8CT/4WUs704J0/DFz464mKN1fPnhFu0yb1/XAMUN09BYfn8YTIYZoCCqDhYcRX0iLXNhM0ODjl/kkIfN64Sa9szJvSEONSJdhtkWMUgXTyPCqCgUKThmlVssxVxkIdWh8vxjDvb4rFSa1'
$ssh_key_type = 'ssh-rsa'
$logwatch_email = 'orrsella@gmail.com'


# Fail if we're not running on Ubuntu
if $operatingsystem != 'ubuntu' {
    fail("Not running on Ubuntu!!!, running: $operatingsystem")
}


#
# Users
#
# class { 'users':
#     user     => $user,
#     password => $password
# }

#
# Security
#
# class { 'sshkeys':
#     user => $user,
#     ssh_pub_key => $ssh_pub_key,
#     ssh_key_type => $ssh_key_type
# }

class { 'sshkeys':
    user => 'root',
    ssh_pub_key => $ssh_pub_key,
    ssh_key_type => $ssh_key_type
}

# class { 'sudoers':
#     user => $user
# }

class { 'firewall': }
class { 'aptupgrades': }
class { 'fail2ban': }

class { 'logwatch':
    email => $logwatch_email
}

#
# Misc
#
class { 'tools': }

#
# Applications
#
class { 'ghost': }
