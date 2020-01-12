# Common tasks

The tasks under this role are used to install and configure common softwares.

## Supported tasks

Put all your personal configuration files under `roles/common/files/*` and modify the varible file `group_vars/all/common.yml`.

### bash

Files under `roles/common/files/bash/` will be pushed to you `$HOME` directory associated with `ansible_user` you put in `group_vars`.

### vim

Put your `.vimrc` and vim plugins under `roles/common/files/vim/`.

### setup ssh public key login

Modify `sshd_config` and put your public key in file. If you want to push your private key to remote server, place you private key and set `ssh_push_keys=true`

### git

Change `git_config` to your desired value.

### misc

This task is to install common packages by package manager. Just add package name under `misc_packages`.

## Use cases

### Full installation and configuration

```bash
ansible-playbook -i hosts common.yml
```

### Enable pubkey authentication

```bash
ansible-playbook -i hosts --tags "ssh" common.yml
```

### Install vims only. Do not copy .vimrc files

```bash
ansible-playbook -i hosts --tags "vim" --skip-tags "configuration" common.yml
```
