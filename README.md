# mah-server

Mah' (my) server. Ansible playbooks for deploying [orrsella.com](https://orrsella.com), among other stuff.

Replace all `TODO` placeholders with real values.

## Requirements

* [Ansible](http://www.ansible.com/)
* [Jekyll 2.2+](http://jekyllrb.com/) – `$ gem install jekyll`
* [orrsella.com](https://github.com/orrsella/orrsella.com) – Jekyll repo at the same directory level
* [Vagrant-cachier plugin](https://github.com/fgrehm/vagrant-cachier) – `$ vagrant plugin install vagrant-cachier` (optional but recommended)

## Deploy

```bash
$ ansible-playbook -i inventories/production/inventory site.yml
```

You can also deploy a subset of the playbooks by using tags:

```bash
$ ansible-playbook -i inventories/production/inventory site.yml --tags=jekyll,nginx
```

## Testing

Provision with Vagrant:

```bash
$ vagrant up
```

or manually:

```bash
$ ansible-playbook -i inventories/vagrant/inventory site.yml
```

## New Server

Add new server (ubuntu trusty64 14.04 expected) to `inventories/production/inventory` and run:

```bash
$ ansible-playbook -i inventories/production/inventory new-server.yml
```
