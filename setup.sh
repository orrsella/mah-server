#! /bin/bash

# validate script working directory is main repo dir
if [ ! -f $dotfiles/setup.sh ] ;
then
    echo "*** ERROR: Make sure to run script in main repo dir! ***"
    exit
fi


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
# This will install Puppet without the agent init script.
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i puppetlabs-release-precise.deb
apt-get update
apt-get install puppet-common
rm puppetlabs-release-precise.deb

echo "Configure puppet symlinks"
ln -sfF $(pwd)/puppet/puppet.conf /etc/puppet/puppet.conf
ln -sfF $(pwd)/puppet/hiera.yaml /etc/puppet/hiera.yaml

echo "Install puppet modules"
puppet module install netmanagers/fail2ban
puppet module install attachmentgenie/ufw
puppet module install willdurand/nodejs
# puppet module install maestrodev/wget
puppet module install smarchive/archive
