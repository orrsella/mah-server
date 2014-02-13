# Setup server

#### Start server

Fire up an Ubuntu 12.04 LTS “Precise Pangolin” server.

#### Connect to machine with root user

```
$ ssh root@ip-address
```

#### Clone git repo

```
$ apt-get update
$ apt-get install git
```

* Generate ssh key:

```
$ ssh-keygen -t rsa
```

* Copy the content of `~/.ssh/id_rsa.pub` and add to [GitHub permissions](https://github.com/settings/ssh).

* Clone:

```
$ git clone git@github.com:orrsella/orrsella.com.git /opt/orrsella.com
```

#### Run setup script

```
$ cd /opt/orrsella.com
$ ./setup.sh
```

#### Configure puppet

Optionally create a cron task to regularly run puppet apply on a main manifest:

```
$ sudo puppet resource cron puppet-apply ensure=present user=root minute=30 command='/usr/bin/puppet apply $(puppet apply --configprint manifest)'
```

#### Run puppet

Update any parameters needed in `site.pp` and run puppet. Make sure to do so with `root` user:

```
$ puppet apply /opt/orrsella.com/puppet/manifests/site.pp
```
