#!/bin/bash

# Descargar Vagrant
wget https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.deb

# Descomprimir Vagrant
sudo dpkg -i vagrant_1.9.1_x86_64.deb

# Eliminar la descarga (opcional)
sudo rm vagrant_1.9.1_x86_64.deb

# Confirmar que Vagrant se ha instalado
vagrant -v
