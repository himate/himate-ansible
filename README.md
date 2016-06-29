### Status
[![Build Status](https://api.travis-ci.org/himate/himate-infrastructure.svg?branch=master)](https://travis-ci.org/himate/himate-infrastructure)



## HiMate Infrastructure

This repository contains code for our infrastructure.

### Ansible

Our provisioning scripts are tested with `Ansible 2.1`.

#### Local development with Vagrant

For local development we can use Vagrant. First, create the master box:

```
vagrant up master
```

Now we also have to create a box that we want to provision from the master:

```
vagrant up <box-name>
```

Inside the master box (`vagrant ssh master`) this repository is available at `/etc/ansible`. 
Also, remember to set the ip of the other box in your master's `/etc/hosts`.
You can now run your playbooks against the other box you created (see next section). 
Of course you do not have to use the `master` box, but can also run your ansible playbooks from your local machine - the `master` box is simply a convenient way if you do not want to install ansible locally.

#### Rolling out with sensitive data

Private keys and other sensitive data are encrypted with `ansible-vault`. The password is stored in `vault_pass.enc`, which is an openssl encrypted file. You first need to decrypt that file:

```
openssl aes-256-cbc -k "<the-password>" -in vault_pass.enc -out vault_pass -d
```

Next, you need to decrypt the sensitive inventories (if necessary):

```
sensitive_data.sh decrypt inventories
```

After that, you can rollout the playbooks:

```
ANSIBLE_VAULT_PASSWORD_FILE=`pwd`/vault_pass ansible-playbook -i inventories/dev playbooks/<playbook-file>
```

#### Encrypting sensitive data

Please ensure to keep sensitive data encrypted:

```
ANSIBLE_VAULT_PASSWORD_FILE=vault_pass ansible-vault encrypt <file-to-encrypt>
```

Please also add the encrypted file to the dedicated list inside `sensitive_data.sh`. 
Encrypted templates must have the ending `.enc` and be also added to `.travis/sensitive_data.sh`.

### Further Documentation

[Packer builds for docker and qemu images](https://github.com/himate/himate-infrastructure/blob/master/.packer/README.md)
