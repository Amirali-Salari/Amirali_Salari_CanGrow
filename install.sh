#!/bin/bash

# Set up Docker's apt repository.
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install the Docker packages.
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify that the installation is successful by running the hello-world image.
sudo docker run hello-world

# Update the package index, and install the latest version of Docker Compose.
sudo apt-get install docker-compose-plugin

# Verify that Docker Compose is installed correctly by checking the version.
docker compose version

# Run docker-compose.yml file.
sudo docker compose up -d

sleep 10

# Executing scripts required to enable Replication in database containers.
docker exec -i amirali_salari_cangrow-mariadb_master-1 /bin/bash < ./masterdb/initial.sh
docker exec -i amirali_salari_cangrow-mariadb_replica-1 /bin/bash < ./replicadb/initial.sh

# Run the scripts needed to configure ProxySQL.
docker exec -i amirali_salari_cangrow-mariadb_master-1 /bin/bash < ./proxysql/create-monitoring-user.sh
docker exec -i amirali_salari_cangrow-proxysql-1 /bin/bash < ./proxysql/initial.sh

echo "----------------------------------------------------------------
everything is ready!
enjoy!
**********************************************************************"
