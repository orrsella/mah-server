# mah-server

Mah (my) server. Ansible playbooks for deploying [orrsella.com](https://orrsella.com), among other stuff.

Replace all `TODO` placeholders with real values.

## Requirements

* [Ansible](http://www.ansible.com/)
* [orrsella.com](https://github.com/orrsella/orrsella.com) – Jekyll repo at the same directory level
* [Vagrant-cachier plugin](https://github.com/fgrehm/vagrant-cachier) – `$ vagrant plugin install vagrant-cachier` (optional but recommended)

## Deploy

First build Jekyll sources:

```bash
$ cd ../orrsella.com
$ jekyll build
$ cd -
```

and then deploy:

```bash
$ ansible-playbook -i inventories/production/inventory site.yml
```

You can only deploy a portion of the playbook with tags:

```bash
$ ansible-playbook -i inventories/production/inventory site.yml --tags=jekyll,nginx
```

## Testing

```bash
$ vagrant up
```

or:

```bash
$ ansible-playbook -i inventories/vagrant/inventory site.yml
```

## New Server

Add new server (ubuntu trusty64 14.04 expected) to `inventories/production/inventory` and run:

```bash
$ ansible-playbook -i inventories/production/inventory new-server.yml
```
