# Descargar VirtualBox
wget http://download.virtualbox.org/virtualbox/5.2.14/virtualbox-5.2_5.2.14-112924~Ubuntu~xenial_amd64.deb

# Instalar dependencias de VirtualBox
sudo apt-get install libqt5x11extras5 libsdl1.2debian

# Instalar VirtualBox
sudo dpkg -i virtualbox-5.2_5.2.14-112924~Ubuntu~xenial_amd64.deb

# Eliminar la descarga (opcional)
sudo rm virtualbox-5.2_5.2.14-112924~Ubuntu~xenial_amd64.deb

# Confirmar que VirtualBox se ha instalado
virtualbox --help
