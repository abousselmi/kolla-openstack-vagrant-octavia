Vagrant.configure("2") do |config|
  config.vm.define "kolla-openstack"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 16384
    vb.cpus = 4
  end
  config.vm.hostname = "kos"
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "private_network", ip: "192.168.100.10"
  config.vm.network "private_network", ip: "192.168.100.11"
  config.vm.network "private_network", ip: "192.168.100.12"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.synced_folder ".", "/vagrant", disabled: false
end
