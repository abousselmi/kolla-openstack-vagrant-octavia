#!/bin/bash

function log {
	echo -e "[INFO] $1"
}

function logerr {
	echo -e "[ERRO] $1"
}

#### start bootstrap
log "Start bootstrap"

### kolla deps
log "Insall kolla dependencies"

log "Decalre environment variables"
KOLLA_VERSION=8.0.0
KOLLA_USERNAME=kolla
KOLLA_PASSWORD=$KOLLA_USERNAME

log "Install required packages and dependancies"
export DEBIAN_FRONTEND=noninteractive 
apt-get -qq update \
	&& apt-get -qq install -y \
		git \
		python-dev \
		libffi-dev \
		gcc \
		libssl-dev \
		python-pip \
		python-selinux \
		ansible > /dev/null

log "Install Kolla packages"
pip install kolla==$KOLLA_VERSION kolla-ansible==$KOLLA_VERSION > /dev/null

log "Install openstack python client"
pip install -U python-openstackclient > /dev/null

log "Add $KOLLA_USERNAME user"
useradd -m -s /bin/bash -p $(echo $KOLLA_PASSWORD | openssl passwd -1 -stdin) $KOLLA_USERNAME

log "Add user $KOLLA_USERNAME to sudoers"
usermod -aG sudo $KOLLA_USERNAME

log "Set $KOLLA_USERNAME to passwordless sudo"
echo "$KOLLA_USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

log "Generate ssh key pair"
mkdir -p /home/$KOLLA_USERNAME/.ssh
ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P "" > /dev/null
cat ~/.ssh/id_rsa.pub >> /home/$KOLLA_USERNAME/.ssh/authorized_keys

log "Copy kolla globals and password sample files"
cp -r /usr/local/share/kolla-ansible/etc_examples/kolla /etc/

log "Copy kolla inventory sample files to /home/$KOLLA_USERNAME"
cp /usr/local/share/kolla-ansible/ansible/inventory/* /home/$KOLLA_USERNAME/

log "End bootstrap"
