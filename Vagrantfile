Vagrant.configure("2") do |config| 
    config.vm.box = "ubuntu/xenial64"
    config.vm.network "private_network", ip: "192.168.33.3"
    config.vm.network "public_network", ip: "192.168.33.3"
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.synced_folder "compartida", "/home/user/compartida"
    config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.name = "newvm"
    end
    config.vm.provision :shell, :path => "bootstrap.sh"
end
