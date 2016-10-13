# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  ## PLUGIN HOSTMANAGER
  #config.hostmanager.enabled = true
  #config.hostmanager.manage_host = false
  #config.hostmanager.manage_guest = true
  #config.hostmanager.ignore_private_ip = false
  #config.hostmanager.include_offline = true
  
  # PLUGIN REGISTRATION
  if Vagrant.has_plugin?('vagrant-registration')
    config.registration.manager = 'subscription_manager'
    config.registration.username = 'usuario'
    config.registration.password = 'senha'
  end

  # DOCKER-DISTRIBUTION
  config.vm.define 'docker-distribution' , primary: true do |distribution|
    distribution.vm.box = "rhel/7.2"
    distribution.vm.hostname = 'docker-distribution.lab'
    #distribution.hostmanager.aliases = %w(docker-distribution)
    distribution.vm.network 'private_network', ip: '192.168.33.20'
    distribution.vm.provision :hosts do |provisioner|
      provisioner.add_host '127.0.0.1', ['docker-distribution']
      provisioner.add_host '192.168.33.20', ['docker-distribution.lab']
      provisioner.add_host '192.168.33.30', ['docker-host', 'docker-host.lab']
      provisioner.add_localhost_hostnames = false
      #provisioner.sync_hosts = true
    #distribution.vm.network "private_network", type: "dhcp"
    distribution.vm.provision "shell", path: "docker-distribution.sh"
    distribution.vm.provider 'virtualbox' do |vb|
      vb.customize ["modifyvm", :id, "--name", "docker-distribution"]
      vb.cpus = 2
      vb.memory = 1536
      end
    end
  end

  # DOCKER-HOST
  config.vm.define 'docker-host' , primary: true do |host|
    host.vm.box = "rhel/7.2"
    host.vm.hostname = 'docker-host.lab'
    #host.hostmanager.aliases = %w(docker-host)
    host.vm.network 'private_network', ip: '192.168.33.30'
    host.vm.provision :hosts do |provisioner|
      provisioner.add_host '127.0.0.1', ['docker-host']
      provisioner.add_host '192.168.33.20', ['docker-distribution', 'docker-distribution.lab']
      provisioner.add_host '192.168.33.30', ['docker-host.lab']
      provisioner.add_localhost_hostnames = false
      #provisioner.sync_hosts = true
    #host.vm.network "private_network", type: "dhcp"
    host.vm.provision "shell", path: "docker-host.sh"
    host.vm.provider 'virtualbox' do |vb|
      vb.customize ["modifyvm", :id, "--name", "docker-host"]
      vb.cpus = 2
      vb.memory = 1024
      end
    end
  end

end