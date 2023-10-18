sleep 30
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common net-tools htop -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get install docker-ce="5:19.03.6~3-0~ubuntu-bionic" docker-ce-cli="5:19.03.6~3-0~ubuntu-bionic" -y
systemctl enable docker.service && service docker status
sudo usermod -aG docker ubuntu
echo "Docker daemon installed and configured"
docker --version
echo "Installing helm..."
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
echo "Helm installed"
sudo helm version
echo "Installing rke..."
wget https://github.com/rancher/rke/releases/download/v1.4.1/rke_linux-amd64
sudo mv rke_linux-amd64 rke
sudo chmod +x rke
sudo mv rke /usr/local/bin
echo "rke installed.."
rke --version
echo "Installing kubectl"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y
sudo apt-get install -y kubectl
echo "Kubectl installed.."
mkdir ~/.ssh && touch ~/.ssh/authorized_keys
sudo chown ubuntu:ubuntu -R ~/.ssh
echo "Generating SSH Key-pair for non-interactive authentication"
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -q -N "" -C ubuntu@kubernetes-master.nuc.io
sudo chown ubuntu:ubuntu -R ~/.ssh
echo "Creating authorized_keys file and adding administrators public key..."
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCbaiqSRoMq2obPjFIYbmswE7V3hJivQBE82dlW1rKhHozazOMSgw6kqKb/p8WAXrDb4K1zKG4fDHvZLpd/CDbukxWMdX4Gu8SSu+XoFxrzNeqK2YYp/5QOFvJjtLBRhu2xQR1a6RUfIZj4y1IawqHFFtl35uQ2wb/0YhZzfCPLumMPGaMGQ3hQsknJX9BVPjNPBa9vjK/ViczPqW6bOOkfZURZcN17pfzWi6+KCEPEqEafdO9Ersw8H0v9xqz2CqZdNp9ihNaRVJNBUp+nRyThCOiNtSct5TeZm/bT+AKaA2587wkelCnnctbOJwXmC1FKRDQMzoy/b1gSEkUZ57Fx3vHOsRHhlXprtz14Cb4S1UB9urS8AymISR5No+JQ8k9v/AGhGWqtYHn3hL8wN0Dj2ZOHh4syD4Y/2AXmSyPUMpg7DGCn+2x4dV+QXJObGU69B/0lV7AyL336sqeJAdUKVCyY/E18VUCUCtLSB09BMYNNaQpeFaGmh/P5vG5APBE= renato@bifrost-reborn" >> ~/.ssh/authorized_keys
echo "Adding ansible-awx public key"
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHywNjeJlIWTF3avSJ5ISUE3PudZhpd9MZanEpeEA7yQu3S53Ycy8bKNYeomRCfsOvR4fr6xQcLq0f7MuMo+6qs3Gn2XCoMHhkivVDhfIBZloO9MvVujH1NfulStY0Izm1DFmwa9dUBzjqfA+d67Z2ZQ2gRDSmjqzlsjb26USEhjbqu4Zp9LKdIzCP2/sW0T/MC4rsxN9425Kp4tAqVVV2lTF99UjhxDeBYZbanqphVO5nNd7tMFOTRroJCJt7JoWbwkle0z4hG/5o/2Rc+tvW78CrH2YPHrf2Ytf7BcvD43Ou02QyM+ClX6yFdD2PdNxvoSnY3N741ToaViOhoMgUczVMN+Dl5idExbstSFA2802oeBnQnhckbhw9KABy7X+/DUU4nnraMPh8hXlv7ldJ19pxqzQ0TOEbI+u45xZh7UKcdqRqHTiR89A+doP4LgMuhvQpEX9hQIDgY+dRaAEm0r2CFZvxInkOxARN0NHjYuzXuqEJjTZ7JCaFw7IpYP8= root@ansible-awx" >> ~/.ssh/authorized_keys
echo "please verify ssh directory contents bellow"
ls -lha ~/.ssh && cat ~/.ssh/authorized_keys
echo "Installing cloud-init"
apt update -y && apt install cloud-init -y
echo "Master node dependency installation and configuration completed."
