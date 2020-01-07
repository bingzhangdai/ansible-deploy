# ansible-deploy

Configure systems and deploy software by using Ansible.

## requirement

python 3.6 or above

### config environment

```bash
make env
```

This will install all env requirements.

### edit host files and default group vars

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

## roles

### shadowsocks-libev

#### edit vars

The minimum you need to change is under roles/shadowsocks-libev/vars

```bash
make -f shadowsocks-libev.makefile vars
```

Update the server port and password

```yml
server_port: 8388
password: mypassword
```

or if you want to personalize all variables,

```bash
make -f shadowsocks-libev.makefile vars-all
```

#### run playbook

After that you can start deploy. Enjoy!

```bash
ansible-playbook shadowsocks-libev.yml -i hosts
```

[shadowsocks-libev](roles/shadowsocks-libev/README.md)
