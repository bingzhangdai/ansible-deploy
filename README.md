# Ansible deploy

Configure systems and deploy software by using Ansible.

## Prerequisites

* python and pip installed.

If you are using Windows, it is strongly recommended to use Windows Subsystem for Linux ([WSL docs](https://docs.microsoft.com/en-us/windows/wsl)).

## This playbook can

* configure bash
* install and configure vim
* install latest docker-ce
* install shadowsocks-libev and optionally v2ray-plugin (click [here](roles/shadowsocks-libev/README.md) for more info)

## How to use

### Clone and config environment

```bash
git clone https://github.com/bingzhangdai/ansible-deploy.git
cd ansible-deploy
make evn
```

If you do not have `make` support. Just open the `Makefile` file and run the command under target `env` in your console manually. This will install all env requirements.

### Edit inventory (hosts)

Modify hosts and put all your remote servers in file `hosts`.

```ini
host_or_ip_0
host_or_ip_1
```

### Modify default group vars

Update vars under `group_vars/all/*`. Change your remote user name and password for varibale `ansible_user` and `ansible_ssh_pass` in file `main.yml` for ssh login.

```yml
ansible_user: root
ansible_ssh_pass: root_passwd
```

Modify other vars as needed. For example, edit `shadowsocks-libev.yml` and change the server port and password.

```yml
server_port: 8388
password: mypassword
```

### Installation

For full installation, run the following command.

```bash
ansible-playbook site.yml -i hosts --skip-tags "docker-ce,shadowsocks-libev"
```

You can aslo install only one or more components. Just look at the file `site.yml` and decide.

```bash
ansible-playbook site.yml -i hosts --tags "shadowsocks-libev"
```

Enjoy!
