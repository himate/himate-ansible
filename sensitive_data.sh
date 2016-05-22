#!/bin/bash

SENSITIVE_TEMPLATES="roles/ssh/templates/Ubuntu14_04.sshd_config.j2.enc\
                     roles/users/files/sudoers.enc\
                     roles/users/templates/sudoers.group.j2.enc"

SENSITIVE_VARS="roles/users/defaults/main.yml\
                group_vars/app.yml\
                group_vars/master.yml"

SENSITIVE_PACKER=".packer/ubuntu14.04_amd64/var_envs/app_test_kvm_25G.sh"

SENSITIVE_INVENTORIES="inventories/test"

if [ "$1" != "encrypt" ] && [ "$1" != "decrypt" ]
then
    echo "'encrypt' or 'decrypt' allowed"
    exit 1
fi

if [ "$2" = "templates" ]
then
    SENSITIVE_FILES=$SENSITIVE_TEMPLATES
elif [ "$2" = "vars" ]
then
    SENSITIVE_FILES=$SENSITIVE_VARS
elif [ "$2" = "packer" ]
then
	SENSITIVE_FILES=$SENSITIVE_PACKER
elif [ "$2" = "inventories" ]
then
	SENSITIVE_FILES=$SENSITIVE_INVENTORIES
else
    SENSITIVE_FILES="$SENSITIVE_TEMPLATES $SENSITIVE_VARS $SENSITIVE_PACKER $SENSITIVE_INVENTORIES"
fi

ANSIBLE_VAULT_PASSWORD_FILE=vault_pass ansible-vault $1 $SENSITIVE_FILES
