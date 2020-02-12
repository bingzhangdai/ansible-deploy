PYTHON = python

.PHONY: env encrypt fact

env:
	@command -v sshpass > /dev/null || (apt -y update && apt install -y sshpass || yum install -y sshpass)
	@command -v pip > /dev/null || (apt -y update && apt install -y python3-pip || yum install -y python-pip)
	$(PYTHON) -m pip install --upgrade ansible

encrypt:
	$(eval $@_VAR := $(shell bash -c 'read -p "varible name: " v && echo "$$v"'))
	ansible-vault encrypt_string --ask-vault-pass --stdin-name '$($@_VAR)'

fact:
	ansible -i hosts all --ask-vault-pass -m setup > /dev/null
