# mah-server

Mah (my) server. Ansible playbooks for deploying [orrsella.com](https://orrsella.com), among other stuff.

## Requirements

* [Ansible](http://www.ansible.com/)
* [orrsella.com](https://github.com/orrsella/orrsella.com) Jekyll repo at the same directory level

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
