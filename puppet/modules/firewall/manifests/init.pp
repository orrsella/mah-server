class firewall {
    include ufw

    ufw::allow { 'allow-ssh-from-all':
      port => 22,
    }

    ufw::allow { 'allow-http-from-all':
      port => 80,
    }

    ufw::allow { 'allow-https-from-all':
      port => 443,
    }
}