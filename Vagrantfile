# -*- mode: ruby; -*-
require 'etc'

Vagrant.configure("2") do |config|
  config.vm.define :web do |web|
    # Ubuntu 14.04
    web.vm.box = "ubuntu/trusty64"
    # web.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64"

    # Network
    web.vm.hostname = "maxsim.vagrant"
    web.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
    web.vm.network :forwarded_port, guest: 5432, host: 5432
    web.vm.network 'private_network', ip: '192.168.100.100'

    # Share for masterless server
    web.vm.synced_folder "salt/roots/", "/srv/"
    web.vm.synced_folder "maxsim/", "/srv/maxsim/", group: 'www-data', mount_options: ["dmode=775"]

    web.vm.provision :salt do |salt|
      # Configure the minion
      salt.minion_config = "salt/minion.conf"

      # Show the output of salt
      salt.verbose = true

      # Run the highstate on start
      salt.run_highstate = true

      # Install the latest version of SaltStack
      salt.install_type = "stable"
    end

    # Customize the box
    web.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 512]
    end
  end
end
