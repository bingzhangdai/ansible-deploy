# ansible-deploy

Configure systems and deploy software by using Ansible.

## requirement

python 3.6 or above

### config environment

```bash
make env
```

### edit host files and default group vars

```bash
make hosts
```

## roles

### shadowsocks-libev

#### edit vars

```bash
make -f shadowsocks-libev.makefile vars
```

or edit all vars

```bash
make -f shadowsocks-libev.makefile vars-all
```

#### run playbook

```bash
ansible-playbook shadowsocks-libev.yml -i hosts
```

[shadowsocks-libev](roles/shadowsocks-libev/README.md)
