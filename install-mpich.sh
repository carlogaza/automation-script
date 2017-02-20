#!/bin/bash
# MPI Installation Script
# Version : 3.2

# Extract MPICH-3.2 to /usr/local/
tar xzf /root/postinstall/apps/mpich-3.2.tar.gz -C /usr/local/

# Change folder to MPICH folder
cd /usr/local/mpich-3.2/

# Compile MPICH
./configure
make
make install
