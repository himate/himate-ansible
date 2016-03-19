#!/bin/bash

SENSITIVE_FILES="roles/ssh/defaults/main.yml\
		         roles/ssh/templates/sshd_config.j2\
				 roles/users/files/10001_kfi/authorized_keys\
				 roles/users/files/himate/authorized_keys\
				 roles/users/files/sudoers\
				 roles/users/templates/sudoers.group.j2\
				 roles/users/vars/groups/admins.yml\
				 roles/users/vars/users/admins.yml\
				 roles/users/vars/users/himate.yml"

if [ "$1" != "encrypt" ] && [ "$1" != "decrypt" ]
then
    echo "'encrypt' or 'decrypt' allowed"
	exit 1;
fi

ANSIBLE_VAULT_PASSWORD_FILE=vault_pass ansible-vault $1 $SENSITIVE_FILES
