#! /bin/bash

echo "Changing root password"
passwd

echo "Update apt-get"
apt-get update
apt-get upgrade

echo "Install ruby with RVM (Ruby Version Manager)"
$ \curl -L https://get.rvm.io | bash -s stable
$ source /etc/profile.d/rvm.sh
$ rvm requirements
$ rvm install ruby
$ rvm use ruby --default
$ rvm rubygems current

echo "Install puppet for a standalone deployment"
$ wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
$ dpkg -i puppetlabs-release-precise.deb
$ apt-get update
$ apt-get install puppet-common

echo "Configure puppet"