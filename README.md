# mah-server

Mah' (my) server. Ansible playbooks for deploying [orrsella.com](http://orrsella.com), among other stuff.

Replace all `TODO` placeholders with real values.

## Requirements

* [Ansible](http://www.ansible.com/)
* [Jekyll 2.2+](http://jekyllrb.com/) – `$ gem install jekyll`
* [orrsella.com](https://github.com/orrsella/orrsella.com) – Jekyll repo cloned at the same directory level
* [Vagrant-cachier plugin](https://github.com/fgrehm/vagrant-cachier) – `$ vagrant plugin install vagrant-cachier` (optional but recommended)

## Setup New Server

- Move DNS `A` records over to new IP address so Let's Encrypt can authenticate the domain.
- Add new server (ubuntu 16.04 expected) to `inventories/production/inventory` and run:

```bash
$ ansible-playbook -i inventories/production/inventory new-server.yml
```

## Deploy

```bash
$ ansible-playbook -i inventories/production/inventory site.yml
```

You can also deploy a subset of the playbooks by using tags:

```bash
$ ansible-playbook -i inventories/production/inventory site.yml --tags=jekyll,nginx
```

## Test

Provision with Vagrant:

```bash
$ vagrant up
```

or manually:

```bash
$ ansible-playbook -i inventories/vagrant/inventory site.yml
```

