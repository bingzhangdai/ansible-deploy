PYTHON = python3
EDITOR := vi
export EDITOR := $(EDITOR)

.PHONY: vars vars-all debug run all

vars:
	@$(PYTHON) vars.py --roles shadowsocks-libev

vars-all:
	@$(PYTHON) vars.py --roles shadowsocks-libev --include-default-vars

debug:
	ansible-playbook shadowsocks-libev.yml -i hosts --ask-vault-pass

run:
	ansible-playbook shadowsocks-libev.yml -i hosts 

all: vars-all debug
