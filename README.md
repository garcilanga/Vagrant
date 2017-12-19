# Virtualización de entornos con Vagrant y VirtualBox

![Vagrant + VirtualBox + Ubuntu](vagrant_virtualbox_ubuntu.jpeg)

## Índice

1. Introducción
2. Instalación
3. Creación y configuración de una máquina virtual
    - Máquina virtual con configuración por defecto
    - Máquina virtual pre-configurada (box)
    - Máquina virtual con una configuración determinada (Vagrantfile)
4. Acceso a la máquina virtual
5. Operaciones con Vagrant
6. Referencias y más información

## 1. Introducción

**Vagrant** es una **herramienta open source** para la **creación y configuración de entornos virtualizados** reproducibles y compartibles de forma muy sencilla. Para ello crea y configura máquinas virtuales a partir de simples ficheros de configuración denominados **_Vagrantfile_**.

Vagrant está disponible para **distintos sistemas operativos** como Windows, MacOS X y GNU/Linux, 

Funciona por defecto con **VirtualBox** y es capaz de trabajar con **múltiples proveedores** como VMware, AWS (Amazon Web Services) y otros.

Las máquinas virtuales creadas con Vagrant pueden ser usadas en **entornos de desarrollo** y posteriormente desplegadas en **entornos de producción**.

Vagrant se **opera desde línea de comandos** mediante la instrucción **_vagrant_** seguida de la operación a ejecutar (_up, ssh, halt, status_ ...).

El desarrollo de Vagrant fue iniciado por Mitchell Hashimoto en 2010 como un proyecto secundario. En 2012 se convirtió en la empresa HashiCorp, consolidándose entre la comunidad de desarrolladores el interés y éxito de esta herramienta.

> NOTA: Este documento ha sido realizado para virtualización de entornos en y con Ubuntu 16.04.

## 2. Instalación

Vagrant trabaja por defecto con VirtualBox, por lo que debe ser instalado previamente.

**VirtualBox** y **Vagrant** pueden obtenerse en las páginas de descargas de sus respectivos sitios web mediante un navegador web o cualquier otra herramientas de descarga (por ejemplo _wget_). Existen distintas distribuciones según el sistema operativo, por lo que se debe seleccionar la adecuada a la máquina dónde va a ser instalada.

**Descarga e instalación de VirtualBox**:

Se puede descargar e instalar VirtualBox en un sistema operativo Ubuntu 16.04 Xenial por línea de comandos abriendo un terminal y ejecutando las siguientes instrucciones:

```
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
```

**Descarga e instalación de Vagrant**:

Se puede descargar e instalar Vagrant en un sistema operativo Ubuntu 16.04 Xenial por línea de comandos abriendo un terminal y ejecutando las siguientes instrucciones:

```
# Descargar Vagrant
wget https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.deb

# Descomprimir Vagrant
sudo dpkg -i vagrant_1.9.1_x86_64.deb

# Eliminar la descarga (opcional)
sudo rm vagrant_1.9.1_x86_64.deb

# Confirmar que Vagrant se ha instalado
vagrant -v
```

**Instalación de plugins**:

Guest Addittions es un plugin que mejora las capacidades gráficas de la máquina virtual (video, ventanas, ratón, etc.), que no son necesarias, en principio, si no se va a utilizar su entorno gráfico.

Pero incluye además otras características como la _sincronización horaria_, con la que VirtualBox se asegura de que la hora del sistema virtualizado esté mejor sincronizada, o _carpetas compartidas_, una de las características más importantes puesto que es una forma fácil de poder intercambiar archivos entre el sistema anfitrión y el virtualizado.

La instalación de este plugin es opcional, pero si se decide instalar, puede hacerse desde un terminal con la siguiente instrucción:

```
# Instalar el plugin de Vagrant que mantiene actualizado Guest Addittions de VirtualBox (opcional)
vagrant plugin install vagrant-vbguest
```

## 3. Creación y configuración de una máquina virtual

Se pueden crear y configurar entornos virtuales de varias formas.
- Máquina virtual con configuración por defecto
- Máquina virtual pre-configurada (box)
- Máquina virtual con una configuración determinada (Vagrantfile)

#### 3.1 Máquina virtual con configuración por defecto

Una vez instalados VirtualBox y Vagrant, se puede crear una máquina virtual con la configuración por defecto mediante la siguiente secuencia de instrucciones:
```
# Crear un nuevo directorio y acceder a él
mkdir newvmdir
cd newvmdir

# Crear la máquina virtual
vagrant init

# Iniciar la máquina virtual
vagrant up
```

#### 3.2 Máquina virtual pre-configurada (box)

Se pueden obtener e instalar imágenes de máquinas virtuales pre-configuradas. Estas imágenes se denominan **_box_**, y puede encontrarse un buen número de ellas (_más de 300 en el momento de la redacción de este documento_) en el sitio web [**www.vagrant.box**](http://www.vagrantbox.es/).

#### 3.3 Máquina virtual con una configuración determinada (Vagrantfile)

Para crear un máquina virtual con una configuración determinada hay que parametrizar el fichero **_Vagrantfile_**. Algunos de los parámetros más usuales son los siguientes:
- **config.vm.box**: sistema operativo
- **config.vm.network "private\_network"**: Ip de red privada
- **config.vm.network "public\_network"**: Ip de red pública
- **config.vm.network "forwarded\_port"**: redireccionamiento de puertos
- **config.vm.synced\_folder**: carpeta compartida
- **vb.memory**: memoria RAM
- **vb.name**: nombre
- **config.vm.provision**: script de instalación y configuración de software

A continuación se muestra un ejemplo de fichero Vagrantfile:

```
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
```

El fichero Vagrantfile anterior creará una máquina virtual con la siguiente configuración:
- Sistema operativo: **Ubuntu 16.04 (Xenial) de 64 bits**
- Ip privada: **192.168.33.3**
- Ip pública: **192.168.33.3**
- Redireccionamiento de puertos: **el puerto 80 de la máquina virtual s redirecciona al 8080 de la anfitriona**
- Carpeta compartida: **compartida** (corresponde a _/home/user/compartida_ en la máquina anfitrión)
- Memoria RAM: **2Gb.**
- Nombre: **newvm**
- Script de provisionamiento: **bootstrap.sh**. Un script shell con los comandos para instalar software y configurar el sistema.

## 4. Acceso a la máquina virtual

Se accede a la máquina virtual desde un terminal, por línea de comandos, situándose en primer lugar en el directorio donde se encuentra instalada y utilizando a continuación la instrucción _vagrant_ con el comando _ssh_:
```
cd newvmdir
vagrant ssh
```

Desde la máquina anfitrión se puede acceder a los servicios de la máquina virtual de varias formas:
- Mediante la Ip y el puerto de la máquina virtual:
    ```
    http:\\192.168.33.3:80
    ```
- Mediante _localhost_ (o la IP de la máquina anfitrión) y el puerto redirigido (mapeado):
    ```
    http:\\localhost:8080
    ```

    > NOTA: puede ser conveniente añadir la IP y el nombre de la máquina virtual al fichero _/etc/hosts_ de la máquina anfitrión.

## 5. Operaciones con Vagrant

El conjunto de operaciones vagrant es muy sencillo. Se puede ver el juego completo de operaciones mediante el siguiente comando:
```
vagrant -h
```

Las operaciones más utilizadas son las siguientes:

- Ejecutar la máquina virtual:
    ```
    vagrant up
    ```

- Apagar la máquina virtual:
    ```
    vagrant halt
    ```

- Entrar por SSH en la máquina virtual:
    ```
    vagrant ssh
    ```

- Poner la máquina virtual en estado de suspensión:
    ```
    vagrant suspend
    ```

- Volver a ejecutar la máquina virtual tras la suspensión:
    ```
    vagrant resume
    ```

- Comprobar el estado de la máquina virtual:
    ```
    vagrant status
    ```

- Destruir la máquina virtual: ATENCIÓN, este comando elimina la máquina virtual y borra todos sus datos.
    ```
    vagrant destroy
    ```

## 6. Referencias y más información

- Sitio web oficial de VirtualBox y página de descargas:
    - https://www.virtualbox.org/
    - https://www.virtualbox.org/wiki/Downloads
- Sitio web oficial de Vagrant y página de descargas:
    - https://www.vagrantup.com
    - https://www.vagrantup.com/downloads.html
- Vagrant boxes:
    - http://www.vagrantbox.es/
- Getting started with Vagrant:
    - https://www.vagrantup.com/docs/getting-started/
- Tutorial Vagrant 1: Qué es y cómo usarlo:
    - https://geekytheory.com/tutorial-vagrant-1-que-es-y-como-usarlo/
- Crea todo un entorno de máquinas virtuales con un solo comando, gracias a Vagrant:
    - https://www.adictosaltrabajo.com/tutoriales/vagrant-install/
- Vagrant, la herramienta para crear entornos de desarrollo reproducibles:
    - http://www.conasa.es/blog/vagrant-la-herramienta-para-crear-entornos-de-desarrollo-reproducibles/
- Vagrant: configuración básica de la máquina virtual:
    - http://www.conasa.es/blog/vagrant-configuracion-basica-de-la-maquina-virtual/
- Tres formas diferentes de instalar VirtualBox sobre Ubuntu 16.04:
    - http://somebooks.es/tres-formas-diferentes-de-instalar-virtualbox-sobre-ubuntu-16-04/
- Cómo instalar y desinstalar vagrant en Ubuntu 16.04:
    - https://www.howtoinstall.co/es/ubuntu/xenial/vagrant
    - https://www.howtoinstall.co/es/ubuntu/xenial/vagrant?action=remove
- ¿Qué son las VirtualBox Guest Additions?
    - https://sliceoflinux.wordpress.com/2009/05/04/%C2%BFque-son-las-virtualbox-guest-additions/
