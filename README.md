# Bootstrapping OpenStack in a Vagrant box using Kolla

This projects helps bootstrapping a vagrant box to 
install OpenStack using the Kolla installer.

## Start

```sh
vagrant up
vagrant ssh
```

## Inside the Box

To use the sample files you can do:

```sh
su - kolla #password: kolla
cd /home/kolla
cp /vagrant/config-samples/inventory .
sudo chown -R kolla:kolla .
cp /vagrant/config-samples/globals.yml /etc/kolla/
```

Make sure to modify the IP addresses and network interfaces according to your setup.

Then you can do

```sh
sudo kolla-genpwd
sudo kolla-ansible -i inventory certificates
sudo kolla-ansible -i inventory bootstrap-servers
sudo kolla-ansible -i inventory prechecks
sudo kolla-ansible -i inventory deploy
sudo kolla-ansible -i inventory post-deploy
```


