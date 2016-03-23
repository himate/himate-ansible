#!/bin/bash

SENSITIVE_TEMPLATES="roles/ssh/templates/sshd_config.j2\
                     roles/users/files/10001_kfi/authorized_keys\
                     roles/users/files/himate/authorized_keys\
                     roles/users/files/sudoers\
                     roles/users/templates/sudoers.group.j2\
                     roles/users/files/9999_a/authorized_keys"

SENSITIVE_VARS="roles/ssh/defaults/main.yml\
                roles/users/vars/groups/admins.yml\
                roles/users/vars/users/admins.yml\
                roles/users/vars/users/himate.yml\
                roles/users/vars/users/deploy.yml"


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
else
    SENSITIVE_FILES="$SENSITIVE_TEMPLATES $SENSITIVE_VARS"
fi

ANSIBLE_VAULT_PASSWORD_FILE=vault_pass ansible-vault $1 $SENSITIVE_FILES
