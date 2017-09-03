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
  config.vm.provision :shell, path: "bootstrap.sh",
    env: {
        # Which get.docker.com prefix to use, defaults to get.
        # Use "test" for release candidates and "experimental" for
        # experimental builds.
        "VDS_WHICH_DOCKER" => ENV["VDS_WHICH_DOCKER"],
        "VDS_FOO"          => "VDS_BAR"
    }
  config.vm.provision "file", source: "vm-bash-profile.sh", destination: ".bash_profile"
  config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
  config.vm.provision "file", source: "~/.vimrc", destination: ".vimrc"
  config.vm.synced_folder "~/devel/", "/home/vagrant/devel"
  config.vm.synced_folder "~/distros/", "/home/vagrant/distros"
  config.vm.synced_folder  "~/.m2/", "/home/vagrant/.m2"
end
