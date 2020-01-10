PYTHON = python
EDITOR := vi

export EDITOR := $(EDITOR)
export ANSIBLE_CONFIG = ansible.cfg

.PHONY: env hosts encrypt console

env:
	$(PYTHON) -m pip install -U ansible argparse

encrypt:
	$(eval $@_VAR := $(shell bash -c 'read -p "varible name: " v && echo "$$v"'))
	ansible-vault encrypt_string --ask-vault-pass --stdin-name '$($@_VAR)'

console:
	ansible-console -i hosts all --ask-vault-pass

play:
	ansible-playbook site.yml -i hosts all --ask-vault-pass
