## Packer images

In order to use the templates make sure Packer is in your path and executable. 
The provided templates are tested with Packer `0.10.0`.

Decrypt the Packer variables (if necessary):

```
./sensitive_data.sh decrypt packer
```

### qemu qcow2

#### Requirements
Make sure you have the necessary qemu libraries installed for your system. 
Be sure to set `PACKER_ACCELERATOR` to the available acceleration on your machine (e.g., `kvm`).

#### Build the image


From the top directory of this repository, source the wanted environment and then simply create the image:

```
source .packer/ubuntu14.04_amd64/var_envs/qemu/app_test_kvm_<vm-size>.sh
packer build .packer/ubuntu14.04_amd64/img_templates/qemu/app.json
```

The qcow2 image is build to `.packer/builds`

#### Install an image on the hypervisor

Provision the dedicated logical device on the hypervisor machine with the image:

```
qemu-img convert -O raw <image> /dev/vm_disk/<lg_device>
```

Now you can login via virt-manager with your configured `<ansible-user>` credentials. Some files still need to be configured properly: 

- `/etc/network/interfaces`
- `/etc/hostname`
- `/etc/hosts` (the proper entry for `127.0.1.1`)

Also, when finished and connected to the web, remove the password from the `<ansible-user>` user via: 

```
sudo passwd -l <ansible-user>
```

Finally, set a password for the root user, so in case of emergency (no networking / ssh broken) we can still login through the virt-manager. 

#### Create a logical device for a new VM on the hypervisor

To create a new logical device inside a volume group `vg_group` on the hypervisor:

```
sudo lvcreate -L <device_size - e.g. 25G> -n <device_name> <vg_group>
```

### Docker

#### Requirements
Make sure you have the necessary docker libraries installed for your system. 

#### Docker images for app infrastructure
We can build docker images for our app infrastructure (provisioned with our ansible roles).

e.g., to build a docker image with the infrastructure necessary for all apps (merchant, customer and admin app) in test environment:
```
source .packer/ubuntu14.04_amd64/var_envs/docker/app_all_test.sh
packer build .packer/ubuntu14.04_amd64/img_templates/docker/app_test_all.json
```

Note, that currently this only provisions the infrastructure - without code deployment. 
We will add another packer build which then uses this infrastructure image to provision the code and create a ready to deploy image.
