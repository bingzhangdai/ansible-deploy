PYTHON = python3
EDITOR := vi
export EDITOR := $(EDITOR)

.PHONY: env hosts encrypt console

env:
	$(PYTHON) -m pip install ansible argparse

hosts:
	@printf '\033[01;32medit host file:\033[0m hosts' && read _ && $(EDITOR) hosts
	@$(PYTHON) vars.py --group-vars

encrypt:
	$(eval $@_VAR := $(shell bash -c 'read -p "varible name: " v && echo "$$v"'))
	ansible-vault encrypt_string --ask-vault-pass --stdin-name '$($@_VAR)'

console:
	ansible-console -i hosts all --ask-vault-pass
