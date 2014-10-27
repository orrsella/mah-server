# orrsella.com

Ansible playbooks for [orrsella.com](https://orrsella.com).

## Requirements

* Ansible
* [orrsella.com](https://github.com/orrsella/orrsella.com) Jekyll repo at the same level

## New server config

Add new server to `inventories/production/inventory` and run (ubuntu trusty64 14.04 expected):

```bash
$ ansible-playbook -i inventories/production/inventory new-server.yml
```

## Run ansible

```bash
$ cd ../orrsella.com
$ jekyll build
$ cd -
$ ansible-playbook -i inventories/production/inventory site.yml
```

## Testing

```bash
$ vagrant up
```

or

```bash
$ ansible-playbook -i inventories/vagrant/inventory site.yml
```
