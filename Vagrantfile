# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 4
  end
  config.vm.network "forwarded_port", guest: 80, host: 10080
  config.vm.network "forwarded_port", guest: 8080, host: 18080
  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.provision "file", source: "vm-bash-profile.sh", destination: ".bash_profile"
  config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
  config.vm.provision "file", source: "~/.vimrc", destination: ".vimrc"
  config.vm.synced_folder "~/devel/", "/home/vagrant/devel"
  config.vm.synced_folder  "~/.m2/", "/home/vagrant/.m2"
end
