#!/bin/bash

if [ -f local.dev.private.key ]; then
  mv local.dev.private.key /home/vagrant/.ssh/id_rsa
  chmod 0600 /home/vagrant/.ssh/id_rsa
fi

if [ -f local.dev.public.key ]; then
  mv local.dev.public.key /home/vagrant/.ssh/id_rsa.pub
  chmod 0644 /home/vagrant/.ssh/id_rsa.pub
fi

mkdir -p /home/vagrant/.ssh
touch /home/vagrant/.ssh/authorized_keys
chown -R vagrant: /home/vagrant/.ssh
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
