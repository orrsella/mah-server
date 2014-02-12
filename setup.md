# Setup server

#### Start server

Fire up an Ubuntu 12.04 LTS “Precise Pangolin” server.

#### Connect to machine with root user

```
$ ssh root@ip-address
```

#### Change root password

```
$ passwd
```

#### Update apt-get

```
$ apt-get update
$ apt-get upgrade
```

#### Install ruby with RVM (Ruby Version Manager)

```
$ \curl -L https://get.rvm.io | bash -s stable
$ source /etc/profile.d/rvm.sh
$ rvm requirements
$ rvm install ruby
$ rvm use ruby --default
```

#### Install puppet for a standalone deployment

Configure to use Puppet Labs’ packages and install. Make sure to match the release of Ubuntu (`precise` in this example):

```
$ wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
$ dpkg -i puppetlabs-release-precise.deb
$ apt-get update
$ apt-get install puppet-common
```

This will install Puppet without the agent init script. See [Installing Puppet](http://docs.puppetlabs.com/guides/installation.html) for more information.

#### Clone project repo

```
$ git clone git@github.com:orrsella/orrsella.com.git /opt/orrsella.com
```

#### Configure puppet

Create a cron task to regularly run puppet apply on a main manifest (usually the same `/etc/puppet/manifests/site.pp` manifest that puppet master uses):

```
$ sudo puppet resource cron puppet-apply ensure=present user=root minute=30 command='/usr/bin/puppet apply $(puppet apply --configprint manifest)'
```

Also, copy the files `puppet.conf` and `hiera.yaml` to `/etc/puppet/`:

```
$ cp /opt/orrsella.com/puppet/puppet.conf /etc/puppet/
$ cp /opt/orrsella.com/puppet/hiera.yaml /etc/puppet/
```

#### Install puppet modules

```
$ puppet module install netmanagers/fail2ban
$ puppet module install attachmentgenie/ufw
```

#### Run puppet

```
$ puppet apply /opt/orrsella.com/puppet/manifests/site.pp
```