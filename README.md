# Install Rancher and Rancher OS

## Install Rancher OS from ISO
The RancherOS ISO file can be used to create a fresh RancherOS install on KVM, VMware, VirtualBox. You must boot with at least **512MB** of memory.

You can download the rancheros.iso file from [Release Pages](https://github.com/rancher/os/releases/)

### 1. Writing cloud-config.yml
Before installation, you need to create cloud-config.yml in order to determine how to configure Rancher OS.

You can see [configuration options](https://rancher.com/docs/os/v1.x/en/installation/configuration/ssh-keys/).
And you can validate config files with the following command.
```
ros config validate -i cloud-config.yml
```

### 2. Installing Rancher OS
```
CLOUD_CONFIG_URL=https://xxx
PASSWORD=password  # temporary

sudo -i
# loading config directly
ros -install -f -c cloud-config.yml -d /dev/sdX --append "rancher.password=$PASSWORD"
# loading config from URL
ros install -f -c $CLOUD_CONFIG_URL -d /dev/sdX --append "rancher.password=$PASSWORD"
```
### 3. Change Rancher user password
After launching, you can login rancher user with the password you set in $PASSWORD.
You should change current password to the new one.
```
sudo -i
ros config syslinux
reboot
```

You can upgrade os version if you need.
```
ros os upgrade -f -i rancher/os:VERSION
#ros os upgrade -f -i rancher/os:VERSION
```
## Install Rancher OS on AWS
### 1. Launch instances
Launch instances with an appropriate Rancher OS AMI.

You can look up the latest AMI in [AMI list](https://github.com/rancher/os/blob/master/README.md#amazon)

regarding to security group, you should open the following ports.

* SSH (tcp/22)
* Rancher Agent (udp/500, udp/4500)
* Rancher WebUI (tcp/80, tcp/443)

### 2. Load cloud-config.yml
After launching, you can access via SSH
```
ssh -i path/to/key.pem rancher@XXX.XXX.XXX.XXX
```

Merge cloud-config setting into default config
```
CLOUD_CONFIG_URL=https://xxx

curl -fO $CLOUD_CONFIG_URL
ros config merge -i cloud-config.yml
reboot
```

## Install Rancher
Rancher runs as a docker container on RancherOS. All you have to do is simply run the container as below.
```
docker run -d --restart=unless-stopped -p 8080:80 -p 8443:443 -v rancher:/var/lib/rancher rancher/rancher
```

# References
* [Installing RancherOS to Disk](https://rancher.com/docs/os/v1.2/en/running-rancheros/server/install-to-disk/)
* [Running RancherOS on AWS](https://rancher.com/docs/os/v1.2/en/running-rancheros/cloud/aws/)
* [How to install Rancher on RancherOS](https://ramsada.io/blog/static/how-to-install-rancher-on-rancher-os/index.html)
* [RancherOS Installation — Steemit](https://steemit.com/rancheros/@ynoot/rancheros-installation)
* [Running Kubernetes cluster on RancherOS – Ivan Mikushin – Medium](https://medium.com/@imikushin/running-kubernetes-cluster-on-rancheros-b2bd1308eb6d)
* [cloud-config.yml example](https://gist.github.com/janeczku/2baa0db0b89913999eb05ddb6f343f9a)
