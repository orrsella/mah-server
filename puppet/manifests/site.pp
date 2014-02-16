# Fail if we're not running on Ubuntu
if $operatingsystem != 'ubuntu' {
    fail("Not running on Ubuntu!!!, running: $operatingsystem")
}

class { 'firewall': }
class { 'aptupgrades': }
class { 'fail2ban': }
class { 'logwatch': }
class { 'tools': }
class { 'ghost': }
class { 'nginx': }
