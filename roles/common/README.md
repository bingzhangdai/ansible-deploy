# common

This role is used to install common software and configure systems.

## Supported tasks

Put all your personal configuration files under `roles/common/files/*`.

### bash

Files under `roles/common/files/bash/*` will be pushed to you `$HOME` directory associated with `ansible_user` you put in `group_vars`.

### vim

Similar to `bash` task, but you can use `--skip-tags "package"` to avoid reinstalling the vim package.

### ssh key login

Edit you `sshd_config` under `group_vars/all/common.yml` and put your public key in file.

## Possible actions

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
