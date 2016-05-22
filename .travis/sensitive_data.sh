#!/bin/bash

SENSITIVE_FILES="roles/ssh/templates/Ubuntu14_04.sshd_config.j2.enc\
                 roles/users/files/sudoers.enc\
                 roles/users/templates/sudoers.group.j2.enc"

if [ "$1" != "clean" ] && [ "$1" != "decrypt" ]
then
    echo "only 'clean' or 'decrypt' are allowed"
    exit 1
fi

if [ "$1" = "decrypt" ]
then
    for SECRET in $SENSITIVE_FILES
    do
        ANSIBLE_VAULT_PASSWORD_FILE=vault_pass ansible-vault view $SECRET > ${SECRET::-4}
    done
elif [ "$1" = "clean" ]
then
    for SECRET in $SENSITIVE_FILES
    do
        rm ${SECRET::-4}
    done
fi
