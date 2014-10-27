VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "vagrant.orrsella.com"

  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "site.yml"
    ansible.inventory_path = "inventories/vagrant/inventory"
  end

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

end
