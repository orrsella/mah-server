#! /bin/bash

echo "Change root password"
passwd

echo "Update/upgrade apt-get"
apt-get update
apt-get upgrade

echo "Install ruby with RVM (Ruby Version Manager)"
\curl -L https://get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
rvm requirements
rvm install ruby
rvm use ruby --default
rvm rubygems current

echo "Install puppet for a standalone deployment"
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i puppetlabs-release-precise.deb
apt-get update
apt-get install puppet-common

echo "Configure puppet symlinks"
ln -sfF /etc/puppet/puppet.conf ./puppet/puppet.conf
ln -sfF /etc/puppet/hiera.yaml ./puppet/hiera.yaml

echo "Install puppet modules"
puppet module install netmanagers/fail2ban
puppet module install attachmentgenie/ufw
puppet module install willdurand/nodejs