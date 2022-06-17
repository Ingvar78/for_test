sudo apt-get update
sudo apt install mc
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER | sudo ls -la /etc/sudoers.d/
sudo ls -la /etc/sudoers.d/
sudo apt install python3
sudo apt update
sudo apt-get install python3-pip
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
pip3 install "molecule==3.4.0"
pip3 install "ansible-lint<6.0.0"
sudo apt-get install     ca-certificates     curl     gnupg     lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
pip3 install molecule_docker
ssh-keygen -o -t rsa -C "i@mail"
cat ~/.ssh/id_rsa.pub
ls -la
mkdir test &&cd test
git clone https://github.com/Ingvar78/clickhouse-role.git
getenforce
sudo apt install selinux-utils
getenforce
cd clickhouse-role/
ansible-galaxy install -r requirements.yml -p roles --force
cd roles/clickhouse/
molecule test -s centos_7
molecule
pip3 install "molecule==3.4.0"
sudo pip3 install "molecule==3.4.0"
molecule
molecule test -s centos_7
sudo pip3 install "ansible-lint<6.0.0"
molecule test -s centos_7
molecule --version
systemctl status docker
sudo usermod -aG docker $USER
systemctl restart docker
git clone https://github.com/danilabar/vector-role.git
cd vector-role/
molecule test -s centos_7
ansible-lint
