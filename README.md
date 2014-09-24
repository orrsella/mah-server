# orrsella.com

Ansible playbooks for [orrsella.com](https://orrsella.com).

## Requirements

* Ansible

## New server config

Add new server to `inventories/production/inventory` and run (ubuntu trusty64 14.04 expected):

```bash
$ ansible-playbook -i inventories/production/inventory new-server.yml
```

## Run ansible

```bash
$ ansible-playbook -i inventories/production/inventory site.yml
```

## Deploy Data

1. Grant new machine deploy rights to [content git repo](https://github.com/orrsella/orrsella.com-ghost-content)

2. Clone content repo to `/opt/ghost-content`:

```bash
$ git clone git@github.com:orrsella/orrsella.com-ghost-content.git /opt/ghost-content
```

## Testing

```bash
$ vagrant up
```

or

```bash
$ ansible-playbook -i inventories/vagrant/inventory site.yml
```
