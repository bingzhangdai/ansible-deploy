# common

This role is used to install common software and configure systems.

## Supported tasks

Put all your personal configuration files under `roles/common/files/*`.

### bash

Files under `roles/common/files/bash/*` will be pushed to you `$HOME` directory associated with the `ansible_user` you put in `group_vars`.

### vim

Similar to `bash` task, but you can use `--skip-tags "package"` to avoid reinstalling the vim package.

### ssh key login


