# Common tasks

The tasks under this role are used to install and configure common softwares.

## Supported tasks

Put all personal configuration files under `roles/common/files/*` and modify the varible file `group_vars/all/common.yml`.

* [shell](#shell): update `.xxx` rc files and `.xxx` folders for your favorite shell like bash, zsh.
* [bat](#bat): a syntax highlighting tool.
* [fd](#fd): a simple, fast and user-friendly alternative to 'find'.
* [fzf](#fzf): a command-line fuzzy finder.
* [git](#git): install and config git global config.
* [ripgrep](#ripgrep) a line-oriented search tool that recursively searches directories for a regex pattern
* [ssh](#ssh): update `sshd_config` and set up public key loging.
* [vim](#vim): install vim and update vim config.
* [misc](#misc): simply install by package manager.

### shell

Files under `roles/common/files/shell/` will be copied to `$HOME` and appended at the end if files already exit. Directories will be `rsync`ed to `$HOME`.

For example, put `.bashrc` file, `.local` folder, etc. under `roles/common/files/shell/`.

if `shell_clear_existing=true`, current `.xxx` file content will be backed up and cleared if it is the first time running this task.

### bat

Install a syntax highlighting tool [sharkdp/bat](https://github.com/sharkdp/bat).

### fd

install a simple, fast and user-friendly alternative to 'find'. [sharkdp/fd](https://github.com/sharkdp/fd).

### fzf

Install a command-line fuzzy finder [junegunn/fzf](https://github.com/junegunn/fzf).

### git

Change `git_config` to your desired value.

### ripgrep

A line-oriented search tool that recursively searches your current directory for a regex pattern. ripgrep is similar to other popular search tools like The Silver Searcher, ack and grep. [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep).

### ssh

Modify `sshd_config` and put your public key in file. The following config will enable public key authentication and disable password login.

```yml
sshd_config:
  PasswordAuthentication: 'no'
  ChallengeResponseAuthentication: 'no'
  PubkeyAuthentication: 'yes'
```

If you want to push your private key to remote server, place you private key and set `ssh_push_keys=true`.

### vim

Put `.vimrc` and other files under `roles/common/files/vim/`. The following settings will install `plug` plugin manager.

```yml
vim:
  vundle: false
  plug: true
```

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
