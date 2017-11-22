#!/bin/bash

# Crear un nuevo directorio y acceder a él
mkdir newvmdir
cd newvmdir

# Crear la máquina virtual
vagrant init

# Iniciar la máquina virtual
vagrant up
