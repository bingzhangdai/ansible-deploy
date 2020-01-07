# Ansible deploy

Configure systems and deploy software by using Ansible.

## Requirement

python 3.6 or above and pip installed.

### Config environment

```bash
make env
```

This will install all env requirements.

### Edit host files and default group vars

```bash
# the console will launch whatever editor you have defined with `$EDITOR`, and defaults to `vi`
make hosts
# or you can change the editor
# if you have `vscode` installed and updated `$PATH`
make hosts EDITOR=code
```

Put all your remote servers under file `hosts`.

```ini
host_or_ip_0
host_or_ip_1
```

Update `ansible_user` and `ansible_ssh_pass` for ssh login.

```yml
ansible_user: root
ansible_ssh_pass: root_passwd
```

## Roles

### shadowsocks-libev

#### Edit vars

The minimum you need to change is under roles/shadowsocks-libev/vars

```bash
make -f shadowsocks-libev.makefile vars
# or
make -f shadowsocks-libev.makefile vars EDITOR=code
```

Update the server port and password

```yml
server_port: 8388
password: mypassword
```

or if you want to personalize all variables,

```bash
make -f shadowsocks-libev.makefile vars-all
# or
make -f shadowsocks-libev.makefile vars-all EDITOR=code
```

#### Run playbook

After that you can start deploy. Enjoy!

```bash
ansible-playbook shadowsocks-libev.yml -i hosts
```

[shadowsocks-libev](roles/shadowsocks-libev/README.md)
