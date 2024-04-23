#!/bin/bash

sudo mkdir -p /root/.ssh
sudo touch /root/.ssh/authorized_keys

sudo echo /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

sudo chmod 700 /root/.ssh
sudo chmod 600 /root/.ssh/authorized_keys

apt-get update
apt-get install rsync
