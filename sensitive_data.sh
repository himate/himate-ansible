#!/bin/bash

SENSITIVE_TEMPLATES="roles/ssh/templates/Ubuntu14_04.sshd_config.j2\
                     roles/users/files/sudoers\
                     roles/users/templates/sudoers.group.j2"

SENSITIVE_VARS="roles/users/defaults/main.yml\
                group_vars/app.yml\
                group_vars/master.yml"

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
