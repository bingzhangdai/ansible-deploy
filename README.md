# Ansible deploy

Configure systems and deploy software by using Ansible.

## Requirement

python 3.6 or above and pip installed.

If you are using Windows, it is strongly recommend to use under Windows Subsystem for Linux ([WSL docs](https://docs.microsoft.com/en-us/windows/wsl)).

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

The minimum you need to change is files under roles/shadowsocks-libev/vars. Execute the following command,

```bash
python3 vars.py --roles shadowsocks-libev
# or
EDITOR=code python3 vars.py --roles shadowsocks-libev
```

Update the server port and password,

```yml
server_port: 8388
password: mypassword
```

or if you want to personalize all variables,

```bash
python3 vars.py --roles shadowsocks-libev --include-default-vars
# or
EDITOR=code python3 vars.py --roles shadowsocks-libev --include-default-vars
```

#### Run playbook

After configuration you can start deployment.

```bash
ansible-playbook shadowsocks-libev.yml -i hosts
```

Enjoy!

[shadowsocks-libev](roles/shadowsocks-libev/README.md)
