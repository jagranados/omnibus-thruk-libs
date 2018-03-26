# -*- mode: ruby -*-
# vi: set ft=ruby :

require "vagrant"

if Vagrant::VERSION < "1.2.1"
  raise "The Omnibus Build Lab is only compatible with Vagrant 1.2.1+"
end

host_project_path = File.expand_path("..", __FILE__)
guest_project_path = "/home/vagrant/#{File.basename(host_project_path)}"
project_name = "thruk-libs"

Vagrant.configure("2") do |config|

 config.vm.define 'centos-omnibus-7-thruk' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "centos/7"

  end

  # Ensure a recent version of the Chef Omnibus packages are installed
  config.omnibus.chef_version = :latest

  # Enable the berkshelf-vagrant plugin
  config.berkshelf.enabled = true
  # The path to the Berksfile to use with Vagrant Berkshelf
  config.berkshelf.berksfile_path = "./Berksfile"

  host_project_path = File.expand_path("..", __FILE__)
  guest_project_path = "/home/vagrant/#{File.basename(host_project_path)}"

  config.vm.synced_folder host_project_path, guest_project_path

  #config.vm.provision :shell, :inline => "apt-get update"
  config.vm.provision :shell, :inline => "yum update -y"

  # prepare VM to be an Omnibus builder
  config.vm.provision :chef_solo do |chef|
    chef.json = {
      "omnibus" => {
        "build_user" => "vagrant",
        "build_dir" => guest_project_path,
        "install_dir" => "/opt/#{project_name}"
      }
    }

    chef.run_list = [
                     "recipe[omnibus::default]"
                    ]
  end

  config.vm.provision :shell, :inline => <<-OMNIBUS_BUILD
    export PATH=/usr/local/bin:$PATH
    source /home/vagrant/load-omnibus-toolchain.sh
    cd #{guest_project_path}
    sudo yum install cmake
    su vagrant -c "bundle install --binstubs"
    su vagrant -c "bin/omnibus build #{project_name}"
  OMNIBUS_BUILD
end
