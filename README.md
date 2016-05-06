### Status
[![Build Status](https://api.travis-ci.org/himate/himate-infrastructure.svg?branch=master)](https://travis-ci.org/himate/himate-infrastructure)



## HiMate Infrastructure

This repository contains code for our infrastructure.

### Ansible

We currently use ansible to provision our servers.

#### Rolling out with sensitive data

Private keys and other sensitive data are encrypted with `ansible-vault`. The password is stored in `vault_pass.enc`, which is an openssl encrypted file. You first need to decrypt that file:

```
openssl aes-256-cbc -k "<the-password>" -in vault_pass.enc -out vault_pass -d
```

Next, you need to decrypt the sensitive templates:

```
sensitive_data.sh decrypt templates
```

After that, you can rollout the playbooks:

```
ansible-playbook --vault-password-file vault_pass -i inventories/dev playbooks/<playbook-file>
```

#### Encrypting sensitive data

Please ensure to keep sensitive data encrypted:

```
ANSIBLE_VAULT_PASSWORD_FILE=vault_pass ansible-vault encrypt <file-to-encrypt>
```

In case you are encrypting a template, please also add it to the template list inside `sensitive_data.sh`.

