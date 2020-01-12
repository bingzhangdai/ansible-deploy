PYTHON = python

.PHONY: env encrypt play

env:
	$(PYTHON) -m pip install --upgrade ansible
	apt -y update && apt install -y sshpass || yum install -y sshpass

encrypt:
	$(eval $@_VAR := $(shell bash -c 'read -p "varible name: " v && echo "$$v"'))
	ansible-vault encrypt_string --ask-vault-pass --stdin-name '$($@_VAR)'

play:
	ansible-playbook site.yml -i hosts --ask-vault-pass
